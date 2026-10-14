# MCP Status

`dashcn` does not expose a dedicated MCP server. Use the CLI directly and prefer `--json` outputs for automation.

```bash
dashcn registries --json
dashcn list @dashcn --json
dashcn info @dashcn/button --json
dashcn dry-run @dashcn/button --json
dashcn validate --json
```

Install this skill into model folders with:

```bash
dashcn --advanced install-skill --skill dashcn-ui --model .codex
```
