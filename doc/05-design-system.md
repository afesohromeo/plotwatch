# Plotwatch Design System: "Calm Ledger"

> **Status:** direction **A · Calm Ledger** approved by the developer on 2026-10-06 ("proceed with what you recommend"), chosen from three directions on the [design canvas](https://claude.ai/artifact/HkBGZE6BjTtff6HAKQXvoH). This file is the reference for every screen.
> **Scope:** light theme only for the MVP (decision 2026-10-04). Dark mode later.

---

## 1. Personality
Quiet and factual, like a well-kept account book. People use Plotwatch to handle money and proof, so it must feel **trustworthy and calm**: no gradients, no decoration for its own sake, generous spacing. Terracotta adds warmth; it's for photos and highlights, never for errors or status.

## 2. Colour tokens
All colours live in `MyAppColors` (`lib/src/core/my_app_colors.dart`), with the instance `customColors` in `lib/src/shared/utils/constant.dart`. Widgets read them from `customColors` or the theme, **never as literals**.

| Token | Hex | Use |
|-------|-----|-----|
| `primary` | `#0E5A52` | Brand, filled buttons, links, focus, progress |
| `onPrimary` | `#FFFFFF` | Text and icons on `primary` |
| `accent` | `#A44A24` | Photo thumbnails, highlights (secondary brand) |
| `accentSoft` | `#F6E7DE` | Background behind `accent` icons |
| `accentOnDark` | `#E8A27E` | The accent on `primary` backgrounds (app icon, splash): `accent` is too dark there. Brand assets only, not in `MyAppColors` |
| `ink` | `#15201E` | Main text, icons, app bar title |
| `muted` | `#55625F` | Secondary text, hints, captions (≥ 4.5:1 on white) |
| `line` | `#D3DAD7` | Borders, dividers, input outlines, progress track |
| `ground` | `#F4F6F4` | Page background behind cards |
| `surfaceWhite` | `#FFFFFF` | Cards, app bar, inputs, dialogs |
| `focusRing` | `#0E5A52` at 16 % | Soft ring around a focused input |
| `verified` / `verifiedSoft` | `#1D6A45` / `#E1F1E7` | Badge: Verified |
| `partial` / `partialSoft` | `#7A4F00` / `#FBEFD5` | Badge: Partially verified |
| `unverified` / `unverifiedSoft` | `#A3262A` / `#FBE4E4` | Badge: Unverified; **also the error colour** |

**Rules**
- Status is never shown by colour alone: every badge has an icon (check / triangle / cross) and text.
- The three status colours also differ in lightness, so they stay distinguishable in greyscale.
- `error` = `unverified`. Error dialogs and badges always pair the colour with an icon; field errors pair it with a message.

## 3. Typography
One family, **Manrope** (SIL Open Font License), **bundled** as five static weights in `plotwatch_flutter/assets/fonts/` (400, 500, 600, 700, 800). There's no runtime download, so it works with weak data and offline.

| Role (`TextTheme`) | Size / weight | Use |
|--------------------|---------------|-----|
| `displaySmall` | 34 / 800 | App name on the Welcome page |
| `headlineSmall` | 26 / 800 | Page headings ("Welcome back") |
| `titleLarge` | 18 / 700 | App bar titles, card titles |
| `titleMedium` | 16 / 700 | Section and list titles |
| `bodyLarge` | 16 / 500 | Input text, main body |
| `bodyMedium` | 15 / 400, `muted` | Explanations, subtitles |
| `bodySmall` | 13 / 500, `muted` | Captions, hints, meta |
| `labelLarge` | 16 / 700 | Buttons |
| `labelMedium` | 14 / 600 | Field labels |
| `labelSmall` | 12 / 700 | Badges |

Text colour is `ink` unless the role says `muted`.

## 4. Shape and spacing
- Corners: **12 px** for inputs, buttons and cards; **20 px** for dialogs; 999 px for badges.
- Spacing: `AppSpacing` from `app_theme_kit` (4 / 8 / 16 / 24 / 32). Page padding 24 px, card padding 16 px.
- Touch targets ≥ 48 px. Buttons and inputs are **52 px** high.
- Elevation: none on the app bar and cards; there, a 1 px `line` border does the separation. Dialogs float with a soft shadow over a 48 % dark scrim.

## 5. Components

| Component | Spec |
|-----------|------|
| **App bar** | `surfaceWhite` background, 1 px `line` bottom border, no elevation, no tint. Title `titleLarge` in `ink`, left-aligned. Icons `ink`. Text actions in `primary` (always readable). |
| **Input** | `surfaceWhite` fill, 1 px `line` border, radius 12, 52 px high. Label above the field (kept on 2026-10-06 at the developer's choice; the developer prefers the kit's floating label and it is a one-place switch in `InputField` if long forms, e.g. M6 ledger forms, get cramped) (`labelMedium`, `ink`). Focus: 2 px `primary`. Error: 2 px `unverified` border + message below in `unverified` (weight 600). Hint in `muted`. |
| **Password field** | An input with an eye button at the end (`PasswordVisibilityButton`). **The icon shows the current state:** open eye = password visible, crossed eye = hidden (developer's convention, 2026-10-06). Tooltip says what a tap does ("Show password" / "Hide password"). The visibility state lives in the page's BLoC. |
| **Primary button** | Filled `primary`, `onPrimary` text (`labelLarge`), radius 12, 52 px, full width in forms. Disabled: `line` fill, `muted` text. Loading: spinner in `onPrimary`. **No gradient.** |
| **Secondary button** | Outlined: 1.5 px `primary`, `primary` text, same size. |
| **Text button / link** | `primary`, weight 700. |
| **Error dialog** | `surfaceWhite`, radius 20, 24 px padding, content centred. 56 px circle in `unverifiedSoft` with a centred cross in `unverified`; message `bodyLarge` `ink`, centred; one full-width primary button (localized "OK"). Shown through `DialogUtils.handleFailure` (RULE-031). |
| **Success dialog** | Same layout, check in `verified` on `verifiedSoft`. |
| **Verification badge** | Pill: `*Soft` background, `*` text and icon, `labelSmall`. (Built in M4.) |
| **Card** | `surfaceWhite`, 1 px `line` border, radius 12, no shadow, on a `ground` page. |

## 6. Implementation (where each rule lives)

| File | Change |
|------|--------|
| `plotwatch_flutter/assets/fonts/` + `pubspec.yaml` | Manrope 400–800 + `Manrope-OFL.txt`; `fonts:` entry for family `Manrope` |
| `lib/src/core/my_app_colors.dart` | The tokens of §2 |
| `lib/src/shared/utils/constant.dart` | `customColors` with the §2 values |
| `lib/src/core/theme/plotwatch_theme.dart` (new) | `PlotwatchTheme.light(MyAppColors)`: `ColorScheme`, `TextTheme` (§3), app bar, input decoration, filled / outlined / text buttons, dialog, progress indicator, scaffold background |
| `lib/src/core/application_view.dart` | `theme: PlotwatchTheme.light(customColors)` (replaces `AppTheme.light` from `app_theme_kit`, whose text theme colours body text with the secondary colour and downloads Quicksand at runtime) |
| `lib/src/shared/components/custom_input_decoration.dart` | Uses the theme's input decoration; no more hard-coded red label/border and green focus |
| `lib/src/shared/components/input_field.dart` | Label above the field; text style from `bodyLarge` |
| `lib/src/shared/components/primary_button.dart` | Flat filled button per §5 (gradient removed) |
| `lib/src/shared/components/error_dialog.dart`, `congratulations.dart` | Layout of §5 with a localized OK button |

**Tests (written first):** `test/core/theme/plotwatch_theme_test.dart` checks:
- the app bar is white with an `ink` title;
- inputs use the `primary` focus border, the `unverified` error border and 12 px corners;
- the font family is Manrope;
- buttons have no gradient and are 52 px high.

Widget tests for `ErrorDialog` cover the message, the icon and the OK button closing it.

## 7. Later (not in the MVP)
- Dark theme.
- ~~App icon and splash in the brand colours.~~ Done 2026-10-07 (§8).
- A Stitch project with `.stitch/DESIGN.md` mirroring this file, if UI generation is used.

## 8. Logo, app icon and splash (2026-10-07)
**Logo D1** (chosen by the developer on the [concept canvas](https://claude.ai/artifact/SzFhi7nQJVq31FcmB3heEi); plan in [`04b` group E2](04b-m2-projects-site-members.md)): a location pin (the site) whose head holds an outlined house with two stage bars (built in stages); the current stage is in the accent.

| Level | Detail | Used for | Source in `plotwatch_flutter/assets/brand/` |
|-------|--------|----------|----------------------------------------------|
| Full | Two stage bars | Welcome page (`primary` lines, `accent` stage); splash before Android 12, iOS and web (white on the full-screen `primary`) | `mark_full.svg`, `splash_mark.svg` |
| Launcher | One `accentOnDark` stage bar, thicker lines | App icon: adaptive foreground, legacy/iOS/web icon, Android 12 splash icon | `mark_launcher_foreground.svg`, `icon_launcher.svg`, `splash_android12.svg` |
| Monochrome | Launcher geometry, one colour | Android 13 themed icon | `mark_monochrome.svg` |
| Tiny | The pin only | Favicon | `mark_tiny.svg` |

- The SVGs are the source. `tool/export_brand_pngs.cmd` exports the PNGs with headless Chrome; `flutter_launcher_icons.yaml` and `flutter_native_splash.yaml` turn them into platform icons and splash screens. The PNGs are committed so a clone builds without Chrome.
- Icon and splash background `primary` (the whole screen on the splash, developer's choice); marks white on `primary`.

## 9. Design pass: "Calm Ledger, with depth" (2026-10-10) — approved as written by the developer
**Canvas:** [Plotwatch design pass](https://claude.ai/artifact/568P9kVka8RQ8wLvWeNDmT): page 1 the three directions, page 2 the chosen one on the phone, page 3 on tablet and web.
**Chosen by the developer (2026-10-10):** direction **A** (Ledger, with depth) **with B's photos** (latest photo on the project card, photo grid on the stage page). It answers "too flat" (M3-13) and the navigation problem (`04e` M5-F3).

### 9.1 Decisions
| # | Decision |
|---|----------|
| DP-1 | **Palette and font unchanged** (§2, §3). New tokens: `primarySoft` `#E6EFED` (selected tab, icon tiles), `lineSoft` `#E7ECEA` (dividers inside cards), `surfaceSubtle` `#FAFBFA` (card footers). The `accentOnDark` `#E8A27E` joins `MyAppColors` for the stage bar on the teal hero. Terracotta keeps its role and gains one: **"needs your attention"** (the review card, a submitted stage). Status colours stay as they are. |
| DP-2 | **Depth:** cards get radius **16** (was 12) and a soft two-layer shadow over the 1 px `line` border; the hero block radius 18 with a teal shadow. Inputs and buttons stay at 12. |
| DP-3 | **Project shell (N-2):** inside a project, four destinations: **Overview · Stages · Money · Activity**, the same on every width. **Money appears with M6**; until then three. Phone (< 600 px): bottom bar. Tablet (600–1100): side rail, icons and labels. Web (> 1100): sidebar with the project's name and role, the tabs, a counter on Stages for what waits for the user, and "All projects". Built with GoRouter's `StatefulShellRoute`: each tab keeps its own page stack, so switching tabs and coming back returns where you were. |
| DP-4 | **Members** is not a tab: a **members card** on the Overview tab (initials, "4 members", roles, **Invite** for the owner) opens the current Members page, unchanged; the ⋮ menu of the project page links to it too (developer, 2026-10-10). |
| DP-5 | **Breadcrumb (N-1)** under the app bar on every page below a tab: *Projects › Maison Douala › Stages › Walls › Photo*; every part but the last can be tapped; on a phone the middle parts fold into "…" when it doesn't fit. Built from the router's matched routes and the names the pages already load. |
| DP-6 | **The bell (N-3)** with its unread count in the app bar of every signed-in page, not only the project list. |
| DP-7 | **Back** keeps going up one level (the Android button too); the breadcrumb and the tabs are the shortcuts. |
| DP-8 | **Wide layouts move widgets, not just stretch them:** project list 1 / 2 / 3 columns of cards; project page one column / two columns (hero, review, members, photos left; activity right) / hero beside the latest photo, stage table, live activity on the right; stage page one column / checklist beside the photo (tap an item, its photo shows) / checklist, photo with thumbnails, the checks with Approve and Request changes. Forms, sign-in and the profile stay one centred readable column on wide screens. |
| DP-9 | **Screens redrawn:** project list, project Overview tab, Stages tab (vertical timeline, the stage needing you outlined in terracotta, a photo per stage), stage page (photo grid, checklist with badges, review buttons fixed at the bottom), photo page (large photo, the verdict block, who took it and when, link to the checks), Activity tab (grouped by day, updates as posts), Members page, notifications ("New" and "Earlier"). Other screens get the new look from the theme and the shared widgets only. |

### 9.2 Work, in this order
| Group | What | Estimate |
|-------|------|----------|
| DP-A | Theme and tokens (DP-1, DP-2); shared widgets: `AppCard`, `StageBar` (one segment per stage, coloured by status), `HeroProgress`, `AttentionCard`, `MembersCard`, `PhotoStrip` / `PhotoGrid`, `Breadcrumb`, `NotificationBell` everywhere | 2 h |
| DP-B | Project shell: `StatefulShellRoute` with Overview, Stages, Activity (Money slot ready for M6); bottom bar / rail / sidebar by width; stage, photo, capture, members, update pages below their tab; breadcrumb from the routes; deep links and Back unchanged | 3 h |
| DP-C | Phone screens of DP-9 | 3 h |
| DP-D | Tablet and web layouts of DP-8 | 2–3 h |

About a day in total, which pushes M6 to D8 afternoon. If time runs short, the web stage page's three columns (DP-D) fall back to the tablet's two.

**Tests:** the theme test updated (tokens, radii); the shell shows the bottom bar at 390 px, the rail at 800 px and the sidebar at 1280 px, and keeps each tab's page when switching; the breadcrumb's parts open their pages; the members card opens the Members page; the bell is on every signed-in page; `StageBar` colours one segment per stage status. Existing page tests are updated where layouts move. As agreed for this session, the tests run once at the end of each group.

**You run** after each group: `dart run build_runner build --delete-conflicting-outputs` (if a BLoC changes), `flutter gen-l10n` (new texts), `dart format .`, `dart analyze`; then a look on the emulator and in Chrome at full width and narrowed.

### 9.3 Fidelity fix (2026-10-10, approved)
The developer's review of the first build: about 60/100 against the canvas. The app bar, its actions, the create button and most bodies didn't follow the mockups, and the Members page wasn't redrawn ("preserve the design" meant the canvas's Members page, not the old screen). The result had never been compared to the canvas.

**Fix:**
1. Rebuild screen by screen from the canvas's markup (sizes, colours, spacing, type), starting with the shared app bar and the project list: the app bar (title with a subtitle line, the bell, ⋮ for the rest), the labelled "+ New project" button, then Overview, Stages, stage page, photo page, Activity, Members, notifications, and the tablet and web layouts.
2. Check before handing over: a screenshot test (`tool/screenshots/`, not part of the test suite) renders each page at 390×844, 1024×768 and 1440×900 with the real font and sample data; each image is compared with its mockup and the gaps fixed; the screenshots go on a "built vs design" page of the canvas.
3. The developer's two changes: the logo and the app name in the primary colour (app bar, sidebar, rail); the bell opens the notifications on top of the current page, so Back returns there.

### 9.4 Review round 2 (2026-10-10, approved)
1. **Secondary panels on a phone:** a segmented switch shows one panel at a time instead of a long column of cards: Overview *Activity · Site · About*, stage page *Checklist · Photos · History*, photo page *Details · Checks*. Side by side in columns on tablet and web.
2. **App bar actions:** one action is its own icon button; ⋮ only for two or more. Refresh is an action on every platform, as well as pull-down (corrected 2026-10-10: the developer asked for single actions to leave the menu, not for Refresh to go on phones).
3. **The progress update page** (and the form to post one) is designed on the canvas first, then built.
4. **Bug:** after withdrawing a photo, the stage page didn't show it withdrawn until refreshed by hand. Reproduced in a test first, then fixed.
5. **Sorting, filtering, search** where lists grow:
   - project list: search by name, status chips (All · Active · Paused · Completed · Archived), sort (latest activity, name, progress), on the server;
   - Activity: kind chips (All · Photos · Reviews · Updates · Members · Site) and a stage picker, on the server for pages, in the app for live events;
   - notifications: All / Unread, on the server;
   - Stages tab: All · Needs you · In progress · Late · Approved, in the app;
   - a stage's photos: by checklist item and by badge, in the app.
6. **Also checked on every redrawn screen:** empty, loading and error states, and that each action refreshes what it changed.

### 9.5 Step 5 in detail: search, filters, sorting (2026-10-10, approved)
**Server (built and tested, 13 tests in `list_filters_test.dart`; recorded here):**
- `project.list(status?, search?, sort?)`. Search finds names containing the term, whatever the case; `%` and `_` are literal. `ProjectSort` is `recent` (the latest activity first, the default), `name`, or `progress` (the furthest along first). `recent` and `progress` are ordered in the server's memory before paging: a user is in tens of projects, and progress is computed from the stages.
- `activity.list(types?, stageId?)`. `ActivityEvent` gains `stageId`, filled where events are recorded (the target stage, or the `stageId` in the payload). No foreign key: a stage's deletion is recorded after the row is gone. Events recorded before the migration have no stage, so the stage filter leaves them out.
- `notification.list(unreadOnly?)`.

**App (to build):**
- **Shared components:**
  - `FilterChips<T>`: one row of pill chips, scrolling sideways, one chosen at a time. The chosen one is filled in the primary colour; the others are white with a line.
  - `SortButton<T>`: an icon that opens the choices, with a check on the current one.
  - The kit's `SearchInputField`, with the standard 500 ms debounce (`_standards/06`).
- **Pattern** (`_standards/13`): the page keeps the choices, every fetch event carries them, and changing one refreshes the list from page 0. The status is `filtering` while a search term is set (`_standards/02`).
- **Empty results:** when a filter or search is on, "Nothing matches" with **Clear filters**, instead of the empty-list text.
- **Project list:**
  - Layout: a search field with the sort button beside it, then the status chips.
  - Drafts show under *All* only.
  - Web: the heading's count is the number shown.
- **Activity:**
  - Kind chips: *All · Photos · Reviews · Updates · Members · Site*.
  - The kinds group the event types: Photos = taken, withdrawn; Reviews = submitted, approved, changes requested; Updates = progress updates; Members = joined, removed, role changed; Site = proposed, rejected, changed. Project and plan events, and a stage starting, show under *All* only.
  - The stage picker is a chip, "All stages ▾". It opens the project's stages, taken from the project shell.
  - Live events that don't match the choice are left out.
- **Notifications:** *All · Unread* chips under the app bar. In *Unread*, a notification read by tapping it stays until the list is refreshed, so nothing moves under the finger.
- **Stages tab:**
  - Chips: *All · Needs you · In progress · Late · Approved*. *Needs you* uses the attention rule (DP-1); *Late* is `isLateOn` (M5-10).
  - Each stage keeps its plan number.
  - Dragging to reorder works under *All* only.
  - A chip with no stage shows "No stage here".
- **A stage's photos:**
  - A badge row (*All · Verified · Partial · Unverified*) and a checklist item picker ("All items ▾").
  - With no filter, the five-photo mosaic stays as designed. Tapping "+N", or choosing a filter, shows a grid of every matching photo, three across, each with its badge dot.
- **Tests:**
  - bloc tests: the fetch events carry the filters, live events are filtered;
  - widget tests: choosing a chip or a sort refreshes with it, search waits for the debounce, Clear filters resets, the local filters on Stages and photos;
  - component tests for `FilterChips` and `SortButton`.
- **You run:** `dart run build_runner build --delete-conflicting-outputs` (the Freezed events and states), `flutter gen-l10n` (the new texts), `dart format .`, `dart analyze`.
