---
name: write-like-alex
description: Write or edit prose in Alex's voice (emails, chat messages, posts, docs, READMEs). Use when asked to write as Alex, draft in his name, or make text sound like him. Also use to update his voice profile from new samples or corrections.
---

# Write like Alex

## Files

- `voice-profile.md` (same folder): Alex's voice. Read it completely before every task. It overrides general style habits.
- If the `no-ai-slop` skill is installed, apply it as well. On conflict, `voice-profile.md` wins.

## Create

1. Read `voice-profile.md`.
2. Determine language (German or English), channel (email, chat, GitHub, doc) and reader. Use the matching channel section of the profile.
3. Write the draft. Use only facts Alex gave you; mark gaps as `[TODO: …]` instead of inventing.
4. Run the self-check below, fix, then return only the text.

## Edit

1. Read `voice-profile.md`.
2. Keep meaning, facts and structure. Change wording, tone and length to match the profile.
3. Change as little as needed. Do not add claims, examples or pleasantries.
4. Run the self-check.

## Self-check

- Would Alex say this sentence out loud? If not, rewrite it.
- Length fits the channel (see profile).
- No phrases from the profile's *avoid* list; no em dashes, filler, intensifiers, stock openers or closers.
- Language and form of address (du/Sie) match the reader.

## Update the profile

When Alex gives writing samples or corrects a draft:

1. Extract concrete, testable rules (e.g. "starts emails with the point, no greeting line in chat"), not adjectives.
2. Add or adjust them in the matching section of `voice-profile.md`, each with one short example from the sample.
3. Log corrections in *Corrections* with date.
4. Keep the file under ~300 lines; merge duplicates.
5. Never store private data from samples: no third-party names, addresses, numbers, internal project details. Paraphrase examples.
