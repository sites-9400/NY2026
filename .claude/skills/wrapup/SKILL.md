---
name: wrapup
description: Close out a Travel Companion working session — recap what actually changed on the trip site, record decisions and their reasoning in the trip's planning notes, and list what's still open. Use this whenever the user says "wrap up", "wrap this up", "let's stop here", "summarise the session", "what did we do today", "I'm done for now", "before I go", or otherwise signals a session is ending. Also use it before a long break, before handing planning to someone else, or when the user asks what state the trip page is in after a long stretch of work.
---

# Session wrap-up

Scoped to the Travel Companion workspace. Other workspaces have their own
wrap-up; don't carry conventions between them.

A long session ends with a lot of state living only in the conversation: what was
tried, what was rejected and why, what's half-finished, what looked done but
wasn't verified. The next session starts cold. This skill turns that into a short
written record so the reasoning survives.

Two outputs, and they're different lengths on purpose:

1. **A recap in chat** — what changed, what's live, what's still open.
2. **An appended entry in the project's running log** — dated, terse, decisions
   and their *why*. This is the part that has to survive.

## Gather evidence before writing a word

Recall at the end of a long session is lossy and biased toward the last twenty
minutes. Reconstructing from memory produces a wrap-up that's confidently wrong
about the middle. Look at what actually happened:

```sh
git log --oneline -20                    # what landed
git status --short                       # what's uncommitted
git diff --stat HEAD~<n>                 # scale of the change
```

**If the session touched the published site, confirm the live page really has the
change** — don't trust that "Deploy complete" means it reached anyone:

```sh
curl -s "https://travel-f412b.web.app/<slug>/?cb=$RANDOM" | grep -c "<something new>"
```

Two things have bitten here and will again:

- **Firebase's CDN propagates a beat after the deploy returns.** A check run in
  the same breath as the deploy can read the old page and look like a failure.
  Re-check a few seconds later before concluding anything is broken.
- **A stale stylesheet looks exactly like broken CSS.** If the page renders
  unstyled, compare the live file against the local one before touching the
  markup — `site.css` is versioned in the `<link>` for this reason, and the
  version needs bumping whenever the stylesheet changes.

If there's no git repo, fall back to what you changed in this conversation, and
say in the recap that the record is reconstructed rather than verified.

## Be honest about status

The most useful thing a wrap-up does is stop the next session from assuming
finished work is finished. Sort everything into one of these, and don't blur them:

- **Done and verified** — you ran it, saw it work, and can say how you checked.
- **Done, not verified** — the change is in, nothing confirmed it.
- **Attempted, didn't work** — say what failed and what you learned. This is
  often the most valuable entry, because it stops someone repeating it.
- **Not started** — decided but untouched.

If something was fixed *after* you'd already claimed it worked, say so plainly.
A wrap-up that quietly launders a mistake is worse than no wrap-up.

## The log entry

The record for a trip lives in **`<trip-folder>/notes/planning.md`**, under its
`## Decisions made` list — for example `2026-12-SEA/notes/planning.md`. Append
there. If the session changed how the workspace itself works rather than a
specific trip — the design system, the deploy process, a convention — that
belongs in `CLAUDE.md` instead, because it applies to every future trip.

Append; don't rewrite history, and don't duplicate an entry that's already there.
A decision that reverses an earlier one gets a new dated entry saying so, rather
than an edit to the old line — the fact that it changed is itself the useful part.

Keep entries short — a few lines each. The chat recap can be generous; the log
should be scannable a month later. Use absolute dates, never "today" or
"yesterday", because the file outlives the session.

```markdown
- *2026-07-25* · Switched trip pages from cream to a white ground and Helvetica
  throughout. Reason: the cream read as a default template rather than a choice.
- *2026-07-25* · Overland Singapore→Bangkok confirmed, but the 16h sleeper is
  **not decided** — flying the last hop from Hat Yai costs ~₱2k more and buys a
  night in Bangkok before New Year's Eve. Waiting on the user.
```

Record the **why**, not just the what. "Moved to Helvetica" is worth nothing in
six weeks; "moved to Helvetica because the cream ground read as a default
template" means nobody argues it back around.

## What belongs in the log vs. what doesn't

Worth recording: decisions and their reasoning; things rejected and why;
constraints discovered the hard way; anything that was surprising, expensive to
find out, or that contradicts a reasonable assumption.

Not worth recording: a narration of every file touched (git already has it), or
restating what the code plainly says. If an entry adds nothing a reader couldn't
get from the repo in ten seconds, cut it.

## The chat recap

Lead with what materially changed and where it now lives — a URL, a branch, a
file. Then the open items, as decisions waiting on the user rather than a vague
todo list. Say who's blocked on what.

If the session left a landmine, put it up front, not in a closing footnote. In
this workspace the recurring ones are:

- Something private reaching a place it shouldn't. **The repo is public** and the
  hosting URL is unlisted rather than secret. Booking references, passport
  details and the Hong Kong money records are gitignored — if a session added a
  file, confirm it didn't land somewhere shared.
- A booking whose window is closing. Peak-season trains, theme-park tickets and
  New Year's Eve venues sell out, and a deadline noticed in conversation is lost
  unless it's written down.
- A digital arrival card or visa step that's now time-boxed.

## Close on what the group is waiting for

These pages are read by the people travelling, not just the person planning. A
useful wrap-up ends by naming the decisions that are blocking everyone else —
who needs to choose what, and what can't move until they do. That's more useful
than a task list, because it tells the user what to put in the group chat.

## Offer, don't assume

Two things worth asking rather than doing silently, because both are outward
facing or long-lived:

- **Uncommitted work.** Say what's uncommitted and offer to commit it. Don't
  commit as part of wrapping up unless asked.
- **Durable preferences.** If the session surfaced something that will matter in
  unrelated future sessions — a standing preference, a hard constraint, a fact
  about how the user works — that belongs in memory, not just a project log.
  Offer to save it.
