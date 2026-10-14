# Brand name brainstorm — round 2 (2026-10-12)

Brief from Ibrar: easy, memorable, has meaning, recognisable the way "shadcn" is — related to that.

Availability checked 2026-10-12: pub.dev (`/api/packages/<name>`, 404 = free) and RDAP for .dev / .com
(404 = unregistered). Not checked: trademarks, GitHub org, npm, social handles.

## Taken already (avoid)
`fluttercn` (pub), `flutcn` (pub — a shadcn-style Flutter CLI), `shadcn_ui`, `shadcn_flutter`, `forui`,
`plume`, `fledge`, `tessera`, `keel`, `veneer`, `strata`, `ember`, `stencil`, `anvil`.

## A. Same family as shadcn (signals the lineage at a glance)
| Name | Meaning | pub | .dev | .com | CLI |
|---|---|---|---|---|---|
| **dashcn** | *Dash* = Flutter's mascot bird + shadcn's "cn". Rhymes with shadcn: "shadcn, for Flutter" in one word. | free | free | taken | `dashcn add button` |
| dashui | Dash + UI. Plainer, less clever. | free | free | taken | `dashui add button` |

Risk: dashcn deliberately echoes shadcn — great for discovery and SEO ("shadcn flutter"), but it ties the
identity to someone else's brand. The site design itself still has to be ours.

## B. Flutter meaning (Flutter → wings, Dash is a bird)
| Name | Meaning | pub | .dev |
|---|---|---|---|
| **Perch** | where your widgets land; a place you own | `perch` free | perchui.dev free (perch.dev taken) |
| **Roost** | your components come home to your repo | `roost` free | roostui.dev free |
| Aviary | a home for many components | `aviary` free | aviary.dev taken |
| Kestrel | a bird that hovers dead-still — precise, fast | `kestrel` free | — |

## C. Craft / own-the-code meaning
| Name | Meaning | pub | .dev |
|---|---|---|---|
| **Glaze** | themes are glazes over the same clay — 42 presets, or paste your own | `glaze`, `glaze_ui` free | glazeui.dev free |
| Kiln | shape components, then fire them in your theme | `kiln` free | kilnui.dev free |
| Swatch | every visual is a token swatch | `swatch` free | — |

## Shortlist / recommendation
1. **dashcn** — if you want instant recognition "like shadcn". Most memorable, most discoverable.
2. **Perch** — if you want your own identity with a Flutter meaning; short, friendly, own-able.
3. **Glaze** — if the theming story (Theme bridge, 42 presets) is the headline.

Package suggestion for any of them: `<name>` on pub for the CLI (`dart pub global activate dashcn`),
widgets stay copy-pasted into the user's app (no runtime package), docs at `<name>.dev` or `<name>ui.dev`.
