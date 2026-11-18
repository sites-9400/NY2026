---
version: 1
slug: "public-2026-12-sea-index-html"
primary_target: "public/2026-12-sea/index.html"
related_targets: ["public/2026-12-sea/itinerary.html","public/2026-12-sea/route.html","public/2026-12-sea/money.html","public/2026-12-sea/accommodations.html","public/2026-12-sea/before.html"]
---

# SEA trip site (six pages)

Scope: the six SEA Dec 2026 pages (Dashboard, Itinerary, Route, Money, Accommodations, Before we fly). Mode: read. Audience: the five travellers, on phones, before and during the trip. Job: know in seconds what's booked, what's next, what to do. Constraint: less visible text than the previous build; detail collapses behind "More", never deleted. Siargao and the landing page are out of scope.

## Direction contract

THESIS: The trip is one rail line read like a station sign: where we are, the next departure, and which stations are confirmed. Refuses the category default of photo day cards and a blue accent, and refuses the previous build's walls of tables and callouts.

OWN-WORLD: White ground, black type in a Helvetica stack, heavy weights. One vertical line in segment colours (air blue, Singapore pink, Malaysia teal, Thailand amber). Station rings on the line, coloured code tiles (DVO, SG, KL, BKK), black sign panels for the next departure, a red You are here marker. Status is a solid tile (booked) or an outline tile (not yet); no stamps, no patterns, no serif.

STORY: The reader sees the next departure, then the line of cities with what is confirmed at each, then the few things still to do. Detail is one tap away.

FIRST VIEWPORT: Three-colour line bar, a black sign panel with the next departure (route in 36px heavy type, times, status tile), then the line with five stations and their one-line status; on phones the panel and three stations fit the first screen.

FORM: Station signs (MRT/LRT/BTS wayfinding), position 1 on the ordered list (pick card). seed:4ede59780fa7296a

FINISH: unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance
