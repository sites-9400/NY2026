/* Light / dark switch for the SEA trip pages.
   Load it in <head> (not deferred) so the saved choice applies before the page
   paints; otherwise a dark-mode reader gets a white flash on every page.
   With no saved choice the page follows the phone (prefers-color-scheme).
   A tap flips the current look and remembers it on this phone only. Choosing
   the same look as the phone forgets the choice, so it follows the phone again. */
(function () {
  var KEY = "sea-theme";
  var root = document.documentElement;
  var mq = window.matchMedia ? window.matchMedia("(prefers-color-scheme: dark)") : null;

  function saved() { try { return localStorage.getItem(KEY); } catch (e) { return null; } }
  function save(v) { try { v ? localStorage.setItem(KEY, v) : localStorage.removeItem(KEY); } catch (e) {} }
  function system() { return mq && mq.matches ? "dark" : "light"; }
  function current() { return root.getAttribute("data-theme") || system(); }

  var s = saved();
  if (s === "light" || s === "dark") root.setAttribute("data-theme", s);

  var MOON = '<path d="M20 14.5A8 8 0 0 1 9.5 4a8 8 0 1 0 10.5 10.5z"/>';
  var SUN = '<circle cx="12" cy="12" r="4"/><path d="M12 2.5v2M12 19.5v2M2.5 12h2M19.5 12h2M5.3 5.3l1.4 1.4M17.3 17.3l1.4 1.4M5.3 18.7l1.4-1.4M17.3 6.7l1.4-1.4"/>';

  function paint(btn) {
    var dark = current() === "dark";
    // The icon shows where a tap takes you.
    btn.innerHTML = '<svg class="ic" viewBox="0 0 24 24" aria-hidden="true">' + (dark ? SUN : MOON) + "</svg>";
    btn.setAttribute("aria-label", dark ? "Switch to light mode" : "Switch to dark mode");
    btn.title = btn.getAttribute("aria-label");
  }

  function init() {
    var header = document.querySelector("header.top");
    if (!header) return;
    var btn = document.createElement("button");
    btn.type = "button";
    btn.className = "theme-btn";
    paint(btn);
    btn.addEventListener("click", function () {
      var next = current() === "dark" ? "light" : "dark";
      if (next === system()) { root.removeAttribute("data-theme"); save(null); }
      else { root.setAttribute("data-theme", next); save(next); }
      paint(btn);
    });
    if (mq && mq.addEventListener) mq.addEventListener("change", function () { paint(btn); });
    header.appendChild(btn);
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
