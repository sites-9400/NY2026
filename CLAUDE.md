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

## Comments (Realtime Database)

Each day card carries a comment thread so the page is two-way, not a broadcast.
Stored in Firebase Realtime Database under `comments/<trip-slug>/<YYYY-MM-DD>/`,
keyed by the `data-day` attribute on each `.day` element — dates, not indexes,
so renumbering days never moves a thread.

Rules live in `database.rules.json` and deploy with
`firebase deploy --only database`. They are deliberately strict:

- Reads and writes are allowed **only** under `/comments`. Everything else denies.
- Comments are **create-only** — nobody can edit or delete from the page, so a
  visitor with the link cannot wipe a thread.
- Name is capped at 40 characters, text at 700, and any field other than
  `name`/`text`/`at` is rejected.

**There is no login.** Anyone with the URL can post under any name. That is a
deliberate trade for five friends on an unlisted link. To lock it down later,
add Firebase Auth or move to a shared passcode.

To remove a comment, use the console or
`firebase database:remove /comments/2026-12-sea/<date>` — admin credentials
bypass the create-only rule.

**All user text is rendered with `textContent`, never `innerHTML`.** Keep it that
way; this is a page other people type into.

## Starting a new trip

1. `cp _reference/templates/trip-page.html public/<slug>/index.html` and fill it in.
2. Create `<YYYY-MM-NAME>/` with `notes/` and `bookings/`.
3. Add a card for it on `public/index.html`.
4. Deploy, send the link.

## Design lineage

The wine accent and the coloured day rails come from the Hong Kong
Jul 2026 itinerary, which was built for print. The originals are in
`2026-07-HongKong/` if you want to see where a pattern came from. `site.css` is
that system adapted for screens, with dark mode and a print stylesheet.

Two deliberate departures from the Hong Kong original, both at the user's
request — don't drift back:

- **A clean white ground, not the warm cream.** The cream read as a default
  template rather than a choice.
- **A wine accent, not rust.** The original rust (`#c1531f`) read as Claude's own
  brand colour; it was swapped for `#8c2f4c` in Jul 2026. The token is `--brand`,
  never a colour name, so the next change is one line.
- **Monochrome stroke icons, never emoji.** Icons live in an SVG sprite and
  inherit `currentColor`, so they take each day's accent. Emoji rendered
  full-colour and differently on every platform — and note that plain glyphs
  like `↗` also render as colour emoji on iOS, so use the sprite for those too.

**Bump the `?v=` on the stylesheet link whenever `site.css` changes**, and bump
it on *every* page, not just the one you're editing. An early deploy sent CSS
with `max-age=3600`; anyone who loaded the page in that window held a stale
stylesheet for an hour and saw new markup against old CSS, which looks exactly
like the site being broken. Versioning the URL makes a cached copy unreachable
instead of relying on people hard-refreshing. The two pages drifted to different
version numbers in Jul 2026 for exactly this reason; they're back in step now.

**`cleanUrls` means the header globs in `firebase.json` don't see `.html`.** A
page is served at `/2026-12-sea/`, so a `**/*.@(html|css|js)` source never
matched it and pages went out with the default one-hour cache for months. The
fix is a `**` rule for `no-cache` with the image rule after it. If you touch the
headers, verify with `curl -sI` against the live URL rather than reading the
config, because the config looked right the whole time.

**Tables stack on mobile.** Below 36rem each row becomes a block and every cell
shows its column name, drawn from `data-label` attributes generated off the table
head. Add `data-label` to new cells. Don't make the cell a grid container to get
a two-column look — a grid makes every inline `<b>` its own item and splits
sentences across the label column.

**No em dashes in prose. Use a full stop, a colon, or bullets.** Switched Jul
2026 at the user's request, across both pages. Where a sentence wanted an em
dash it usually wanted to be two sentences or a list; the trip content is
mostly lists of facts and reads better that way. The lone `—` left in an
otherwise-empty table cell is *not* prose, it's the "no value yet" marker, and
it stays.

**Never sweep punctuation with a regex over raw HTML.** The first attempt at the
em-dash sweep capitalised the first letter after each dash, which turned `</td>`
into `</Td>` and converted the empty-cell markers into stray full stops. The
second attempt reached into `<script>` blocks and renamed a JS property from
`start` to `Start`, which passed `node --check` and only showed up as
`undefined` inside a downloaded calendar file. Operate on text nodes only, skip
comments and scripts, and validate tag nesting afterwards.

**Day colours come in two strengths.** `--sg` is the text-safe value, `--sgv`
the vivid one used for the rail, and `--sgon` what reads on top of that rail.
The rail colours were designed for print and never cleared 4.5:1 as type;
Thailand's orange was 2.41:1. Splitting them fixed contrast without muddying
the palette, so don't collapse them back into one token. Dark mode overrides
only the text strength, since the vivid rails hold on a dark ground.

**Type is Helvetica throughout** (`--display` and `--body`). The Hong Kong
originals set headings in Georgia; that was switched out in Jul 2026. Keep it
Helvetica — and note that headings carry weight 800 and negative tracking
because Helvetica at default weight and spacing reads like unstyled browser
text. Don't use oblique for subheadings; synthesised Helvetica italic looks
cheap. Use colour and weight to subordinate instead.

## Trips

- **`2026-12-SEA/`** → `public/2026-12-sea/` — Singapore, Malaysia, Bangkok.
  25 Dec 2026 onward. Five travellers: Gamaliel, Marianne, Alysson, Kevin, Jan.
  Outbound booked one way; return not booked, which is also the trip's biggest
  open risk (onward-travel proof). Anchor: NYE fireworks in Bangkok, 31 Dec.
- **`2026-07-HongKong/`** — complete. Kept offline, not published.
