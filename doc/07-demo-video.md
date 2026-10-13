# Demo video: script and shot list

For the developer, who records it. The rules: **under 2:00**, public on
YouTube or Vimeo, the app on its target devices (an Android phone and the
web), English, no copyrighted music and no third-party trademarks. This
replaces the draft outline in `03-mvp-scope.md` §9.1: the spot check was cut,
and the site comes from GPS, not a Plus Code.

Ready-made files in [`video/`](video/):
- `01_problem.png`, `02_title.png`, `03_built_with.png`: the cards, 1920×1080;
- `plotwatch-demo.srt`: the subtitles, timed to the script below.

---

## Before recording
- **Two accounts** on https://plotwatch.serverpod.space, made by email
  sign-up rather than Google, so no Google logo appears on screen:
  - **Ada** (the funder) on the computer, in a browser;
  - **Joseph** (the site manager) on the Android phone, with the release APK.
- **Ada creates a new project**, "Ndoumbe House", from a template, with a
  budget, **before** recording scene 2's takes, so you can record it calmly.
  Or record it as it happens; scene 2 is short.
- **Go outdoors** for scenes 3 and 4, with good GPS (sky in view) and the
  phone's location on. Pick a spot you can walk about 80 m away from.
- **Phone:** turn on Do Not Disturb, set the battery to 100 % or hide the
  status bar, and use the app in English.
- **Browser:** a clean window (no bookmarks bar or other tabs), zoomed to
  about 110 %.
- **Recorders:**
  - the phone's built-in screen recorder, or `scrcpy` on the computer;
  - OBS or the Windows Snipping Tool's recorder for the browser;
  - both at 1080p.
- **No music.** Your own voice only.

## The script (about 230 words, 1:58)
Read at a calm pace. The times are where each line starts.

| Time | Picture | Voice-over |
|---|---|---|
| 0:00 | Card `01_problem.png` | You live abroad, and you're building a house back home. Every month you send money, and you get photos on your phone. Were they taken on your plot? This week? |
| 0:12 | Card `02_title.png` | Plotwatch replaces trust with evidence. |
| 0:16 | **Scene 1: setup** (web, then phone) | Ada, the funder, creates a project from a template, with its stages and budget, and invites her site manager. Joseph joins with the code. |
| 0:30 | **Scene 2: the site** (phone, then web) | On the plot, Joseph localizes the site with his phone's GPS. Ada checks it on the map and sets the boundary. |
| 0:42 | **Scene 3: verified capture** (phone and web side by side) | Now Joseph photographs the work, only through the app's camera, never the gallery. Seconds later it appears on Ada's screen, live, and it's verified. The server checked the position against the boundary, the time against its own clock, and the photo's fingerprint. |
| 0:58 | **Scene 4: unverified** (phone, then web) | A photo taken eighty metres away? Unverified, and Plotwatch says exactly why. |
| 1:05 | **Scene 5: review** (phone, then web) | When every required photo is in, Joseph submits the stage. Ada is notified at once, reviews the evidence and approves. Plotwatch offers to record the next payment. |
| 1:25 | **Scene 6: money** (web, the demo project) | Every payment and expense lands in a shared ledger, with receipt photos. Entries are never edited, only reversed. And Plotwatch flags money that isn't backed by receipts yet. |
| 1:45 | Card `03_built_with.png` | Plotwatch is built with Flutter and Serverpod: live streams, scheduled tasks, verified uploads and authentication, on Serverpod Cloud. Try it at plotwatch dot serverpod dot space. |
| 1:58 | End | |

## The shot list
Record each scene as one or two short takes; you'll trim them in the editor.

### Scene 1: setup (0:16–0:30, 14 s)
1. **Web, as Ada:** Projects › **New project**: the name "Ndoumbe House",
   New house, FCFA, then **Start from “Single-storey house”**; show the stages
   with their budgets; **Create project**.
2. **Web:** project › **Invite** › Site manager › the code appears (show it).
3. **Phone, as Joseph:** **Join with a code** › type the code › **Join the project**. The
   project opens.

### Scene 2: the site (0:30–0:42, 12 s)
1. **Phone, on the plot:** the project › **Localize the site**; wait until the
   accuracy is below 20 m, then confirm.
2. **Web:** Ada sees the proposal on the map › set the radius (30–50 m) ›
   **Validate**. The project becomes Active.

### Scene 3: verified capture (0:42–0:58, 16 s): the key moment
Record **both screens at the same time**; you'll put them side by side.
1. **Web:** Ada keeps the project's Overview or Activity open.
2. **Phone:** Stages › the first stage › a checklist item › **Take a photo** ›
   **Use this photo** › it uploads.
3. **Web:** the photo **appears by itself** with **Verified**. Ada taps it:
   the checks list (inside the site, accurate GPS, server time, hash).

### Scene 4: unverified (0:58–1:05, 7 s)
1. **Walk about 80 m away.** Phone: capture another item.
2. **Web:** it arrives **Unverified**; tap it to show "Taken 82 m from the
   site centre; allowed: 58 m" (the radius plus the GPS accuracy).

### Scene 5: review (1:05–1:25, 20 s)
Before this scene, cover the stage's required items, inside the boundary.
1. **Phone:** the stage › **Submit for review**.
2. **Web:** the **bell** shows the notification at once › open it › the
   stage with its photos › **Approve**.
3. **Web:** the **Record a release** offer appears › **Record a release** ›
   the form opens with the next stage chosen (you can cancel here).

### Scene 6: money (1:25–1:45, 20 s), the demo project
1. **Web:** sign in as `funder@demo.plotwatch.app` (cut the sign-in out) ›
   Afesoh Residence › **Money**.
2. Show the summary: released, spent, with a receipt, and the **unaccounted
   alert**.
3. Tap the cement expense › the **receipt photo**.
4. Back › **By stage**, then back to **Entries**.

## Putting it together
- **Editor:** CapCut (desktop) or DaVinci Resolve, both free. Timeline at
  1920×1080.
- **Cards:** place them at 0:00, 0:12 and 1:45, for the times above.
- **Side by side:** in scene 3, put the phone on the left (scaled to the
  height) and the browser on the right.
- **Voice-over:** record it as one track, in a quiet room, with the phone's
  microphone close. Then cut the pictures to the voice.
- **Subtitles:** upload `plotwatch-demo.srt` to YouTube (Subtitles › Upload
  file › With timing). If your cut's timing differs, adjust it in YouTube's
  editor.
- **Export:** 1080p, MP4. **Check the length: under 2:00.**
- **YouTube:** title "Plotwatch: fund a building you can't watch being
  built". Set it to **Public** (Unlisted only if the rules accept it). In
  the description, the live URL and the repository.
