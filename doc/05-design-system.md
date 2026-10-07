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
