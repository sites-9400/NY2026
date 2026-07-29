# Siargao, 29 Aug – 1 Sep 2026 — planning log

First anniversary trip. Two travellers: Gamaliel Eve Relampago Minggong ("Eve") and
Fritzie Jude Galbizo Navarra ("Jude").

Published page: https://travel-f412b.web.app/2026-08-siargao/
The page is the source of truth for the plan. This file is the reasoning behind it.

## Decisions made

**29 Jul 2026 — flights booked, both ways, before anything else.**
Four separate tickets, one booking per passenger per leg, all Cebu Pacific GO Basic
operated by Cebgo. Booked the same day, so the shape of the trip is fixed at four days
and three nights whatever else changes.

- Out: DG 6876, Sat 29 Aug, DVO 11:55 → IAO 13:05 (1h 10m). ₱5,976.20 each.
- Back: DG 6875, Tue 1 Sep, IAO 10:20 → DVO 11:35 (1h 15m). ₱5,826.20 each.
- Total for two people, both ways: ₱23,604.80.

The two fares differ only in the passenger service charge, ₱350 at Davao against ₱200
at Sayak. Everything else in the breakdown is identical.

**29 Jul 2026 — room booked: Coracasa bed and breakfast, General Luna.**
Three nights, one standard double for two adults, breakfast and wifi included. In from
14:00 Sat 29 Aug, out before 12:00 Tue 1 Sep. Booked through Agoda in Eve's name.

The whole thing was one Agoda payment of **₱31,769.53** covering both the flights and the
room. The four airline receipts account for ₱23,604.80, which leaves **₱8,164.73** for the
three nights. That figure is a subtraction, not a line item: the itemised receipt is the
`RECEIPT_enclosed.pdf` attachment named in the confirmation email, which we do not have a
copy of. The page says so rather than presenting the number as quoted.

**The tickets are less flexible than the airline's own fare rules suggest.**
Cebu Pacific's GO Basic rules say rebooking is allowed with a change fee. The Agoda ticket
policy on the same booking says the tickets may not be changed and cannot be cancelled for
any refund. The page states the stricter of the two, because that is the one that governs
if a date ever has to move. It also changes the shape of the weather risk: with
unchangeable tickets, a typhoon costs the whole trip, not a rebooking fee.

**14 August is the real decision date.**
Free cancellation on the room runs to 23:59 on 14 Aug island time, then drops to a 66%
refund, then to nothing from 29 Aug. Since the flights are already unchangeable, 14 Aug is
the last clean exit from the trip. It has its own callout on the page and its own calendar
entry.

**29 Jul 2026 — reversed: the check-in codes ARE on the published page.**
The first version kept them off deliberately. A reference plus a surname opens a Cebu
Pacific reservation, and the page sits on an unlisted but public URL. That was raised, and
the call was to put them on anyway, because having the codes on the phone at the airport is
worth more than the exposure. So the page now carries all four QR codes and their references
in a "Check-in codes" block under Flights.

What this means, written down so it is not rediscovered later:

- **The trip URL is now effectively the key to the bookings.** Anyone with the link can scan
  the codes and open the reservations with the airline. The page says this in a flag callout
  rather than leaving it implied.
- `noindex` and `x-robots-tag: noindex, nofollow` are both live, verified with `curl`, so the
  page stays out of search. That is the only mitigation an unlisted URL gets.
- **What is still private**: the hotel booking ID, the Agoda payment details, the receipt
  PDFs, and the passengers' birthdates and contact details. Those stay in `bookings/` and
  were checked for absence from the page with a grep before deploying.

The QR images were regenerated at 548 px for the web rather than reusing the 250 px originals
out of the PDF, and decoded back from the live URLs after deploying to confirm they still
scan.

**Calendar entries were made as two events, not four.**
All four tickets are the same two flights, so the Google Calendar (TRAVEL) has one event
per flight with both passengers and both references in the description. Four events would
have been four duplicate reminders on the same morning. Two more went on later: the stay
itself, and an all-day marker on 14 Aug for the free-cancellation deadline.

**The check-in QR codes were pulled out of the receipts into one sheet.**
Each QR encodes only the booking reference, nothing else, so the code and the reference are
equivalent and neither belongs on a public page. `bookings/checkin-qr-cards.html` and its
PDF put all four on one page, labelled by passenger and flight, upscaled 4× with a quiet
zone so they scan reliably off a phone screen or on paper. Verified by decoding them back
out of the rendered PDF at 200 dpi.

**A new day-card colour, `ph`, for the Philippines.**
`--ph:#0f7a55` for text, `--phv:#17a06f` for the rail, following the two-strength rule in
`site.css`. Checked: 5.3:1 on white for the text strength, 5.35:1 for ink on the rail.
Dark mode overrides the text strength only, as with the others.

**29 Jul 2026 — this is a repeat trip, and the page was rewritten to suit that.**
Eve and Jude have been to Siargao several times. The first draft explained Cloud 9 and the
three-island run as if they were new, which was wrong for the readers. Those explanations
were cut, the island-hopping day was marked optional, and a **Quieter corners** section was
added: Alegria and Pacifico in the north, the Del Carmen fireflies and mangrove boardwalk,
Taktak Falls, and Sohoton with the caveat below.

Two facts from experience that changed the numbers:

- **Airport transfer is ₱300 per person**, the rate they have paid before. Four trips across
  two people is ₱1,200. The money note flags that if the ₱300 was ever for the pair, the line
  halves.
- **The room includes a motorbike**, not just breakfast and wifi. This is the single biggest
  change to the plan: the north end of the island stops being a van hire and becomes a tank of
  fuel, so Alegria (about 1½ hours each way) is realistic. The old "hire a van or rent a
  scooter" advice was deleted, and the scooter-rental caution in Before we fly was replaced
  with checking the bike over and carrying licences.

**Sohoton in late August is the wrong season for the jellyfish.**
The sanctuary is best roughly November to May, and this trip is 29 Aug to 1 Sep. The caves and
lagoons are unaffected, but at ₱1,500 to ₱2,500 each plus a whole day it probably is not the
right call this time. On the page as an open question rather than a recommendation.

## Deliberately left open

Flights, the room, the bike and the transfer rate are all settled. What is left:

- **North or west.** Alegria and Pacifico, or Del Carmen with the fireflies. One day, one
  direction: pairing them is three hours of riding before anyone stops anywhere.
- **Sunday's boat.** Repeat the three-island run, add Kawhagan, or skip it and ride.
- **Anniversary dinner**, Sunday night.
- **Magpupungko**, only if we go north and only if low tide falls at a usable hour. Needs a
  tide table nearer the date.

## Risks worth naming

- **No checked baggage on any of the four tickets.** Hand carry only, 7 kg, one piece no
  larger than 56 × 36 × 23 cm. Adding an allowance online is cheaper than at the counter,
  so this is a decision to make before packing, not at the airport.
- **Late August is wet season, and the tickets cannot be moved.** That combination is the
  single biggest exposure on this trip. Watch the forecast from about a week out.
- **Cash.** ATMs on the island are few and unreliable, and boats, habal-habal and island
  fees are cash only. Draw in Davao.

## Not confirmed, do not state as fact

- The **environmental fee** collected from arriving visitors at Sayak. It exists; the
  amount was not verified, so the page says to have small notes ready and nothing more.
- All prices other than the flight fares. Nothing else has been checked against a live
  source.
