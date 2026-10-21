# Code Snippet Visual Captures

All captures taken using `agent-browser` (session `w-code`, headless) running against the production web release build served on port 8876 (`http://localhost:8876/#/docs/components/code_snippet`).

## Captures Index

| File | Resolution / Mode | Description | Status |
|------|-------------------|-------------|--------|
| `code_snippet_1280_light.png` | 1280x800 (Light) | Desktop view of CodeSnippet doc page, header, and default preview | Clean, passes visual review |
| `code_snippet_1280_dark.png` | 1280x800 (Dark) | Desktop view in dark mode, showing dark syntax highlighting tokens | Clean, passes visual review |
| `code_snippet_375_light.png` | 375x812 (Light) | Mobile phone view, responsive layout, no RenderFlex overflow | Clean, passes visual review |
| `code_snippet_375_dark.png` | 375x812 (Dark) | Mobile phone view in dark mode, responsive layout, no overflow | Clean, passes visual review |
| `code_snippet_example_with_actions.png` | Desktop | Example showing `CodeSnippet` with custom action buttons (Copy, Run) and status text | Clean, passes visual review |
| `code_snippet_example_long_lines.png` | Desktop | Example showing long lines scrolling horizontally inside the block without overflowing | Clean, passes visual review |
| `code_snippet_example_languages.png` | Desktop | Language switching example with tabs for Dart, JSON, YAML, Shell, TypeScript, HTML | Clean, passes visual review |
| `code_snippet_example_languages_json.png` | Desktop | Active JSON highlighting tab rendering JSON syntax with theme color tokens | Clean, passes visual review |
| `code_snippet_example_customized.png` | Desktop | Fully customized code snippet using `CodeSnippetStyle` and builder slots | Clean, passes visual review |
| `code_snippet_examples_section.png` | Desktop | Comprehensive view of the Examples section | Clean, passes visual review |
| `code_snippet_examples_cards.png` | Desktop | Overview cards for the example implementations | Clean, passes visual review |
| `code_snippet_full_page.png` | Desktop | Top-of-page view of documentation header and navigation | Clean, passes visual review |
| `code_snippet_scrolled.png` | Desktop | Scrolled view showing Trust Scorecard (all checks passing) and Usage | Clean, passes visual review |
| `code_snippet_interaction.webm` | Video (WebM) | Interaction recording: opening docs page, switching languages, clicking copy button (animated feedback), scrolling | Clean, 60fps interaction |

## Visual Review Observations
- **Syntax Coloring**: The token coloring correctly draws from `AmbientTheme.syntaxColors` (keywords, strings, numbers, comments, punctuation, types) in both light and dark modes.
- **Selectable Text**: Text inside code blocks and documentation prose is selectable via Flutter `SelectableRegion` without blocking keyboard tab navigation.
- **Horizontal Scrolling**: Long lines cleanly scroll horizontally within `SingleChildScrollView(scrollDirection: Axis.horizontal)` with zero document overflow.
- **Mobile Touch Targets**: `TouchHitArea` ensures min 48px tap targets on mobile touch environments while retaining a compact 28x28 visual appearance on desktop.
- **Nothing looks wrong**: All controls, contrast ratios, radii, typography, and animations adhere to dashcn guidelines.
