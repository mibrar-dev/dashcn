# P8-2 — orchestrator intervention: make the codemod fast, then apply it

You were stopped by the orchestrator (not an error): `rename_api.dart --check` takes ~8 min / 3 GB per run and stalls
after 912/996 files, and you spent ~2 h polling it. Your preparation work is intact (ShadcnUI inlined, PDFs moved,
txt + barrel tools deleted, check_names + allow file, codemod files). Change strategy:

1. **Do not resolve types.** Every name in the map contains `shadcn`/`Shadcn` and is declared only in this kit, so an
   exact-name token rename is precise. Rewrite the identifier pass to use `package:analyzer` *unresolved* AST
   (`parseString`) or its scanner: rename every `SimpleIdentifier`/declaration token whose lexeme exactly equals a
   map key (plus prefix-family rules), across all Dart files, including `show`/`hide` combinators and `[Refs]` in doc
   comments. For the `shadcn`/`shadcnTheme` local → `theme` rule, use the unresolved AST to check the enclosing
   function/block for an existing `theme` declaration and report conflicts instead of renaming. Correctness is then
   enforced by `flutter analyze` + all tests afterwards. Target: a full `--check` in under 60 s.
2. **Exclude the generated mirrors** (`docs/lib/ui/shadcn/**`, and `dashcn/flutter_cli_verification_example/lib/ui/shadcn/**`
   if it is a CLI-installed copy). Apply the codemod to the sources only, then `git mv` the mirror folder(s) to
   `ui/dashcn`, update `docs/tool/sync_registry.sh` (and anything else pointing at `ui/shadcn`), and regenerate the
   mirror with `bash tool/sync_registry.sh` from the renamed `dashcn/lib/src`.
3. Never `sleep` more than 60 s at a time and never poll a run longer than 5 min. If a command is slow, make it faster.
4. Then: apply (`rename_api.dart`), `--check` clean, `check_names` 0 hits outside the allow-list, regenerate everything
   (exports, manifest, previews/blocks tests, docs data, mirror), all gates from the brief, and the final
   `rearch/reports/P8-2.md` (`status: done`, before/after counts, 10 comment before→after samples).
