---
name: SEA Dec 2026 trip site
description: Station signs. A group trip read like rail wayfinding in Singapore, KL and Bangkok.
colors:
  ink: "#111111"
  paper: "#ffffff"
  gray: "#4a4a4f"
  soft: "#5f5f66"
  line: "#dcdce0"
  fold-ground: "#f3f3f4"
  sign: "#111111"
  on-sign: "#ffffff"
  sign-soft: "#c4c4c8"
  link: "#1d5bb0"
  booked-green: "#147a50"
  book-now-red: "#c8102e"
  singapore-pink: "#e0567a"
  malaysia-teal: "#1fa899"
  thailand-amber: "#e8942e"
  air-blue: "#3b76c7"
  air-code-blue: "#2a5ea6"
typography:
  display:
    fontFamily: "\"Helvetica Neue\", Helvetica, Inter, Arial, sans-serif"
    fontSize: "clamp(1.9rem, 6vw, 2.6rem)"
    fontWeight: 800
    lineHeight: 1.02
    letterSpacing: "-0.04em"
  sign-time:
    fontFamily: "\"Helvetica Neue\", Helvetica, Inter, Arial, sans-serif"
    fontSize: "clamp(2.6rem, 11vw, 3.6rem)"
    fontWeight: 800
    lineHeight: 1
    letterSpacing: "-0.04em"
    fontFeature: "tnum"
  sign-route:
    fontFamily: "\"Helvetica Neue\", Helvetica, Inter, Arial, sans-serif"
    fontSize: "clamp(1.7rem, 6.5vw, 2.3rem)"
    fontWeight: 800
    lineHeight: 1.05
    letterSpacing: "-0.035em"
  headline:
    fontFamily: "\"Helvetica Neue\", Helvetica, Inter, Arial, sans-serif"
    fontSize: "1.75rem"
    fontWeight: 800
    letterSpacing: "-0.035em"
  title:
    fontFamily: "\"Helvetica Neue\", Helvetica, Inter, Arial, sans-serif"
    fontSize: "1.35rem"
    fontWeight: 800
    letterSpacing: "-0.025em"
  subtitle:
    fontFamily: "\"Helvetica Neue\", Helvetica, Inter, Arial, sans-serif"
    fontSize: "1.1rem"
    fontWeight: 800
    letterSpacing: "-0.015em"
  body:
    fontFamily: "\"Helvetica Neue\", Helvetica, Inter, Arial, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: 1.6
  label:
    fontFamily: "\"Helvetica Neue\", Helvetica, Inter, Arial, sans-serif"
    fontSize: "0.7rem"
    fontWeight: 800
    letterSpacing: "0.06em"
rounded:
  none: "0px"
  tile: "3px"
  panel: "4px"
  ring: "50%"
spacing:
  gutter: "1.1rem"
  stop-indent: "3.4rem"
  stop-gap: "1.5rem"
  max-width: "52rem"
  tap-min: "44px"
components:
  sign-panel:
    backgroundColor: "{colors.sign}"
    textColor: "{colors.on-sign}"
    rounded: "{rounded.panel}"
    padding: "1.1rem 1.15rem 1.15rem"
  tile-booked:
    backgroundColor: "{colors.booked-green}"
    textColor: "{colors.paper}"
    typography: "{typography.label}"
    rounded: "{rounded.tile}"
    padding: "0.12rem 0.5rem"
    height: "24px"
  tile-not-yet:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    typography: "{typography.label}"
    rounded: "{rounded.tile}"
    padding: "0.12rem 0.5rem"
    height: "24px"
  tile-book-now:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.book-now-red}"
    typography: "{typography.label}"
    rounded: "{rounded.tile}"
    padding: "0.12rem 0.5rem"
    height: "24px"
  code-tile-singapore:
    backgroundColor: "{colors.singapore-pink}"
    textColor: "{colors.ink}"
    rounded: "{rounded.none}"
    padding: "0.1rem 0.35rem"
  code-tile-air:
    backgroundColor: "{colors.air-code-blue}"
    textColor: "{colors.paper}"
    rounded: "{rounded.none}"
    padding: "0.1rem 0.35rem"
  here-tag:
    backgroundColor: "{colors.book-now-red}"
    textColor: "{colors.paper}"
    rounded: "{rounded.none}"
    padding: "0.12rem 0.45rem"
  nav-tab:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    rounded: "{rounded.panel}"
    padding: "0.38rem 0.75rem"
  nav-tab-active:
    backgroundColor: "{colors.ink}"
    textColor: "{colors.paper}"
    rounded: "{rounded.panel}"
    padding: "0.38rem 0.75rem"
  fold-row:
    textColor: "{colors.ink}"
    rounded: "{rounded.none}"
    padding: "0.55rem 0.1rem"
    height: "44px"
---

# Design System: SEA Dec 2026 trip site

## Overview

**Creative North Star: "Station signs"**

The trip is one rail line read like MRT, LRT and BTS wayfinding: where we are, the next departure, and which stations are confirmed. White ground, black Helvetica at heavy weights, one vertical line in segment colours, station rings, coloured city code tiles, a black sign panel for the next departure and a red You are here marker. Status is a tile: solid when booked, outline when not yet.

The system is built for five people reading on phones in airports and on platforms. Status comes before story. Every page answers "what is booked and what is next" in the first screen, and everything else folds behind a "+" row, one tap away. Density is low on purpose: less visible text, never less information.

It refuses photo day cards, a blue brand accent, stamps, patterns, serif type and walls of tables and callouts.

**Scope.** This system applies to the six SEA Dec 2026 pages only (`public/2026-12-sea/`: index, itinerary, route, money, accommodations, before). They load `public/assets/site.css` first and `public/assets/sea.css` on top. The landing page (`public/index.html`) and the Siargao page (`public/2026-08-siargao/`) keep the older site.css system: white ground, wine accent `#8c2f4c`, Helvetica, coloured day rails. Do not link sea.css from them and do not port these rules to them.

**Key Characteristics:**
- White ground, black type, heavy Helvetica (800) with negative tracking.
- One line in four segment colours: air blue, Singapore pink, Malaysia teal, Thailand amber.
- Exactly four status labels: Booked, Not booked, TBD, Book now.
- Black is reserved for the next departure.
- Detail collapses behind "+" rows; it is never deleted.

## Colors

A monochrome sign system with four segment colours on the line and two status colours, green for booked and red for act now.

### Primary
- **Platform Black** (ink): all type, station rings, rules above fold rows and tables, the active nav tab. Also the value of `--brand` in this build, so anything site.css colours with the brand reads black, never wine.
- **Sign Black** (sign): the ground of the next-departure panel. Same value as ink in light mode; pure black in dark mode so the panel stays a sign.

### Secondary (segment colours, the line)
- **Singapore Pink** (singapore-pink), **Malaysia Teal** (malaysia-teal), **Thailand Amber** (thailand-amber), **Air Blue** (air-blue): the vivid strengths from site.css (`--sgv`, `--myv`, `--thv`, `--airv`). They fill the line segments, the masthead bar, the heading rule and the city code tiles, always with black text on top. They are fills, never text colours: for text in a country colour use site.css's darker `--sg`, `--my`, `--th`.
- **Air Code Blue** (air-code-blue): the DVO code tile only, with white text, because air-blue under black text does not clear contrast.

### Tertiary (status)
- **Booked Green** (booked-green): the solid Booked tile, white text.
- **Book-now Red** (book-now-red): the Book now outline tile, folded warnings (`details.callout.flag`), watch-out rows in day cards, the You are here ring and tag. Nothing else is red.

### Neutral
- **Paper** (paper): the page ground and the inside of station rings.
- **Soft Gray** (soft): dates, secondary lines, table heads, the "+" marker.
- **Gray** (gray): body text in table cells.
- **Hairline** (line): row dividers and the resting nav-tab border.
- **Fold Ground** (fold-ground): the faint panel behind side blocks inside a day card.
- **Sign Soft** (sign-soft): secondary text on the black sign.
- **Link Blue** (link): links on white.

Dark mode (via `prefers-color-scheme`) flips ink to `#f2f2f2`, ground to site.css's `#16151a`, green to `#3fb27f` and red to `#ff6b7f`; solid tiles and the here tag then carry `#111` text. The segment fills do not change.

### Named Rules
**The Reserved Black Rule.** A black panel means "the next departure". One per page at most; money figures, map read-outs and callouts stay on white.

**The Four Labels Rule.** Status uses exactly four words: Booked (solid green tile), Not booked and TBD (black outline tile), Book now (red outline tile). No other status words, colours or shapes.

## Typography

**Display Font:** Helvetica Neue (with Helvetica, Inter, Arial, sans-serif)
**Body Font:** the same stack.

**Character:** One family, carried by weight and tracking. Headings sit at 800 with negative letter-spacing because Helvetica at default weight reads like unstyled browser text.

### Hierarchy
- **Sign time** (800, clamp(2.6rem, 11vw, 3.6rem), 1, tabular figures): the departure time on the sign. The largest type on a page.
- **Display** (800, clamp(1.9rem, 6vw, 2.6rem), 1.02): the page name in the masthead. 1.45rem on phones.
- **Sign route** (800, clamp(1.7rem, 6.5vw, 2.3rem), 1.05): "Davao → Singapore" on the sign, with code tiles inline at 0.42em.
- **Headline** (800, 1.75rem): section headings, followed by the three-colour rule.
- **Title** (800, 1.35rem): the city name at each station.
- **Subtitle** (800, 1.1rem): h3.
- **Body** (400, 16px, 1.6): prose and lists; the lede caps at 60ch.
- **Label** (800, 0.7rem, 0.06em, uppercase): status tiles. Table heads and ticket field labels use the same voice at 0.66 to 0.72rem.

