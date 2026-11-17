# Builds revive/quote.html: the estimator re-themed and configured for Revive Cleaning.
# Source: prism-clean.html. Every replacement must match, or the build stops.
#   powershell -ExecutionPolicy Bypass -File build-revive.ps1
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$s = [IO.File]::ReadAllText((Join-Path $here 'prism-clean.html'), [Text.Encoding]::UTF8)

function Sub([string]$old, [string]$new) {
  if (-not $script:s.Contains($old)) { throw "build-revive: pattern not found: $old" }
  $script:s = $script:s.Replace($old, $new)
}

# ---------- identity ----------
Sub '<title>revive cleaning</title>' '<title>Instant Quote | Revive Cleaning</title>'
Sub '<a class="brand" href="#top" aria-label="Prism Clean home">' '<a class="brand" href="./" aria-label="Revive Cleaning home">'
Sub '<b id="brandName">PRISM CLEAN</b><small id="brandTag">Residential cleaning</small>' '<b id="brandName">REVIVE CLEANING</b><small id="brandTag">Greensburg, PA</small>'
Sub "brand: 'PRISM CLEAN'," "brand: 'REVIVE CLEANING',"
Sub "tagline: 'Residential cleaning'," "tagline: 'Greensburg, PA',"
Sub "phone: '(555) 014-2290'," "phone: '(724) 309-5907',`n  email: 'Candis@revivecleaningcompanyllc.com',"

# header logo: house roofline mark
$logoStart = $s.IndexOf('<svg viewBox="0 0 40 40" fill="none" aria-hidden="true">')
$logoEnd = $s.IndexOf('</svg>', $logoStart) + 6
if ($logoStart -lt 0) { throw 'logo not found' }
$s = $s.Substring(0, $logoStart) + '<svg viewBox="0 0 40 40" fill="none" aria-hidden="true"><path d="M5 20 20 7l15 13" stroke="#FF4D5A" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"/><path d="M10 17v15h20V17" stroke="#F4F4F6" stroke-width="2" stroke-linejoin="round"/><path d="M27 11V6h3v8" stroke="#F4F4F6" stroke-width="2" stroke-linejoin="round"/><path d="M17 32v-7h6v7" stroke="#FF4D5A" stroke-width="2"/></svg>' + $s.Substring($logoEnd)

# ---------- palette: charcoal + Revive red ----------
Sub '--void:#05080F;' '--void:#0B0C0F;'
Sub '--deep:#0A1222;' '--deep:#15161B;'
Sub '--glass:rgba(13,22,42,.66);' '--glass:rgba(24,25,31,.72);'
Sub '--glass-hi:rgba(28,44,78,.72);' '--glass-hi:rgba(36,37,45,.8);'
Sub '--line:rgba(140,190,255,.14);' '--line:rgba(255,255,255,.09);'
Sub '--line-hi:rgba(140,220,255,.38);' '--line-hi:rgba(255,120,128,.42);'
Sub '--pearl:#E9F1FF;' '--pearl:#F4F4F6;'
Sub '--mute:#8794B2;' '--mute:#A0A2AC;'
Sub '--dim:#56627E;' '--dim:#62646E;'
Sub '--ion:#5CF2FF;' '--ion:#FF4D5A;'
Sub '--plasma:#9B7BFF;' '--plasma:#FF7A45;'
Sub '--flare:#FF7AB6;' '--flare:#FFB547;'
Sub "bathroom: { label: 'Bathroom',    color: '#5CF2FF' }" "bathroom: { label: 'Bathroom',    color: '#6FD3E8' }"
Sub "powder:   { label: 'Half bath',   color: '#5CF2FF' }" "powder:   { label: 'Half bath',   color: '#6FD3E8' }"
Sub 'rgba(92,242,255,' 'rgba(255,77,90,'
Sub 'rgba(155,123,255,' 'rgba(255,122,69,'
Sub 'rgba(255,122,182,' 'rgba(255,181,71,'
Sub 'rgba(140,190,255,' 'rgba(255,255,255,'
Sub 'rgba(140,220,255,' 'rgba(255,140,146,'
Sub 'rgba(5,8,15,' 'rgba(11,12,15,'
Sub 'rgba(5,10,22,.86)' 'rgba(14,15,19,.9)'
Sub '#0D1A33' '#1E1517'
Sub '#8FD8FF' '#FF6A4D'
Sub '#B9C9FF' '#FFC9CD'
Sub 'color:#04101A' 'color:#fff'
Sub 'linear-gradient(180deg,#0E1830,#080E1C)' 'linear-gradient(180deg,#1B1C22,#0F1014)'
Sub '0x05080F' '0x0B0C0F'
Sub '0x2a4a80, 0x17264a' '0x4a2a30, 0x24191c'
Sub 'rgba(92,160,255,0.45)' 'rgba(255,77,90,0.32)'
Sub 'rgba(92,160,255,0)' 'rgba(255,77,90,0)'
Sub '0x5CF2FF' '0xFF4D5A'
Sub 'rgba(160,250,255,' 'rgba(255,160,165,'
Sub '0x8FE8FF' '0xFF9AA0'
Sub 'color: 0x1a2a50, emissive: 0x24406e' 'color: 0x2a1c20, emissive: 0x40222a'
Sub '0x6a7cff, .35' '0x9a8a8f, .4'
Sub '0x9fd8ff, 0x1a0a33' '0xffe0e0, 0x1a0a0c'
Sub 'color: 0x9B7BFF, emissive: 0x9B7BFF' 'color: 0xFF4D5A, emissive: 0xFF4D5A'
Sub '0xB9A6FF' '0xFF8A8F'
Sub "color: 0xBFF8FF });" "color: 0xFFE0E0 });"

