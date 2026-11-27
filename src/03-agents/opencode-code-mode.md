# OpenCode Code Mode vs. direct MCP tool calls

**Problem:** OpenCode presents MCP tools to the model in Code Mode by default. This changes token use, approval prompts and reliability.

**Solution:** Keep Code Mode for servers with many tools and multi-step read workflows. Turn it off per server (`"codemode": false`) for destructive or `ask`-gated servers, servers with few tools, weaker models and debugging.

## Comparison

| | Code Mode (default for MCP tools) | Direct calls (`"codemode": false`) |
|---|---|---|
| What the model sees | One `execute` tool plus a catalog of tool signatures in the instructions (and `search(...)` if the catalog is long) | One native function schema per tool |
| How it calls a tool | Writes a short script `tools.<server>.<tool>({...})` inside `execute`, run in a confined interpreter | A normal tool call with JSON arguments |
| Strengths | Few tokens for servers with many tools; chaining, loops, filtering and parallel calls in one step; less data through the context window | Simple, predictable, easiest to read and approve, works with weaker models |
| Weaknesses | Model can mis-write paths or syntax; batched calls can trigger several prompts at once | Large tool lists cost tokens; more round trips |
| Permissions | Same per-tool check, same rules and saved rows | Same |
| Known issues | Open reports of `ask` prompts not surfacing or orphaned for parallel calls ([#51223](https://github.com/anomalyco/opencode/issues/51223), [#51224](https://github.com/anomalyco/opencode/issues/51224)) | Not affected |

## Notes

- `"execute": "deny"` turns Code Mode off; its tools then become direct tools. It does not block MCP.
- Built-in tools (read, edit, shell, …) stay direct regardless.
- OpenCode turns Code Mode off by default for servers that already implement it (e.g. executor.sh). For other such servers, set `"codemode": false` to avoid nesting.

## Code Mode outside OpenCode

- Cloudflare introduced the name. Its API server exposes only `search()` and `execute()`; the docs are marked experimental.
- Anthropic describes the same pattern as code execution with MCP: present MCP servers as code APIs instead of direct tool calls.
- Cloudflare documents using its Code Mode MCP server from Claude Code. This is server-side Code Mode and works with any MCP client.
- OpenCode's variant is client-side: `packages/codemode` is a small custom interpreter (not a V8 or Node sandbox) that wraps all connected MCP servers.
- No evidence found for built-in Code Mode in VS Code (Copilot) or other editors; check each harness's docs. In most harnesses, MCP tools are direct tool calls.

## References

- [Cloudflare: Code Mode](https://blog.cloudflare.com/code-mode/)
- [Cloudflare: Code Mode MCP](https://blog.cloudflare.com/code-mode-mcp/)
- [Anthropic: Code execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp)
- [Cloudflare: Claude Code setup](https://developers.cloudflare.com/agent-setup/claude-code/)
