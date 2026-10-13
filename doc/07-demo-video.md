# Demo video: script and shot list

For the developer, who records it. The rules: **under 2:00**, public on
YouTube or Vimeo, the app on its target devices (the web and Android),
English, no copyrighted music and no third-party trademarks. This replaces
the draft outline in `03-mvp-scope.md` §9.1.

**A tour of the demo project "Afesoh Residence"** (decided 2026-10-13).
Nothing is changed during the recording: you look and tap, but never
approve, confirm or post, so the judges find the same demo afterwards.

Ready-made files in [`video/`](video/):
- `01_problem.png`, `02_title.png`, `03_built_with.png`: the cards, 1920×1080;
- `plotwatch-demo.srt`: the subtitles, timed to the script below.

---

## What you need
- **Chrome on your computer**, signed in at https://plotwatch.serverpod.space
  as the funder, **`funder@demo.plotwatch.app`** (Brice).
- **Android**, the emulator or a real phone, signed in as the site manager,
  **`manager@demo.plotwatch.app`** (Joseph). With the emulator, point the app
  at Cloud: run it with `--dart-define=SERVER_URL=https://plotwatch.api.serverpod.space/`,
  or install the release APK.
- **A screen recorder:**
  - for Chrome: OBS, or the Windows Snipping Tool's **Record** button
    (Windows 11), set to the browser window;
  - for Android: the same recorder on the emulator window, or the phone's
    built-in screen recorder.
- **A quiet room** for the voice-over, and **no music**.

**Before recording:**
- **Chrome:**
  - one clean window, no bookmarks bar (Ctrl+Shift+B), no other tabs;
  - zoom about 110 %;
  - the app in English;
  - a window size of about 1600×900 looks good on video.
- **Android:** Do Not Disturb on, the app in English.
- **Do a first pass without recording**, so you know where everything is.

## The script (about 220 words, 1:58)
Record the voice-over first, reading calmly. Then record the pictures and
cut them to the voice. The times are where each line starts.

| Time | Picture | Voice-over |
|---|---|---|
| 0:00 | Card `01_problem.png` | You live abroad, and you're building a house back home. Every month you send money, and you get photos on your phone. Were they taken on your plot? This week? |
| 0:12 | Card `02_title.png` | Plotwatch replaces trust with evidence. |
| 0:16 | **Scene 1: the project** (Chrome) | Brice lives in Canada. He's funding a five-storey residence in Yaoundé. Plotwatch shows him the build stage by stage, and what needs him now. |
| 0:30 | **Scene 2: a verified photo** (Chrome) | Every photo is taken with the app's camera, on the plot. The server checks it: inside the site boundary, accurate GPS, its own clock, and the photo's fingerprint. Verified. |
| 0:48 | **Scene 3: a partly verified photo** (Chrome) | When a check fails, Plotwatch says so. This one is only partly verified: the GPS fix was weak. |
| 0:58 | **Scene 4: the review** (Chrome) | When the site manager submits a stage, Brice is notified at once. He approves it, or sends it back with a comment. |
| 1:10 | **Scene 5: on site** (Android) | On site, Joseph uses the Android app: the checklist, the camera, updates from the site, and payments to confirm. |
| 1:24 | **Scene 6: the money** (Chrome) | Every payment and expense goes into a shared ledger, with receipt photos. Entries are never edited, only reversed. And Plotwatch flags thirty-three million francs not yet backed by a receipt. |
| 1:45 | Card `03_built_with.png` | Plotwatch is built with Flutter and Serverpod: live streams, scheduled tasks, verified uploads and authentication, on Serverpod Cloud. Try it at plotwatch dot serverpod dot space. |
| 1:58 | End | |

### A generated voice instead of your own (optional)
**Google AI Studio's text-to-speech** (Gemini):
1. Open https://aistudio.google.com › **Generate speech**.
2. Choose a voice: a calm, warm one, the same for every clip.
3. For the style, write: *"Read in a calm, warm, confident tone, like a
   short product film. Natural pace, small pauses between sentences."*
4. Paste **one row of the script at a time** (one clip per row above), then
   generate and download each clip (`01.wav`, `02.wav`, …).
5. In the editor, put each clip at its row's time, then fit the pictures to
   the clips.

**This must be disclosed:** the submission's description lists it with the
other AI tools (Claude Code, Gemini for the demo photos, Gemini for the
voice).

## The shot list
Record each scene as one short take, moving slowly. Let each screen rest
1–2 seconds before the next tap; you'll trim in the editor.

### Scene 1: the project (Chrome, 0:16–0:30, 14 s)
1. Start on **Projects**: the Afesoh Residence card, with its latest photo
   and progress.
2. Click the card. The **Overview**:
   - the green progress card;
   - "Ground floor… is waiting for your review";
   - the money card;
   - the latest photo.
3. Scroll slowly down to **Latest activity**.

### Scene 2: a verified photo (Chrome, 0:30–0:48, 18 s)
1. **Stages** in the left menu: the six stages, two approved.
2. Click **1 · Site preparation**: its checklist with photos.
3. Click a photo: the full photo with **Verified**.
4. Scroll to the **checks**: inside the site, the accuracy, the time, the hash.

### Scene 3: a partly verified photo (Chrome, 0:48–0:58, 10 s)
1. **Stages › 3 · Ground floor: columns and slab.**
2. Click the photo marked **Partial** (slab reinforcement).
3. Show the failed check: "Accurate to only 45 m (allowed: 30 m)".

### Scene 4: the review (Chrome, 0:58–1:10, 12 s)
1. Back to **3 · Ground floor**: the **Waiting for your review** badge, and
   the **Request changes** and **Approve** buttons at the bottom.
   **Don't click them.**
2. Click the **bell**: the notification "Joseph Mvondo submitted…".
3. Close it, then **Activity** in the left menu: the feed over the past six
   weeks.

### Scene 5: on site (Android, 1:10–1:24, 14 s)
Signed in as Joseph, the site manager.
1. Projects › **Afesoh Residence**: the Overview on the phone.
2. **Stages** tab › **4 · Upper floors**: its checklist, with a
   **Take a photo** button per item. **Don't take one.**
3. Back › the **Money** tab › the release of 15,000,000 FCFA marked **Not
   confirmed yet** › open it: the **Confirm received** button. **Don't
   tap it.**

### Scene 6: the money (Chrome, 1:24–1:45, 21 s)
1. **Money** in the left menu: released 47.5 M, spent, with a receipt, and
   the orange **unaccounted** card.
2. Click the expense **Cement, 700 bags**: the entry and its **receipt
   photo**.
3. Back › the **By stage** panel: the money per stage.

## Putting it together
- **Editor:** CapCut (desktop) or DaVinci Resolve, both free. Timeline at
  1920×1080.
- **Order:**
  1. the voice-over track first;
  2. the cards at 0:00, 0:12 and 1:45;
  3. the scenes, cut to the voice.
- **Phone scene:** put the phone recording in the middle, on the green
  background of `02_title.png` or a plain colour, scaled to the height.
- **Subtitles:** upload `plotwatch-demo.srt` to YouTube (Subtitles › Upload
  file › With timing). If your cut's timing differs, adjust it in YouTube's
  editor.
- **Export:** 1080p, MP4. **Check the length: under 2:00.**
- **YouTube:** title "Plotwatch: fund a building you can't watch being
  built". Set it to **Public** (Unlisted only if the rules accept it). In
  the description, the live URL and the repository.
