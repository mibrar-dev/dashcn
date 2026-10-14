# P8-2 — orchestrator approval of rename_map.yaml (resume instructions)

The map is APPROVED, including all `proposed: true` entries, the `ShadcnUI` removal (inline into `_buildApp`, delete
the class, rewrite its 2 tests), bundle ids `com.example.dashcnExample`, skills dirs `dashcn-kit`/`dashcn-ui`, and the
manifest contract strings `ui/shadcn` → `ui/dashcn` (P8-3 will follow them). Apply these changes before step 3:

1. **Comments rule (important).** Many comments cite the upstream web design as the spec ("shadcn `grid gap-3`",
   "shadcn v4 Field", "matches shadcn"). Do NOT turn those into "dashcn" (that would be false). Order of passes:
   (a) identifier renames, including `[ShadcnX]` doc references and `ShadcnX` words inside comments, via the map;
   (b) the specific string rules; (c) inside Dart comments, any remaining lowercase/CamelCase `shadcn`/`Shadcn` used
   as a word → `upstream` (`shadcn's` → `upstream's`, `shadcn/ui` → `the upstream web kit`); (d) in Markdown
   (`*.md`, skills, READMEs): `shadcn/ui` → `the upstream web kit`, everything else falls back to `dashcn`; (e) every
   other remaining text → fallback `dashcn`/`Dashcn`/`DASHCN`. Add these as explicit rules in rename_map.yaml.
2. **Allow-list approved** (3 entries): the `shadcn/ui` attribution line (only in a credits sentence — README "Credits"
   and the docs introduction page; add that sentence if missing: "Design inspired by shadcn/ui."), the
   `github.com/mibrar-dev/shadcn_flutter_kit` URLs, the `flutter-shadcn.github.io` schema `$id`. Nothing else.
3. **Scope extension (now in your Owns):** `git mv` the two `flutter_shadcn_complete_user_guide.pdf` files to
   `dashcn_complete_user_guide.pdf` and update every link/reference to them; `git rm`
   `dashcn/dart_analyze_flutter_shadcn_kit.txt` and drop its `.pubignore` line.
4. Then do steps 3–6 of the brief (codemod with `--check`, `check_names` guardrail + qa_gate wiring, JS bridge events,
   regenerate everything) and all gates. Finally overwrite `rearch/reports/P8-2.md` with the final report
   (`status: done`), including the before/after `shadcn` counts per area (after should be 0 outside the allow-list) and
   10 sample before→after comment lines so the orchestrator can check rule 1.
