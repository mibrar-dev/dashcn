# Code Snippets with Syntax Colouring and Selectable Text

## Summary of Changes
Extended `CodeSnippet` to support language syntax colouring (Dart, JSON, YAML, Shell, TypeScript/JS, HTML) using theme colour tokens (`ambient.syntaxColors`), built-in copy button with animated feedback, selectable and copyable text, and horizontal line scrolling that never overflows page containers. Also made docs prose and code blocks in `docs/` selectable via `SelectableRegion` while preserving keyboard Tab navigation.

## Architecture & Customization Surface
1. **Theming & Style Overrides (`CodeSnippetTheme` & `CodeSnippetStyle`)**:
   - Visual tokens: `backgroundColor`, `borderColor`, `borderRadius`, `padding` (directional/density-aware), `textStyle`, `syntaxColors`.
   - Action & Copy tokens: `showCopyButton`, `copyIcon`, `copiedIcon`, `copyIconColor`, `copiedIconColor`, `actionSpacing`, `copyFeedbackDuration`.
   - Motion tokens: respects `ambient.motion.base` and `ambient.motion.standardCurve`, with reduced motion bypass via `MediaQuery.disableAnimations`.
2. **Builder Slots**:
   - `copyButtonBuilder`: Swap the copy button widget or custom feedback presentation.
   - `actionsBuilder`: Customize the actions row containing user actions and copy button.
   - `codeBuilder`: Customize the inner code text layout or highlighter rendering.
3. **Controlled & Uncontrolled State**:
   - `copied`: Optional external boolean for controlled state.
   - `onCopiedChange`: Callback invoked when copy state transitions.
   - Defaults to internal uncontrolled state with automatic timer reset.
4. **Syntax Highlighting & Language Auto-Detection**:
   - Extended `dashcn/lib/src/primitives/syntax_highlight/syntax_language.dart` heuristics to recognize `yaml`, `shell`/`bash`/`zsh`, `html`/`xml` alongside `dart`, `json`, and `typescript`/`javascript`.
   - Uses `ambient.syntaxColors` token map ensuring seamless contrast in both light and dark themes.
5. **Horizontal Scrolling & Selectability**:
   - Embedded within `SingleChildScrollView(scrollDirection: Axis.horizontal)` so long lines scroll horizontally inside the block without wrapping or overflowing the parent layout.
   - Wrapped code in `SelectableRegion` (with ancestor selection container awareness).
   - Wrapped `docs/lib/widgets/docs_article.dart` body in `SelectableRegion` with `FocusNode(skipTraversal: true)` so documentation prose is selectable without intercepting keyboard Tab navigation.
6. **Accessibility & Tap Targets**:
   - Ensured minimum 48px touch targets on mobile touch platforms via `TouchHitArea` and `minContainerHeight` constraints, passing `androidTapTargetGuideline` and `iOSTapTargetGuideline` scorecards.

## Modified & Created Files
- `dashcn/lib/src/components/code_snippet/code_snippet.dart`
- `dashcn/lib/src/components/code_snippet/code_snippet_style.dart`
- `dashcn/lib/src/components/code_snippet/preview.dart`
- `dashcn/lib/src/components/code_snippet/meta.json`
- `dashcn/lib/src/components/code_snippet/README.md`
- `dashcn/lib/src/primitives/syntax_highlight/syntax_language.dart`
- `dashcn/test/registry/components/code_snippet_test.dart`
- `dashcn/lib/src/manifests/registry.json`
- `dashcn/lib/src/manifests/scorecards.json`
- `docs/lib/widgets/docs_article.dart`
- `docs/lib/widgets/preview_stage.dart`
- `docs/lib/widgets/selectable_code.dart`
- Generated docs files synced via `tool/sync_registry.sh` and `tool/gen_docs_data.dart`.
- `scratchpad/ui/code/CAPTURES.md`
- Visual screenshots & interaction recording in `scratchpad/ui/code/`.
- `rearch/captures/w-code/CAPTURES.md`
- `rearch/captures/w-code/REPORT.md`
- `rearch/captures/w-code/code_snippet_interaction.webm`

## Gate Exit Codes & Verification
- `dashcn: dart format`: exit 0
- `dashcn: tool/check_names.dart`: exit 0 (0 hits)
- `dashcn: dart analyze`: exit 0 (No issues found!)
- `rearch/qa_gate.sh`: exit 0 (+6176 tests passed, 0 banned patterns, 0 theme issues)
- `dashcn: flutter test`: exit 0 (33/33 code_snippet & qa tests passed)
- `docs: flutter analyze`: exit 0 (No issues found!)
- `docs: flutter test`: exit 0 (28/28 docs unit/focus/scorecard tests passed)
- `docs: tool/gen_docs_data.dart --check`: exit 0
- `docs: tool/sync_registry.sh --check`: exit 0
- `docs: flutter build web --release`: exit 0

## Anything Not Done
All requested scope items were completed in full.

## PR URL
https://github.com/mibrar-dev/dashcn/pull/41
