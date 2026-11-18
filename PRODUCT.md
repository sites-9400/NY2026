# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users
Five friends from Davao travelling together: Gamaliel, Marianne, Alysson, Kevin, Jan
(a sixth, Jude, is an open maybe). All five open the SEA trip site on their phones, both
while planning now (what's booked, what's still open, what each person owes) and on the
trip itself (today's plan, train and flight times, what to have ready at each border).
Gamaliel maintains it. Several are first-time international travellers.

## Product Purpose
One shared link, always current, that is the single source of truth for a group trip:
Singapore, Kuala Lumpur and Bangkok, 25 Dec 2026 to 6 Jan 2027. Success is that anyone in
the group can tell in seconds what is booked, what is still undecided, what they need to
do next, and where to be today, without asking in the chat.

## Positioning
Not a booking app or a travel blog: a private, hand-kept plan for one specific group and
one specific trip, written by the person organising it, readable on a phone, with every
decision traceable.

## Operating Context
- Read on phones, often on the move: airports, train platforms, hotel lobbies, sometimes
  on weak signal.
- Shared as one unlisted Firebase link in the group chat; each day carries a comment thread.
- Planning happens in Gamaliel's working notes (`2026-12-SEA/notes/`); the site holds only
  what was decided.
- Six pages: Dashboard, Itinerary, Route, Money, Accommodations, Before we fly.

## Capabilities and Constraints
- Plain static HTML and CSS on Firebase Hosting. No build step, no framework.
- Comments via Firebase Realtime Database, create-only, text rendered with textContent.
- Pages are `noindex`; the repo is public, so nothing private (booking references,
  passport details) goes in `public/`.
- Undecided items must be visibly marked, never filled with plausible guesses.
- Money states up front what is shared and what is personal.
- Open: Kevin's return; how Bangkok splits without Gamaliel; KL and Bangkok rooms.

## Brand Commitments
- Monochrome stroke icons, never emoji.
- No em dashes in prose.
- Terse copy: state the fact and stop; reasoning lives in the planning notes.
- Write for a first-time traveller: no unexplained abbreviations.

## Evidence on Hand
Real bookings and facts only: outbound flights (booked), The Quay Hotel Little India
(booked), three return flights (booked), checked fares and timetables. No photos of our
own yet. Nothing may be invented: no hotel names, prices or times that weren't checked.

## Product Principles
1. Glanceable first: status before story. A reader should get the answer before the explanation.
2. Booked versus not-yet is the most important distinction on every page.
3. Today matters most during the trip; the whole plan matters most before it.
4. Less text: every sentence must earn its place on a phone screen.

## Accessibility & Inclusion
Body text at least 4.5:1 contrast, light and dark mode, usable one-handed on a phone.
