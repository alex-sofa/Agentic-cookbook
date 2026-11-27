# OpenCode permissions for MCP tools

**Problem:** MCP tools (e.g. a GitHub server) run without confirmation, including destructive ones.

**Solution:** Set per-tool rules under the top-level `permission` key, start each server on `ask`, and allow read-only tools explicitly.

Based on reading `anomalyco/opencode` (shallow clone, Oct 2026) and public docs; not tested against a running OpenCode.

## How a tool call is authorized

- Every MCP tool is registered as `<server-key>_<tool>`; characters outside `a-zA-Z0-9_-` become `_`. Server `my-server` with tool `list.items` becomes `my-server_list_items`. This string is the permission **action**.
- The **resource** is always `*`, because MCP tools have no path or command to match.
- Each MCP tool asks for permission itself when called; the registry does no authorization.
- "Always allow" saves `{project, action, "*"}` in the `permission` table of OpenCode's SQLite database. It covers that one tool in that project, not all MCP tools.

## Where to configure

- One project: `opencode.json` or `opencode.jsonc` in the project root (file names confirmed in `core/src/config/discovery.ts`).
- All projects: the global config directory, usually `~/.config/opencode/opencode.json` (convention, not verified in the source).

```json
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "github_*": "ask"
  }
}
```

## Rules

- `permission` takes `ask`, `allow` or `deny`, either as one value for everything or as `"pattern": action` entries (`v1/config/permission.ts`). `*` and `?` are wildcards.
- Last match wins, in the order written. Put the server wildcard first, specific rules after:

  ```json
  "permission": {
    "github_*": "allow",
    "github_delete_*": "ask",
    "github_create_issue": "deny"
  }
  ```

- A nested form `"<action-pattern>": { "<resource-pattern>": "ask" }` exists. For MCP the resource is always `*`, so use the flat form.
- A key like `"atlassian": {...}` matches only an action literally named `atlassian`, not that server's tools. Use `"atlassian_*"`.
- Effects: `allow` runs silently, `ask` prompts, `deny` on `*` also hides the tool from the model.

## Recommended policy

1. Start each server with `"<server>_*": "ask"`.
2. Allow read-only tools by name or prefix (`_get_*`, `_list_*`, `_search_*`).
3. Keep deletes and other destructive tools on `ask`; `deny` tools that must never run (e.g. `excelmcp_run_macro`).
4. Leave dispatcher tools (one tool, many actions) on `ask`: they can read or write, and OpenCode only sees the tool name.
5. Allowed reads still let an injected prompt read any file the server can open. Restrict the server itself (workspace variable, low-privilege account).

## Saved approvals override config rules

- Saved rows are appended after config rules, so a saved `allow` beats a config `ask`.
- Manage them via `GET/PATCH/DELETE /api/permission/saved[/:id]`, or delete rows in the database.
- Clear old rows before testing a new policy.

See [OpenCode Code Mode](opencode-code-mode.md) for how MCP tools are presented to the model.

## References

- OpenCode source: `core/src/config/discovery.ts`, `v1/config/permission.ts`
