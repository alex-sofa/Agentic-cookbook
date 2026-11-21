# Voice profile: Alex

> Status: built from Alex's PhD thesis (English, technical, ~44k words). Covers technical and academic writing. Email and chat: general rules stated by Alex; refine from samples.

## Summary

- Every section opens with one sentence that says what follows or summarizes it.
- Claims carry numbers with units and conditions, not adjectives.
- Problem → cause → measure → result, connected with *therefore*, *hence*, *thus*.
- Limitations and failures are stated plainly, with the root cause.
- Practical lessons for the next person are written down explicitly.

## Languages

- Technical and academic text: English. Chat and requests to Claude: mostly German.
- Defines abbreviations on first use, e.g. "gravitational reference sensor (GRS)", then uses the short form.

## Tone

- Factual, sober, first person plural or passive ("we assume", "it can be observed that", "it has been shown that").
- No words that add nothing: drop intensifiers and evaluative adjectives; let the number carry the judgement (stated by Alex).
  - "this is very important" → "this is important"
  - "the excellent result shows that" → "the result shows that"
- Confident about results, open about uncertainty: "No reference method with similar performance is known to the author."
- No hype, no rhetorical questions, no exclamation marks.

## Structure

- A chapter or section opens with one short sentence that either previews what the following paragraphs cover or summarizes them. Then the details follow.
  - RIGHT: "This chapter gives a brief overview of surface metrology methods. First, general methods are discussed, followed by methods for spheres."
  - RIGHT: "The differential instrument aims to improve on the previous setup by measuring without a reference."
  - WRONG: starting directly with the first detail, a rhetorical question or a broad statement about importance.
- Announces the order of the following parts: "First … Then … Finally …", "In the following, the setup is introduced and the performance is demonstrated."
- Recurring section pattern for experiments and projects: setup → model/approach → evaluation → results → conclusion.
- Short noun-phrase paragraph headings: "Stage tilt coupling", "Wedged optical elements", "Practical remarks".
- Conclusions follow a fixed order: what was achieved (with number) → what still falls short → root cause → next step.
  - Example pattern: "The setup reaches X. The error still exceeds the requirement. The root cause is Y. To overcome this, Z is proposed in the following section."
- Key takeaways go into a highlighted box or a one-paragraph summary at the start of a chapter.
- Details that would interrupt the flow go into a side note, footnote or appendix, with a pointer: "See section X for details."

## Sentence structure

- Medium-length declarative sentences; one claim per sentence, often followed by the reason or consequence in the next.
- Cause and effect made explicit: *therefore, hence, thus, as a result, this is caused by, the root cause is*.
- Conditions stated with the number: "at vacuum conditions", "for a rotation rate of 100 µrad/s", "at ambient conditions".
- Comparisons quantified: "a factor of 5", "100-fold reduction", "reduced by 40 %", "from 8.8 nm to 6.8 nm".
- Occasional concrete analogy for scale, at most one per chapter: "like aiming at a one-cent coin in Berlin from New York."

## Vocabulary

**Prefer:** concrete nouns and names of the actual thing (device type, method, parameter); *approximately*, *typically*, *in particular*, *for instance*, *however*, *in contrast*; verbs like *demonstrate, show, characterize, mitigate, suppress, limit, compensate*.

**Avoid:** words that add no information: intensifiers (*very, really, highly, extremely, significantly* without a number) and evaluative adjectives (*excellent, great, outstanding, unprecedented*); unquantified praise (*groundbreaking, game-changing, revolutionary*); filler (*it is important to note*, *in today's world*); "not X but Y" constructions; em dashes; sweeping importance statements without a source.

## Formatting

- Prose by default. Lists only for enumerations of equal items (advantages, procedure steps labelled (a)…(f), assumptions 1…n).
- Tables for comparisons with numbers; figures referenced in the text before they appear ("Figure X shows …").
- Practical tips in a separate, labelled box ("Technical remarks"), naming the specific device or setting that caused trouble and what fixed it.
- Equations and parameters introduced with symbol, value and unit.

## Openers and closers

- Opener: the overview or summary sentence (see Structure). No greeting phrases, no "In this section, we will dive into".
- Closer: the remaining limitation or the next step. No generic wrap-up ("In conclusion, X is a promising field").

## Channels

### Email and chat (general)

Short, precise and factual (stated by Alex).

- **Short:** the point or the request in the first sentence; only the details the reader needs to act.
- **Precise:** concrete facts, numbers, dates and names of things; a clear ask with owner and deadline if something is needed.
- **Factual:** no small talk, no flourishes, no exaggerated politeness or apologies.

### Email

- Rules above. Greeting and closing short and conventional.

### Chat (Teams, Signal, …)

- Rules above, even shorter: usually one to three sentences, no greeting needed.

### GitHub, docs, READMEs

- Same rules as technical writing, shorter: overview sentence, steps, numbers, known limitations.

### Academic / technical documents

- Full structure rules apply. Cite a source for every claim that is not the author's own result.
- Own previous work is marked as such when reused.
- Lessons learned are addressed to future readers explicitly ("this part addresses future experimenters").

## Examples

- WRONG: "Gravitational waves are one of the most important discoveries in physics. They have the potential to unlock many secrets about our universe."
  RIGHT: "Space-borne detectors extend the arm length to millions of kilometres and thus reach frequencies below 10 Hz, which ground-based detectors cannot observe."
  (The thesis itself marks a paragraph of the WRONG kind as AI-generated.)
- WRONG: "The new setup performs really well."
  RIGHT: "The setup reaches a per-pixel repeatability of 2 nm, a factor of 3 better than the previous setup."
- WRONG: "We tried a phase lock, but it didn't help much."
  RIGHT: "The phase-locked loop increased the total noise and caused phase jumps. Hence, it was typically not used; stray light was instead controlled with laser frequency sweeps."

## Corrections

- 2026-11-20: Section-opening rule added (stated by Alex).
- 2026-11-21: Profile built from PhD thesis.
- 2026-11-21: Communication style stated: short, precise, factual.
- 2026-11-21: Drop words that add nothing (intensifiers, evaluative adjectives); replaces the earlier "evaluative words only next to a number" rule.
