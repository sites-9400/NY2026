# Travel Companion — workspace design

*25 July 2026*

## What changed

The `HongKong/` folder was a single-trip working directory: a markdown source of
truth, hand-authored print HTML, PDFs rendered with headless Chrome, and a Stop
hook that rsynced those PDFs into a shared Google Drive folder so the travel
companions saw current versions.

The Hong Kong trip is finished. This turns that folder into a reusable workspace
for the trips ahead, and replaces the PDF-and-Drive distribution loop with a
hosted page.

## Decisions

**Renamed `HongKong/` → `Travel Companion/`.** Hong Kong's files moved intact to
`2026-07-HongKong/`. The project's saved memory was migrated to the new path,
since Claude keys memory to the directory name.

**Sharing is a URL, not a file.** `public/` deploys to Firebase Hosting. One link
per trip, always current. This kills the re-render-and-resync loop that Hong Kong
needed on every edit. It also solves an ownership problem: the "HK files" Drive
folder belongs to Jude, so it was never a durable home for the user's material.

**One source of truth per trip: the published page.** No parallel markdown
itinerary. On the Hong Kong trip the `.docx` went stale while the markdown moved
on. `notes/` holds raw input and reasoning; `public/` holds what was decided;
information flows one way.

**Private material never enters `public/`.** `bookings/` is gitignored and
undeployed. A Hosting URL is unlisted, not secret. Pages carry `noindex` and the
hosting config sends `X-Robots-Tag`.

**Plain HTML and CSS, no build step.** One shared `assets/site.css` carries the
design system so every trip page reads as the same product. Adding a trip means
copying a template, not standing up tooling.

**PDF rendering demoted, not deleted.** `_reference/render-to-pdf.sh` keeps the
headless-Chrome technique — including the workaround for Chrome hanging on
Dropbox paths — for offline copies.

## Layout

```
Travel Companion/
├── CLAUDE.md                   conventions for future sessions
├── firebase.json  .firebaserc  hosting config (project ID still a placeholder)
├── .gitignore                  excludes bookings/, statements, confirmations
├── public/                     ← deployed
│   ├── index.html              trip index
│   ├── assets/site.css         shared design system
│   └── 2026-12-sea/index.html  the December trip
├── _reference/
│   ├── templates/trip-page.html
│   └── render-to-pdf.sh
├── 2026-12-SEA/                notes/, bookings/, img/
├── 2026-07-HongKong/           archived, unpublished
└── docs/specs/
```

## Design system

Carried over from the Hong Kong itinerary so the trips look related: cream paper
`#faf8f2`, Georgia display type, rust `#c1531f` and teal `#2c7a86` accents, and
the coloured day rails from the one-page infographic — now mapped to countries
(SG rose, MY teal, TH amber, travel days blue). Adapted for screens with a
mobile-first layout, a sticky day nav, dark mode, and a print stylesheet that
returns the page to something close to the original.

> **Superseded later the same day.** The cream ground and Georgia headings were
> dropped for a **clean white ground and Helvetica throughout**, and emoji were
> replaced with monochrome stroke icons. The rust/teal accents and the coloured
> day rails survive. `CLAUDE.md` carries the current rules; this section is left
> as written to record what the workspace started from.

## The December trip

Singapore → Malaysia → Bangkok, departing 25 Dec 2026. Five travellers:
Gamaliel, Marianne, Alysson, Kevin, Jan. Outbound is booked one way; the return
is not.

The page is deliberately a skeleton. Anchors are real — 25 Dec arrival in
Singapore, 31 Dec fireworks in Bangkok — and everything else sits in visibly
empty slots marked TBD rather than filled with plausible guesses. The day frame
runs to 4 Jan as a placeholder that moves when the return flight is booked.

Two things the page flags rather than buries:

- **Proof of onward travel.** Singapore and Thailand immigration can both ask
  for it, and airlines check at the departure counter. With only a one-way
  booked this is an unresolved risk, not a formality.
- **The split rule.** Accommodation and group bookings divide five ways; food
  and shopping are personal. Hong Kong's lesson was that this has to be written
  down before anyone pays for anything.

## Still to do

- Install the Firebase CLI, create the project, replace the placeholder in
  `.firebaserc`, deploy.
- `git init` and push.
- Fill the trip in — content is the next session's work.
