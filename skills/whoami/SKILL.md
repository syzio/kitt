---
name: whoami
description: Explains what kitt is, how its skills fit together, and which one to use next. Use when the user runs /kitt:whoami, asks what kitt is or what it can do, or asks which kitt skill fits their situation.
---

# whoami

Teach the user kitt in a few minutes. Read `references/conventions.md` first, so what you say about artifacts and rules is accurate.

## What to say

1. **One line on kitt.** Spec-driven development and writing tools. Claude proposes, the user decides, and every stage leaves an artifact the next stage reads.
2. **The main flow**, in order:

   constitution → specify → clarify → plan → tasks → analyze → implement → converge

   One line each on what the stage produces. Then name the side paths: assess before specify for an idea that may not be worth building; tinyspec for a small change; refine when the spec changes mid-build; critique to attack a spec or plan; checklist for domain review; verify to prove scenarios in the real app; ticket-push to send tasks to a tracker.
3. **The other skills.** Take the list of `kitt:` skills available in this session as the source, not memory. If the session lists none, list the folders in `${CLAUDE_PLUGIN_ROOT}/skills/` instead. Group the rest by job: code (bug, tdd, architect, how, blast-radius, interrogate, correct), writing (unslop, technical-writing) and conversation (in-your-own-words, sharpen, bro). Name any kitt skill in the session that fits none of these groups. Mark the skills that run only when called by name, the ones with `disable-model-invocation: true` in their frontmatter.
4. **Where things live.** One line from "Where artifacts live" in conventions for the current place: files in a repository, Docs in chat.
5. **Where to start.** Look at what exists before you suggest a skill. In a repository, check for the constitution, `.specify/feature.json` and the feature folder. Suggest one next skill, with the reason.

## When the user asks something specific

If the user names a situation, such as "I have a bug" or "the spec changed", skip the tour. Name the one skill that fits, say why in a sentence, and name the skill that usually follows it.

## Rules

- Change nothing and write no files.
- Keep the whole reply under about 40 lines. Offer to go deeper on any skill instead of explaining all of them.
- Use plain words per `references/writing.md`.
