# Personal agent rules

**Problem:** Every agent (OpenCode, Claude Code, Hermes, …) needs the same personal conventions, e.g. for commits.

**Solution:** Keep one global rules file in this repo, [`rules/AGENTS.md`](https://github.com/alex-sofa/Agentic-cookbook/blob/main/rules/AGENTS.md), and link it into each agent's global instruction file.

## Current rules

- Commits use the GitHub identity (`alex-sofa`, noreply email), never a private address.
- AI-generated commit messages end with `Made with 🤖`. No other attribution lines.

## Steps

```sh
git clone https://github.com/alex-sofa/Agentic-cookbook ~/agentic-cookbook
ln -sf ~/agentic-cookbook/rules/AGENTS.md ~/.config/opencode/AGENTS.md   # OpenCode
ln -sf ~/agentic-cookbook/rules/AGENTS.md ~/.claude/CLAUDE.md            # Claude Code
```

Set the identity once per machine (noreply address from *GitHub → Settings → Emails*):
```sh
git config --global user.name "Alex Schultze"
git config --global user.email "<ID>+alex-sofa@users.noreply.github.com"
```

## Notes

- A symlink keeps all agents on the same rules after `git pull`. On Windows, copy the file instead or use `mklink`.
- Project-level `AGENTS.md` files add to these rules; they do not replace them.
