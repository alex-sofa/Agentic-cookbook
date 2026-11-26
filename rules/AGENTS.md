# Personal agent rules

Global rules for all coding agents working for Alex. Copy or symlink this file to the agent's global instruction file (see the table at the end).

## Git commits

- Commit with Alex's GitHub identity: `user.name` and `user.email` of the GitHub account `alex-sofa`. Use the noreply address from *GitHub → Settings → Emails*, never a private email address.
- Every AI-generated commit message ends with this line:

  ```
  Made with 🤖
  ```

- No other attribution lines (no `Co-Authored-By`, no tool or session links).

## Where to put this file

| Agent | Global instruction file |
|---|---|
| OpenCode | `~/.config/opencode/AGENTS.md` |
| Claude Code | `~/.claude/CLAUDE.md` |
| Codex CLI | `~/.codex/AGENTS.md` |
