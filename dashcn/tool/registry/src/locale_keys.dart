// Locale-key usage for the registry manifest. A source file "uses" a locale
// key when it reads the key as a member: `strings.key`,
// `ComponentLocalizations.of(context).key(arg)`. The scan walks the parsed AST,
// so strings, comments and local names never count.

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Locale keys (members of [universe]) that the Dart file at [absPath] reads
/// as members. Returns them sorted.
List<String> localeKeysUsedIn(String absPath, Set<String> universe) {
  final result = parseString(
    content: File(absPath).readAsStringSync(),
    path: absPath,
    throwIfDiagnostics: false,
  );
  final collector = _LocaleKeyCollector(universe);
  result.unit.accept(collector);
  return collector.used.toList()..sort();
}

class _LocaleKeyCollector extends RecursiveAstVisitor<void> {
  _LocaleKeyCollector(this._universe);

  final Set<String> _universe;
  final Set<String> used = <String>{};

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (_universe.contains(node.name) && _isMemberName(node)) {
      used.add(node.name);
    }
    super.visitSimpleIdentifier(node);
  }

  /// True when [node] is the member half of `target.name`, `target.name(...)`
  /// or `prefix.name`, not the target itself or a bare local.
  bool _isMemberName(SimpleIdentifier node) {
    final parent = node.parent;
    if (parent is PrefixedIdentifier) {
      return identical(parent.identifier, node);
    }
    if (parent is PropertyAccess) {
      return identical(parent.propertyName, node);
    }
    if (parent is MethodInvocation) {
      return identical(parent.methodName, node) && parent.target != null;
    }
    return false;
  }
}
