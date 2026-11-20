# Avoiding AI slop

**Problem:** Text written by agents reads as generic AI prose: em dashes, filler, intensifiers, "It's not X. It's Y.", lists of three, stock openers and closers.

**Solution:** Give the agent an explicit anti-slop rule set as a skill or in `AGENTS.md`/`CLAUDE.md`, and have it check its output against the rules before returning it.

[no_ai_slop_writing_rules](https://github.com/realrossmanngroup/no_ai_slop_writing_rules) is a ready-made set: 24 rules with WRONG/RIGHT examples, a self-check pass and a banned-words list, packaged as agent skills (`skills/no-ai-slop/`). The repo also contains a voice skill for Louis Rossmann's style; take only `no-ai-slop` if you want your own voice.

## Steps

1. Install the skill, e.g. `npx skills add realrossmanngroup/no_ai_slop_writing_rules`, or copy `skills/no-ai-slop/` into `.agents/skills/` (or `.claude/skills/`).
2. Add one line to `AGENTS.md`: *"Before writing or editing prose, apply the no-ai-slop skill and run its self-check."*

## References

- [realrossmanngroup/no_ai_slop_writing_rules](https://github.com/realrossmanngroup/no_ai_slop_writing_rules)