### Named Rules
**The Eleven Pixel Floor.** No functional text under 11px.

**The No Oblique Rule.** No italic or oblique anywhere. Subordinate with weight and the soft gray.

## Layout

A single column, max 52rem, 1.1rem side gutter, mobile first. One breakpoint at 36rem. Below it the masthead shrinks, the subtitle hides, nav tabs tighten, and the sign plus three stations fit the first phone screen. Tables stack into labelled blocks below 36rem (every cell carries `data-label`).

The page order is fixed: three-colour bar, page name, sign-tab nav (sticky), then status first (sign, line), then folded detail. The line indents stations 3.4rem with a 1.5rem gap between stops. Route legs and the money figures are departure-board rows: hairline dividers under a 1.5px black top rule, times in tabular figures, status at the right edge.

All internal links and stylesheet URLs are absolute (`/assets/...`, `/2026-12-sea/<page>/`) because pages serve at folder depth under `cleanUrls`.

## Elevation & Depth

Flat. No shadows. Depth is tonal and structural: the black sign stands out by inversion, 1.5px black rules open a section, 1px hairlines divide rows. Print drops the black sign to a 1.5px outline and opens every fold.

## Shapes

Square signage. Tiles take a 3px radius, the sign panel and nav tabs 4px, code tiles and the here tag are square. The only circles are station rings (26px, 5px black border, paper fill; red-filled when you are here) and the smaller rings on the itinerary day line. The line itself is a 10px solid bar. No pills: site.css's 999px nav pills are overridden to 4px sign tabs.

## Components

### Status tiles
- **Shape:** 3px corners, 1.5px border, min height 24px, uppercase label type.
- **Booked:** solid booked-green, white text.
- **Not booked / TBD:** transparent with a black outline and black text (white outline on the sign).
- **Book now:** transparent with a red outline and red text.
- The older `.pill` classes in table rows are restyled to the same four looks, so tables and the line agree.

### Sign panel (signature)
- Black ground, 4px corners, white text. Holds only the next departure: route with code tiles, the time at sign-time size, a one-line soft-gray detail, then the status tile and an Add to calendar button outlined in translucent white.

### The line (signature)
- An ordered list of stops. Each stop has a segment-coloured 10px bar, a station ring, a code tile (DVO, SG, KL, BKK), the city at title size, a soft-gray date line, and one status line per item with its tile beside it (the text wraps next to the tile, never under it).
- **You are here:** today's station gets a red ring and a red "You are here" tag.

### Navigation
- Sign tabs: 4px corners, 1.5px hairline border, 0.8rem weight 800 black text. Hover darkens the border to black. The current page is a solid black tab with white text.

### Fold rows
- `details.more` and `details.callout`: a 44px-minimum summary row, 1.5px black rule above and a hairline below, weight 800 text, a soft-gray "+" at the right that turns to "−" when open. A flagged callout turns the text and top rule red. Day-card watch-outs use the same pattern at 40px with red text.

### Masthead bar and section rule
- A 10px full-bleed bar in thirds (pink, teal, amber) above the page name; a 6px, 7rem version under each h2.

### Departure-board rows
- Route legs and money figures: black top rule, hairline row dividers, date or label at left in soft gray, the value or route in weight 800, status tile at right.

### Icons
- Monochrome stroke icons from the SVG sprite (`.ic`, `currentColor`, stroke 1.8), so they take the colour of what they sit in.

## Do's and Don'ts

### Do:
- **Do** use exactly the four status labels and their tiles: Booked solid green, Not booked and TBD black outline, Book now red outline.
- **Do** keep black panels for the next departure only.
- **Do** fold detail behind a details/summary "+" row instead of deleting it.
- **Do** mark anything undecided visibly with a Not booked or TBD tile, or leave the slot empty; an empty table cell carries a lone "—" as its marker.
- **Do** keep copy terse: state the fact and stop. Reasoning stays in `2026-12-SEA/notes/`.
- **Do** use the segment fills with black text, and site.css's darker `--sg`/`--my`/`--th` when a country colour must be text.
- **Do** bump the `?v=` on the sea.css link on all six SEA pages whenever sea.css changes (and on every page that loads site.css when site.css changes).
- **Do** keep all text at 11px or larger and summary rows at 44px tap height.

### Don't:
- **Don't** use em dashes in prose. Use a full stop, a colon or a list. The lone "—" in an empty table cell is a marker, not prose.
- **Don't** use emoji, or glyphs that iOS renders as emoji (such as ↗). Icons come from the SVG sprite only.
- **Don't** add a fifth status word, colour or shape, or stamps and patterns.
- **Don't** add serif type, italics, shadows or photo cards.
- **Don't** fill an undecided slot with a plausible guess.
- **Don't** apply sea.css or these rules to the landing page or the Siargao page.
- **Don't** put booking references or other private values in `public/`; the repo is public.
