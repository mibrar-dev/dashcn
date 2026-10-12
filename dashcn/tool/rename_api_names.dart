// Declaration-name handling for the P8-2 codemod (`rename_api.dart`).
//
// The analyzer fragments AST models most declared names as tokens rather
// than identifier nodes, so the token-based identifier pass cannot see them.
// This module renames them instead. Tool-internal API (public names only
// because `tool/` scripts compile as separate libraries).
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rename_api_map.dart';

/// True when [node] sits inside a doc-comment `[Ref]` (e.g. the qualifier in
/// `[ShadcnThemeData.radiusLg]` parses as AST below a [CommentReference]).
bool insideCommentReference(AstNode node) {
  AstNode? current = node.parent;
  while (current != null) {
    if (current is CommentReference) {
      return true;
    }
    current = current.parent;
  }
  return false;
}

/// Identifier without leading `_`s.
String stripHead(String token) {
  String head = token;
  while (head.startsWith('_')) {
    head = head.substring(1);
  }
  return head;
}

/// Name token of a formal parameter across analyzer versions (unwraps
/// default wrappers; a node when the version models it so).
({int offset, int length, String lexeme})? parameterNameToken(
  FormalParameter node,
) {
  FormalParameter current = node;
  try {
    final dynamic inner = (current as dynamic).parameter;
    if (inner is FormalParameter) {
      current = inner;
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    // No `parameter` accessor: not a default wrapper.
  }
  try {
    final dynamic name = (current as dynamic).name;
    if (name is SimpleIdentifier) {
      return null; // A node: the identifier pass covers it.
    }
    final dynamic lexeme = name?.lexeme;
    final dynamic offset = name?.offset;
    final dynamic length = name?.length;
    if (lexeme is String && offset is int && length is int && offset >= 0) {
      return (offset: offset, length: length, lexeme: lexeme);
    }
    return null;
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    return null;
  }
}

/// Replacement for one identifier [token] (leading `_` preserved), or null
/// when the map has no rule for it. Removals return null (reported upstream).
String? replacementFor(RenameMap map, String token) {
  if (map.identifiers.containsKey(token)) {
    return map.identifiers[token];
  }
  final String head = stripHead(token);
  final String underscores = token.substring(0, token.length - head.length);
  if (map.removals.contains(head) || map.identifiers.containsKey(head)) {
    final String? to = map.identifiers[head];
    return to == null ? null : underscores + to;
  }
  if (map.removals.contains(token)) {
    return null;
  }
  for (final MapEntry<String, String> prefix in map.prefixes) {
    if (head.startsWith(prefix.key)) {
      return underscores + prefix.value + head.substring(prefix.key.length);
    }
  }
  return null;
}

/// Name token of a declaration across analyzer versions: the fragments AST
/// keeps `namePart.typeName`, older shapes keep a `name` Token. When the
/// version models the name as a node, returns null so the identifier pass
/// (which visits nodes) covers it and no edit overlaps.
({int offset, int length, String lexeme})? declarationNameToken(AstNode node) {
  dynamic holder;
  try {
    final dynamic namePart = (node as dynamic).namePart;
    if (namePart != null) {
      holder = namePart.typeName;
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    holder = null;
  }
  holder ??= (() {
    try {
      return (node as dynamic).name;
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return null;
    }
  })();
  if (holder == null || holder is AstNode) {
    return null;
  }
  try {
    final int offset = holder.offset as int;
    final int length = holder.length as int;
    final String lexeme = holder.lexeme as String;
    if (offset < 0) {
      return null;
    }
    return (offset: offset, length: length, lexeme: lexeme);
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    return null;
  }
}

/// Declaration renames in [unit]: edits as raw tuples, removal leftovers,
// theme-collision reports, and the taken offsets (so the identifier pass
// skips them).
({
  List<(int, int, String)> edits,
  List<String> unhandled,
  List<String> conflicts,
  Set<int> offsets,
})
collectDeclarationNames(
  CompilationUnit unit,
  RenameMap map,
  Set<AstNode> blocked,
  Set<String> themeTargets,
) {
  final _DeclarationVisitor visitor = _DeclarationVisitor(
    map,
    blocked,
    themeTargets,
  );
  unit.accept(visitor);
  return (
    edits: visitor.renames,
    unhandled: visitor.unhandled.toSet().toList()..sort(),
    conflicts: visitor.conflicts.toSet().toList()..sort(),
    offsets: visitor.offsets,
  );
}

/// True when [node] sits under a blocked scope.
bool _underBlocked(AstNode node, Set<AstNode> blocked) {
  AstNode? current = node.parent;
  while (current != null) {
    if (blocked.contains(current)) {
      return true;
    }
    current = current.parent;
  }
  return false;
}

/// Collects renames for declaration-name tokens (classes, enums, functions,
/// methods, variables, named constructors, typedefs, enum constants),
/// parameter names and call-site argument labels.
class _DeclarationVisitor extends RecursiveAstVisitor<void> {
  _DeclarationVisitor(this.map, this.blocked, this.themeTargets);

  final RenameMap map;
  final Set<AstNode> blocked;
  final Set<String> themeTargets;
  final List<(int, int, String)> renames = <(int, int, String)>[];
  final List<String> unhandled = <String>[];
  final List<String> conflicts = <String>[];
  final Set<int> offsets = <int>{};

  void _emitThemed(AstNode scopeNode, int offset, int length, String lexeme) {
    if (!offsets.add(offset)) {
      return;
    }
    final String head = stripHead(lexeme);
    if (map.removals.contains(head)) {
      unhandled.add('$lexeme @$offset');
      return;
    }
    final String? to = replacementFor(map, lexeme);
    if (to == null) {
      return;
    }
    if (themeTargets.contains(head) && _underBlocked(scopeNode, blocked)) {
      conflicts.add('`$lexeme` kept: `themeData` collision @$offset');
      return;
    }
    renames.add((offset, length, to));
  }

  void _named(AstNode node) {
    final info = declarationNameToken(node);
    if (info == null) {
      return;
    }
    _emitThemed(node, info.offset, info.length, info.lexeme);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _named(node);
    super.visitClassDeclaration(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _named(node);
    super.visitMixinDeclaration(node);
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    _named(node);
    super.visitExtensionDeclaration(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _named(node);
    super.visitEnumDeclaration(node);
  }

  @override
  void visitEnumConstantDeclaration(EnumConstantDeclaration node) {
    _named(node);
    super.visitEnumConstantDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    _named(node);
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    _named(node);
    super.visitMethodDeclaration(node);
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    _named(node);
    super.visitVariableDeclaration(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    _named(node);
    super.visitConstructorDeclaration(node);
  }

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    _named(node);
    super.visitGenericTypeAlias(node);
  }

  @override
  void visitFunctionTypeAlias(FunctionTypeAlias node) {
    _named(node);
    super.visitFunctionTypeAlias(node);
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    for (final FormalParameter param in node.parameters) {
      final info = parameterNameToken(param);
      if (info == null) {
        continue;
      }
      _emitThemed(param, info.offset, info.length, info.lexeme);
    }
    super.visitFormalParameterList(node);
  }

  @override
  void visitNamedArgument(NamedArgument node) {
    final Token label = node.name;
    if (label.offset >= 0) {
      final String head = stripHead(label.lexeme);
      if (map.removals.contains(head) && !map.identifiers.containsKey(head)) {
        if (offsets.add(label.offset)) {
          unhandled.add('${label.lexeme}: @${label.offset}');
        }
      } else {
        final String? to = replacementFor(map, label.lexeme);
        if (to != null && offsets.add(label.offset)) {
          if (themeTargets.contains(head) && _siblingThemeLabel(node)) {
            conflicts.add(
              '`${label.lexeme}:` kept: duplicate `themeData:` label '
              '@${label.offset}',
            );
          } else {
            renames.add((label.offset, label.length, to));
          }
        }
      }
    }
    super.visitNamedArgument(node);
  }

  /// Whether a sibling argument in the same call is already labelled
  /// `themeData`.
  bool _siblingThemeLabel(NamedArgument node) {
    final AstNode? parent = node.parent;
    if (parent is! ArgumentList) {
      return false;
    }
    for (final Argument argument in parent.arguments) {
      if (argument is NamedArgument &&
          !identical(argument, node) &&
          argument.name.lexeme == 'themeData') {
        return true;
      }
    }
    return false;
  }
}