# ---------- services: add post-construction (one-time, like move-out) ----------
Sub "desc: 'Empty home, inside every cabinet and closet.' }" "desc: 'Empty home, inside every cabinet and closet.' },`n    postcon:  { label: 'Post-construction', mult: 2.2, time: 2.4, desc: 'Fine dust, debris and residue after a renovation or build.' }"
Sub "const mo = state.type === 'moveout';" "const mo = state.type === 'moveout' || state.type === 'postcon';"
Sub "'Move-in / move-out cleans are one-time visits, so no recurring discount applies.'" '`${C.types[state.type].label} cleans are one-time visits, so no recurring discount applies.`'
Sub "mo ? 'One-time move-in / move-out clean'" 'mo ? `One-time ${CONFIG.types[state.type].label.toLowerCase()} clean`'
Sub "if (state.type === 'moveout') state.freq = 'once';" "if (state.type === 'moveout' || state.type === 'postcon') state.freq = 'once';"
Sub '{ standard: 160, deep: PN, moveout: 300 }[state.type]' '{ standard: 160, deep: PN, moveout: 300, postcon: 420 }[state.type]'
Sub '{ standard: 0xBFF8FF, deep: 0xE6D9FF, moveout: 0xFFE2B8 }[state.type]' '{ standard: 0xFFE0E0, deep: 0xFFD2B8, moveout: 0xFFE2B8, postcon: 0xF0E6DA }[state.type]'
Sub '{ standard: .5, deep: .8, moveout: .65 }[state.type]' '{ standard: .5, deep: .8, moveout: .65, postcon: .9 }[state.type]'

# ---------- copy that must be true for Revive ----------
Sub "['Bonded & insured', 'Every cleaner is background-checked and covered, so nothing in your home is at risk.']," "['Insured', 'Every visit is covered, for your home and for our crew.'],"
Sub "['24-hour re-clean', 'Missed a spot? Tell us within a day and we come back to fix it at no charge.']," "['6+ years in Greensburg', 'Homes and businesses across the area have trusted us for over six years.'],"

# ---------- availability comes from the Revive site's calendar ----------
Sub 'const slotFull = (d, s) => { let h = 0; for (const ch of dKey(d) + s) h = (h * 31 + ch.charCodeAt(0)) >>> 0; return h % 4 === 0; };' 'const slotFull = (d, s) => { try { if (window.parent !== window && window.parent.reviveSlotTaken) return !!window.parent.reviveSlotTaken(dKey(d), s); } catch (e) { } return false; };'

