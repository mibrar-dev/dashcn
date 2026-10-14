// Theme-collision scopes for the P8-2 codemod (`rename_api.dart`).
//
// Renaming a `shadcn`/`shadcnTheme` local or parameter to `themeData` is
// skipped inside scopes that already bind or read `themeData`; the codemod
// reports those instead of renaming. Tool-internal API (public names only
// because `tool/` scripts compile as separate libraries).
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rename_api_names.dart';

/// Function/method/constructor scopes where a theme-target rename would
/// collide with an existing `themeData` binder, shadow one that is read, or
/// hit a shadowed re-declaration. Conservative: any doubt blocks the scope
/// and the codemod reports it instead of renaming.
Set<AstNode> themeBlockedScopes(CompilationUnit unit, Set<String> targets) {
  final _ScopeScan scan = _ScopeScan(targets);
  unit.accept(scan);
  if (scan._topOldDecls > 0 && scan._topTheme) {
    scan.blocked.add(unit);
  }
  return scan.blocked;
}

/// One function-like scope frame under inspection.
class _ScopeFrame {
  _ScopeFrame(this.node, this.classThemeFields);

  final AstNode node;
  final Set<String> classThemeFields;
  int oldDecls = 0;
  int themeBinders = 0;
  int themeReads = 0;
}

/// One class-like scope frame under inspection (for old-name fields).
class _ClassFrame {
  _ClassFrame(this.node);

  final AstNode node;
  bool oldField = false;
  bool themeField = false;
}

class _ScopeScan extends RecursiveAstVisitor<void> {
  _ScopeScan(this.targets);

  final Set<String> targets;
  final Set<AstNode> blocked = <AstNode>{};
  final List<_ScopeFrame> _functions = <_ScopeFrame>[];
  final List<Set<String>> _classFields = <Set<String>>[];
  final List<_ClassFrame> _classes = <_ClassFrame>[];
  int _topOldDecls = 0;
  bool _topTheme = false;

  static String _stripped(String name) {
    String rest = name;
    while (rest.startsWith('_')) {
      rest = rest.substring(1);
    }
    return rest;
  }

  void _enterFunction(AstNode node) {
    _functions.add(
      _ScopeFrame(
        node,
        _classFields.isEmpty ? const <String>{} : _classFields.last,
      ),
    );
  }

  void _exitFunction() {
    final _ScopeFrame frame = _functions.removeLast();
    if (frame.oldDecls == 0) {
      return;
    }
    final bool classFieldRead =
        frame.classThemeFields.contains('themeData') && frame.themeReads > 0;
    if (frame.themeBinders > 0 || frame.oldDecls > 1 || classFieldRead) {
      blocked.add(frame.node);
    }
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    _enterFunction(node);
    super.visitFunctionDeclaration(node);
    _exitFunction();
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    _enterFunction(node);
    super.visitMethodDeclaration(node);
    _exitFunction();
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    _enterFunction(node);
    super.visitConstructorDeclaration(node);
    _exitFunction();
  }

  void _enterClass(AstNode node) {
    _classFields.add(<String>{});
    _classes.add(_ClassFrame(node));
  }

  void _exitClass() {
    _classFields.removeLast();
    final _ClassFrame frame = _classes.removeLast();
    if (frame.oldField && frame.themeField) {
      blocked.add(frame.node);
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _enterClass(node);
    super.visitClassDeclaration(node);
    _exitClass();
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _enterClass(node);
    super.visitMixinDeclaration(node);
    _exitClass();
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    _enterClass(node);
    super.visitExtensionDeclaration(node);
    _exitClass();
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _enterClass(node);
    super.visitEnumDeclaration(node);
    _exitClass();
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    if (_classFields.isNotEmpty) {
      for (final VariableDeclaration variable in node.fields.variables) {
        _classFields.last.add(variable.name.lexeme);
      }
    }
    super.visitFieldDeclaration(node);
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    final String name = _stripped(node.name.lexeme);
    if (_functions.isNotEmpty) {
      final _ScopeFrame frame = _functions.last;
      if (targets.contains(name)) {
        frame.oldDecls++;
      }
      if (name == 'themeData') {
        frame.themeBinders++;
      }
    } else if (_classes.isNotEmpty) {
      // Class field (visited outside any function).
      final _ClassFrame frame = _classes.last;
      if (targets.contains(name)) {
        frame.oldField = true;
      }
      if (name == 'themeData') {
        frame.themeField = true;
      }
    } else {
      // Top-level variable.
      if (targets.contains(name)) {
        _topOldDecls++;
      }
      if (name == 'themeData') {
        _topTheme = true;
      }
    }
    super.visitVariableDeclaration(node);
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    if (_functions.isNotEmpty) {
      final _ScopeFrame frame = _functions.last;
      for (final FormalParameter param in node.parameters) {
        final String? lexeme = parameterNameToken(param)?.lexeme;
        if (lexeme == null) {
          continue;
        }
        final String name = _stripped(lexeme);
        if (targets.contains(name)) {
          frame.oldDecls++;
        }
        if (name == 'themeData') {
          frame.themeBinders++;
        }
      }
    }
    super.visitFormalParameterList(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (node.name != 'themeData' ||
        node.offset < 0 ||
        insideCommentReference(node)) {
      super.visitSimpleIdentifier(node);
      return;
    }
    final AstNode? parent = node.parent;
    if (parent is FormalParameter) {
      super.visitSimpleIdentifier(node);
      return; // Parameter name position: a binder, counted above.
    }
    // Position checks use offsets: fragment getters may project a fresh
    // wrapper node per access, so identity is unreliable.
    if (parent is PropertyAccess && parent.propertyName.offset == node.offset) {
      super.visitSimpleIdentifier(node);
      return; // `x.themeData`: unaffected by a local rename.
    }
    if (parent is PrefixedIdentifier &&
        parent.identifier.offset == node.offset) {
      super.visitSimpleIdentifier(node);
      return; // `x.themeData`: unaffected by a local rename.
    }
    if (_functions.isNotEmpty) {
      _functions.last.themeReads++;
    }
    super.visitSimpleIdentifier(node);
  }
}
