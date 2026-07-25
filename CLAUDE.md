# Travel Companion

A workspace for planning trips and sharing them with the people coming along.

Each trip gets a folder for the private working material and a page on a small
static site. The site is the thing that gets shared — one link, always current,
readable on a phone.

- **Live site:** https://travel-f412b.web.app
- **Firebase project:** `travel-f412b`
- **Repo:** https://github.com/sites-9400/NY2026 — **public.** Assume anything
  committed is world-readable and search-indexed. `bookings/` and the Hong Kong
  archive are gitignored for exactly this reason; they live in Dropbox only.

## Layout

```
Travel Companion/
├── public/                    ← deployed to Firebase Hosting. Shareable, assume public.
│   ├── index.html                 landing page listing all trips
│   ├── assets/site.css            the shared design system — every page uses it
│   └── <slug>/index.html          one page per trip
├── _reference/
│   ├── templates/trip-page.html   blank trip page, copy to start a new one
│   └── render-to-pdf.sh           page → PDF, for offline/paper copies
├── <YYYY-MM-NAME>/            ← private working material for one trip
│   ├── notes/planning.md          decision log: what we chose and why
│   ├── notes/references.md        raw links, prices, suggestions
│   ├── bookings/                  confirmation PDFs — gitignored, never deployed
│   └── img/
└── docs/specs/                ← design docs for the workspace itself
```

## The rules that matter

**The published page is the single source of truth for the plan.** Don't keep a
parallel markdown itinerary — on the Hong Kong trip the `.docx` went stale while
the markdown moved on, and it caused real confusion. `notes/` holds the messy
input and the reasoning; `public/` holds what was decided. One direction only.

**Nothing private goes in `public/`.** A Firebase Hosting URL is unlisted, not
secret — anyone with the link sees everything. Booking references, passport
details, account numbers and bank statements stay in `bookings/`, which is
gitignored. Pages carry `noindex` so they stay out of search results.

**Mark what isn't decided.** Use the `tbd` and `risk` pills and leave slots
visibly empty rather than filling them with plausible guesses. Someone reading
the page needs to tell instantly what's booked and what's still air. Never
invent a detail — a wrong hotel name on a shared page is worse than a blank.

**Money: name what's shared and what's personal, up front.** Hong Kong's lesson
was that the split rule has to be written down before anyone pays for anything.
State it in one sentence on the page.

## Working on a page

Plain HTML and CSS. No build step, no framework, no dependencies. Every class
used in a trip page is already defined in `assets/site.css` — read it before
adding new CSS, and prefer extending the existing pattern over inventing one.

Day cards take a country class (`sg`, `my`, `th`, `air` for travel days) that
sets the coloured rail. New country → copy the `.day.sg` rule in `site.css`.

Preview locally before deploying:

```sh
cd public && python3 -m http.server 8080     # → http://localhost:8080
```

## Deploying

```sh
firebase deploy --only hosting     # → https://travel-f412b.web.app
git push                           # source, minus the gitignored private folders
```

The CLI is installed and authenticated, and `.firebaserc` points at
`travel-f412b`. Deploying and pushing are separate steps — hosting serves from
`public/` on disk, not from the repo.

## Starting a new trip

1. `cp _reference/templates/trip-page.html public/<slug>/index.html` and fill it in.
2. Create `<YYYY-MM-NAME>/` with `notes/` and `bookings/`.
3. Add a card for it on `public/index.html`.
4. Deploy, send the link.

## Design lineage

The look — cream paper, Georgia display type, rust and teal accents, coloured
day rails — comes from the Hong Kong Jul 2026 itinerary, which was built for
print. The originals are in `2026-07-HongKong/` if you want to see where a
pattern came from. `site.css` is the same system adapted for screens, with dark
mode and a print stylesheet that returns it to something close to the original.

## Trips

- **`2026-12-SEA/`** → `public/2026-12-sea/` — Singapore, Malaysia, Bangkok.
  25 Dec 2026 onward. Five travellers: Gamaliel, Marianne, Alysson, Kevin, Jan.
  Outbound booked one way; return not booked, which is also the trip's biggest
  open risk (onward-travel proof). Anchor: NYE fireworks in Bangkok, 31 Dec.
- **`2026-07-HongKong/`** — complete. Kept offline, not published.
