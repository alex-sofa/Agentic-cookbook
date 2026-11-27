# OpenCode permissions for MCP tools

**Problem:** MCP tools (e.g. a GitHub server) run without confirmation, including destructive ones.

**Solution:** Set rules under the top-level `permission` key in the OpenCode config. Each rule maps a tool pattern to `ask`, `allow` or `deny`.

## Where

- One project: `opencode.json` or `opencode.jsonc` in the project root. These file names are confirmed in `core/src/config/discovery.ts`.
- All projects: `~/.config/opencode/opencode.json`. This is the usual convention; not verified in the source.

```json
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "github_*": "ask"
  }
}
```

## Rules

- `permission` takes `ask`, `allow` or `deny`, either as one value for everything or as `"pattern": action` entries (`v1/config/permission.ts`).
- Last match wins, in the order written. Put broad rules first, specific ones after:

  ```json
  "permission": {
    "github_*": "allow",
    "github_delete_*": "ask",
    "github_create_issue": "deny"
  }
  ```

- MCP tool keys have the form `<mcp>_<tool>`. `<mcp>` is the server name from the `mcp` config block; characters outside `a-zA-Z0-9_-` are replaced by `_`. The tool name is sanitized the same way: server `my-server` with tool `list.items` becomes `my-server_list_items`.

## References

- OpenCode source: `core/src/config/discovery.ts`, `v1/config/permission.ts`
