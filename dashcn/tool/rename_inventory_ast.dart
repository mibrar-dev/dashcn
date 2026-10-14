// AST helpers for `tool/rename_inventory.dart`: case-insensitive `shadcn`
// text tests plus the analyzer (`parseString`) scan of one Dart source.
//
// Tool-internal API (public names only because `tool/` scripts are compiled
// as separate libraries; nothing here is exported by the package).
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Case-insensitive `shadcn` substring test.
bool containsShadcn(String text) => text.toLowerCase().contains('shadcn');

/// Number of case-insensitive `shadcn` occurrences in [text].
int countShadcn(String text) {
  final String lower = text.toLowerCase();
  int count = 0;
  int from = 0;
  while (true) {
    final int hit = lower.indexOf('shadcn', from);
    if (hit < 0) {
      return count;
    }
    count++;
    from = hit + 6;
  }
}

/// Lines whose `//` comment tail mentions shadcn (case-insensitive).
int commentHitsIn(String content) {
  int hits = 0;
  for (final String line in content.split('\n')) {
    final String trimmed = line.trimLeft();
    final String tail = trimmed.startsWith('//')
        ? trimmed
        : line.contains('//')
        ? '//${line.split('//').skip(1).join('//')}'
        : '';
    if (tail.isNotEmpty && containsShadcn(tail)) {
      hits++;
    }
  }
  return hits;
}

/// One named declaration whose name contains `shadcn` (case-insensitive).
class InventoryDeclaration {
  InventoryDeclaration(this.name, this.kind, this.offset);

  final String name;
  final String kind;
  final int offset;
}

/// Offset → 1-based line number via binary search over line starts.
class LineStarts {
  LineStarts(String content)
    : starts = <int>[
        0,
        for (
          int i = content.indexOf('\n');
          i >= 0;
          i = content.indexOf('\n', i + 1)
        )
          i + 1,
      ];

  final List<int> starts;

  int lineOf(int offset) {
    int lo = 0;
    int hi = starts.length - 1;
    while (lo < hi) {
      final int mid = (lo + hi + 1) >> 1;
      if (starts[mid] <= offset) {
        lo = mid;
      } else {
        hi = mid - 1;
      }
    }
    return lo + 1;
  }
}

/// Result of scanning one Dart source: shadcn declarations, identifier
/// reference counts and string-literal hits.
class InventoryScan {
  InventoryScan({
    required this.declarations,
    required this.references,
    required this.stringLiteralHits,
  });

  final List<InventoryDeclaration> declarations;
  final Map<String, int> references;
  final int stringLiteralHits;
}

/// Runs the analyzer scan over [content]; null when it cannot be parsed.
InventoryScan? scanDartContent(String content) {
  late final ParseStringResult parsed;
  try {
    parsed = parseString(content: content, throwIfDiagnostics: false);
  } on ArgumentError {
    return null;
  }
  final _InventoryVisitor visitor = _InventoryVisitor();
  parsed.unit.accept(visitor);
  return InventoryScan(
    declarations: visitor.declarations,
    references: visitor.references,
    stringLiteralHits: visitor.stringLiteralHits,
  );
}

/// AST visitor collecting shadcn declarations, identifier references and
/// string-literal hits. Every name test is case-insensitive on `shadcn`.
class _InventoryVisitor extends RecursiveAstVisitor<void> {
  final List<InventoryDeclaration> declarations = <InventoryDeclaration>[];
  final Map<String, int> references = <String, int>{};
  int stringLiteralHits = 0;

  void _maybeDeclare(String? name, String kind, int offset) {
    if (name != null && containsShadcn(name)) {
      declarations.add(InventoryDeclaration(name, kind, offset));
    }
  }

  String? _fragmentName(AstNode node) {
    try {
      final dynamic namePart = (node as dynamic).namePart;
      if (namePart != null) {
        return namePart.typeName.lexeme as String;
      }
    } on NoSuchMethodError {
      // No fragments namePart; fall through to the Token name.
    }
    try {
      final dynamic name = (node as dynamic).name;
      if (name == null) {
        return null;
      }
      return name.lexeme as String;
    } on NoSuchMethodError {
      return null;
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _maybeDeclare(_fragmentName(node), 'class', node.offset);
    super.visitClassDeclaration(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _maybeDeclare(_fragmentName(node), 'mixin', node.offset);
    super.visitMixinDeclaration(node);
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    _maybeDeclare(_fragmentName(node), 'extension', node.offset);
    super.visitExtensionDeclaration(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _maybeDeclare(_fragmentName(node), 'enum', node.offset);
    super.visitEnumDeclaration(node);
  }

  @override
  void visitEnumConstantDeclaration(EnumConstantDeclaration node) {
    _maybeDeclare(node.name.lexeme, 'enumConstant', node.offset);
    super.visitEnumConstantDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    final String name = node.name.lexeme;
    _maybeDeclare(
      name,
      node.isGetter || node.isSetter ? 'accessor' : 'function',
      node.offset,
    );
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    _maybeDeclare(node.name.lexeme, 'method', node.offset);
    super.visitMethodDeclaration(node);
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    _maybeDeclare(node.name.lexeme, 'variable', node.offset);
    super.visitVariableDeclaration(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    final String? name = node.name?.lexeme;
    if (name != null) {
      _maybeDeclare(name, 'constructor', node.offset);
    }
    super.visitConstructorDeclaration(node);
  }

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    _maybeDeclare(_fragmentName(node), 'typedef', node.offset);
    super.visitGenericTypeAlias(node);
  }

  @override
  void visitFunctionTypeAlias(FunctionTypeAlias node) {
    _maybeDeclare(node.name.lexeme, 'typedef', node.offset);
    super.visitFunctionTypeAlias(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    final String name = node.name;
    if (containsShadcn(name) && node.parent is! CommentReference) {
      references[name] = (references[name] ?? 0) + 1;
    }
    super.visitSimpleIdentifier(node);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    if (containsShadcn(node.value)) {
      stringLiteralHits++;
    }
    super.visitSimpleStringLiteral(node);
  }

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    if (containsShadcn(node.stringValue ?? '')) {
      stringLiteralHits++;
    }
    super.visitAdjacentStrings(node);
  }

  @override
  void visitStringInterpolation(StringInterpolation node) {
    int plain = 0;
    for (final InterpolationElement element in node.elements) {
      if (element is InterpolationString && containsShadcn(element.value)) {
        plain++;
      }
    }
    // One hit per literal part would over-count multi-line text; count the
    // whole interpolation once when any part mentions shadcn.
    if (plain > 0) {
      stringLiteralHits++;
    }
    super.visitStringInterpolation(node);
  }
}