# preselect a slot picked on the calendar (URL params on the full page, postMessage when embedded)
$pre = @'
const bookQuote = () => estimate(state, { offPeak: isOffPeak(dayOf(bk.date)) });
(() => {
  const q = new URLSearchParams(location.search);
  const pd = q.get('date'), pt = q.get('time');
  if (pd && days.some(x => dKey(x) === pd)) { bk.date = pd; if (pt && CONFIG.slots.includes(pt)) bk.time = pt; }
  if (q.has('embed')) document.documentElement.classList.add('embed');
})();
window.addEventListener('message', e => {
  if (e.origin !== location.origin) return;
  const m = e.data || {};
  if (m.type === 'revive-slot' && days.some(x => dKey(x) === m.date)) { bk.date = m.date; bk.time = CONFIG.slots.includes(m.time) ? m.time : null; }
});
function sendLinks(p, q) {
  const d = dayOf(p.date);
  const lines = [
    `Booking request ${p.ref}`,
    `${CONFIG.types[state.type].label} clean, ${d.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' })} at ${p.time}`,
    homeLine(),
    `Estimate: ${rangeTxt(q)}`,
    `Name: ${p.name}`, `Phone: ${p.phone}`, `Email: ${p.email}`,
    `Address: ${p.address}, ${p.zip}`,
    `Access: ${p.parking} / ${p.building} / ${p.entry}`,
    p.notes ? `Notes: ${p.notes}` : '',
    `For the crew: ${crewNotes()}`
  ].filter(Boolean);
  const body = encodeURIComponent(lines.join('\n'));
  const tel = CONFIG.phone.replace(/\D/g, '');
  return `<div style="display:flex;gap:10px;flex-wrap:wrap;justify-content:center;margin-top:6px">
      <a class="cta" target="_top" style="width:auto;padding:14px 22px;font-size:14px;text-decoration:none" href="sms:+1${tel}?&body=${body}">Text it to us</a>
      <a class="ghost" target="_top" style="text-decoration:none;color:var(--pearl)" href="mailto:${CONFIG.email}?subject=${encodeURIComponent('Booking request ' + p.ref)}&body=${body}">Email it instead</a>
    </div>
    <p class="demo">Your request goes out when you press send in your messages or email app. Or call ${CONFIG.phone}. We reply to confirm.</p>`;
}
'@
Sub 'const bookQuote = () => estimate(state, { offPeak: isOffPeak(dayOf(bk.date)) });' $pre.TrimEnd()
Sub "'Review and confirm', 'Request received'];" "'Review and confirm', 'Send your request'];"
Sub 'is in, estimated at ${rangeTxt(q)}. We confirm the final price before work starts. Keep this reference:</p>' 'estimated at ${rangeTxt(q)}. One last step: send it to us below and we reply to confirm the time and final price. Your reference:</p>'
Sub 'Your request for a ${CONFIG.types[state.type].label.toLowerCase()} clean at ${esc(bk.address)} ' 'Your ${CONFIG.types[state.type].label.toLowerCase()} clean at ${esc(bk.address)} is '
Sub '<p class="demo">Demo mode: requests are not sent anywhere until CONFIG.onBook is connected to a scheduler.</p>' '${sendLinks(payload, q)}'

Sub "const ref = 'PC-' +" "const ref = 'RC-' +"

# embedded mode: just the estimator, no page chrome
Sub '[hidden]{display:none!important}' '[hidden]{display:none!important}
.embed .top,.embed #trust,.embed #how,.embed footer{display:none!important}'

# ---------- wrap as a standalone page ----------
$head = @'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%}</style>
</head>
<body>
'@
$dir = Join-Path $here 'revive'
if (-not (Test-Path $dir)) { New-Item -ItemType Directory $dir | Out-Null }
$out = $head + "`n" + $s + "`n</body>`n</html>`n"
[IO.File]::WriteAllText((Join-Path $dir 'quote.html'), $out, (New-Object Text.UTF8Encoding($false)))
Write-Output "Wrote revive/quote.html ($($out.Length) chars)"
