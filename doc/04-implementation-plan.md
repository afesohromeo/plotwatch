# Plotwatch MVP Implementation Plan

> **Status:** v1.0, approved by the developer on 2026-10-04 (open to clarification while reading)
> **Date:** 2026-10-04
> **Sources:** [03-mvp-scope.md](03-mvp-scope.md) (scope, schedule, acceptance criteria), [02-requirements-specification.md](02-requirements-specification.md) (requirements, architecture, data model, flows), [`_standards/`](../_standards/README.md) with [`14_serverpod_adaptation.md`](../_standards/14_serverpod_adaptation.md) on top.
> **For agentic workers:** this is the **master plan**. Each milestone gets its own detailed plan (bite-sized TDD steps with code and commands, `superpowers:writing-plans` format) in `doc/04x-…md`, written just before the milestone starts and approved by the developer before any code is written.

**Goal:** deliver the MVP core loop of [03 §1](03-mvp-scope.md#1-mvp-goal), deployed on Serverpod Cloud, and submit it before **14 Oct 2026, 23:59 CEST** (target: Tue 13 Oct).

**Architecture:** one Dart workspace with a Serverpod 4 server (models → thin endpoints → domain services, PostgreSQL, Serverpod Cloud storage, streams, future calls), the generated client, and one Flutter app for Android and web (Clean Architecture + flutter_bloc per `_standards/`). The server also hosts the Flutter web build, so one Serverpod Cloud deployment serves both the API and the web app.

**Tech stack:** Serverpod 4.0.3 (exact pins), `serverpod_auth_idp` (email + JWT), Flutter 3.47.5 / Dart 3.13.4, flutter_bloc + Freezed, go_router, `flutter_localizations` + ARB (EN/FR), `infinite_scroll_pagination`, `google_maps_flutter` + `geolocator` + `open_location_code`, `camera`, `crypto`.

---

## 1. How we work

### 1.1 Two levels of plans
| Level | File | Contains | Approved |
|-------|------|----------|----------|
| Master | this file | Repo layout, milestones, scope per milestone, tests, exit criteria, risks | Once, now |
| Milestone | `doc/04a-m1-foundation.md`, `doc/04b-m2-projects-site-members.md`, … | Every file, every test (code), every command, in TDD order | Before each milestone |

A milestone plan may adjust details of this file. Any change to **scope** or to an **approved decision** goes back to the developer first.

### 1.2 Who runs what (decided 2026-10-04)
| Who | Runs |
|-----|------|
| **Developer** | Everything except tests: `serverpod create` / `start` / `generate` / `create-migration`, `serverpod cloud launch` / `deploy`, `dart run build_runner build --delete-conflicting-outputs`, `flutter gen-l10n`, `dart analyze`, `dart format`, `flutter run` / `build`, and installing packages |
| **Claude** | Only tests: `dart test` (server) and `flutter test` (app). Every other command appears in the plans as **"You run:"** with the expected output, and Claude waits for your result. |

**Git (decided 2026-10-04):** Claude commits and pushes after a meaningful amount of finished, tested work (e.g. a completed group of tasks), not after every approval. Each commit has a clear message and passing tests.

### 1.3 Every task, every day
- **TDD:** the test is written and seen to fail before the code that makes it pass ([14 §4.3](../_standards/14_serverpod_adaptation.md)).
- **Definition of done:** [03 §8](03-mvp-scope.md#8-definition-of-done-per-feature): plan approved, tests first, `_standards/` followed, analyze clean, all tests pass, server permissions tested, EN + FR strings, works on Android (and web for funder screens), deployed, committed.
- **Each day starts** by checking this plan and **ends with** tests green, code committed, and the Cloud deployment updated.
- **Judging weights guide trade-offs:** does it work 30%, use of the Serverpod stack 25%, craft 25%, usefulness 20%. A working core loop beats more features.

---

## 2. Target repository layout

Created in M1 with `serverpod create plotwatch --database --auth --webapp --no-redis --no-website --ide claude` in a temporary folder. The generated files are then **moved to the repo root**, so the repo doesn't nest `plotwatch/plotwatch/`. **The generated Flutter app is replaced with the developer's [flutter_bloc_kit](https://github.com/afesohromeo/flutter_bloc_kit)** (decision 2026-10-04, see [04a](04a-m1-foundation.md) task group A): the kit's `lib/`, `Makefile`, `l10n.yaml` and `analysis_options.yaml`, combined with the template's platform folders, workspace settings and `lib/driver.dart`. **The generated Flutter app is replaced with the developer's [flutter_bloc_kit](https://github.com/afesohromeo/flutter_bloc_kit)** (decision 2026-10-04, see [04a](04a-m1-foundation.md) task group A): the kit's `lib/`, `Makefile`, `l10n.yaml` and `analysis_options.yaml`, with the template's platform folders, workspace settings and `lib/driver.dart`.

```
plotwatch/                          (git root)
├── pubspec.yaml                    # Dart workspace (generated)
├── .gitignore                      # ours + template's, merged (see below)
├── .gitattributes  README.md  CLAUDE.md
├── .github/workflows/              # template CI: analyze, format, tests (kept)
├── doc/   _standards/              # unchanged
├── plotwatch_server/
│   ├── bin/main.dart   lib/server.dart
│   ├── lib/src/
│   │   ├── models/                 # *.spy.yaml (14 §1, §4.1)
│   │   ├── endpoints/              # thin endpoints, incl. the template's auth endpoints (moved from auth/)
│   │   ├── services/               # business logic
│   │   ├── future_calls/           # typed future calls (14 §4.1)
│   │   ├── web/                    # template's routes/ + public pages (stretch)
│   │   └── generated/              # never edited
│   ├── config/                     # development/test/staging/production.yaml; passwords.yaml gitignored
│   ├── migrations/                 # generated, committed, never edited (14 §4.2.7)
│   └── test/{integration,unit}/
├── plotwatch_client/               # generated, never edited
└── plotwatch_flutter/              # app code from flutter_bloc_kit
    └── lib/src/                    # _standards/01 + 14 §5
        ├── core/                   # application, app_initializer, routing/, layout/, l10n/, theme/
        ├── data/api/config/        # api_provider.dart (Serverpod Client), api_error_handler.dart
        ├── data/api/{feature}/     # {feature}_api_provider.dart
        ├── data/device/            # camera, location, hashing providers
        ├── domain/models/          # client-only Freezed models (PaginatedList, CaptureDraft…)
        ├── domain/repository/
        ├── features/{feature}/{bloc,views}/
        └── shared/{components,extensions,utils}/
```

**Agent tooling (decided 2026-10-04):**
- `--ide claude` registers Serverpod's MCP server (`serverpod mcp-server`: migrations, logs, hot reload while `serverpod start` runs) and installs Serverpod's agent skills.
- The skills stay **local** (gitignored), like the other skills. They're reviewed before use and follow the precedence rule in `CLAUDE.md`.
- The template's root `.gitignore` ignores all of `.claude/`. It's narrowed so `.claude/settings.json` stays committed.
- The useful parts of the template's `AGENTS.md` (MCP usage, the checklist after changes, the narrow migration note) are merged into `CLAUDE.md`, and `AGENTS.md` is removed.

---

## 3. Milestones

| # | Day | Date | Milestone | Closes | Detailed plan |
|---|-----|------|-----------|--------|---------------|
| M1 | D2 | Mon 10-05 | Foundation: project, CI, Cloud deploy, auth, app skeleton | AUTH-01/02/03/07/08, PROF-01–03, NFR-DEP | `04a-m1-foundation.md` |
| M2 | D3 | Tue 10-06 | Projects, site, membership | AC-2, part of AC-1 | `04b-m2-projects-site-members.md` |
| M3 | D4 | Wed 10-07 | Stages, templates, checklists, budgets | AC-1 | `04c-m3-stages.md` |
| M4 | D5 | Thu 10-08 | **Verified capture** | AC-3 | `04d-m4-capture.md` |
| M5 | D6 | Fri 10-09 | Review loop, progress updates, live feed and notifications | AC-4, AC-6 | `04e-m5-review-realtime.md` |
| M6 | D7 | Sat 10-10 | Ledger and dashboards | AC-5 | `04f-m6-ledger.md` |
| M7 | D8 | Sun 10-11 | Should-haves (evidence requests first), French review | AC-8, AC-7 | `04g-m7-should-haves.md` |
| M8 | D9 | Mon 10-12 | Hardening, core-flow integration test, demo data, release builds. **Feature freeze at end of day.** | All AC re-run | `04h-m8-hardening.md` |
| M9 | D10 | Tue 10-13 | Submission | 03 §9 checklist | `04i-m9-submission.md` |
| — | — | Wed 10-14 | Buffer until 23:59 CEST | — | — |

The order follows dependencies. Each milestone ends with something that runs end to end on the deployed build.

**Revised schedule (approved 2026-10-08, `04c` M3-12).** M2 ran from D3 to D5, two days late. M3 D5–D6, M4 D6–D7, a half-day design pass on the demo screens D7 (`04c` M3-13), M5 D7–D8, M6 D8–D9, M8 D9 (feature freeze), M9 D10, D11 buffer. **M7 is dropped as a milestone:** evidence requests become a stretch goal, other should-haves follow the cut order of `03` §3.4.

---

## 4. Milestone scope

### M1: Foundation (D2)
**Goal:** a deployed Serverpod 4 project with email sign-up/in, and an app skeleton that follows `_standards/`, so every later feature only adds code in the agreed places.

**Server**
- Create the project (§2) and move it to the repo root; the first migration is committed.
- Remove the template's greeting example; move the auth endpoints to `endpoints/`.
- Models: `AppErrorCode` (start with the auth codes and `permissionDenied`), `AppException` (14 §2.1), `UserProfile` (02 §7.2).
- `ProfileEndpoint`: `getMe` (creates the profile on first call), `updateMe` (name, country, locale).
- Tests (integration): `getMe` unauthenticated → unauthorized; first call creates the profile; `updateMe` validates the locale (`en` / `fr` only).

**Client**
- Core: `application.dart`, `app_initializer.dart`, theme, `ResponsiveScaffoldWrapper` / `ResponsiveLayout` (06), GoRouter with named routes, auth-guard redirect, `NoTransitionPage` (07), l10n EN/FR with `LocalizationService` (12).
- Data: `ApiProvider` (one `Client`, 14 §2.4), `ApiErrorHandler` and the exception classes (14 §2.2–2.3.1), `PaginatedList<T>` (14 §3.2).
- Features: `auth` (Welcome, Sign in, Sign up, Verify email, Forgot password), on `serverpod_auth_idp_flutter`, wrapped in our BLoC pattern; `profile` (Profile / Settings, language switch).
- Tests: `ApiErrorHandler` unit tests (every mapping row in 14 §2.2); `AuthBloc` / `ProfileBloc` `bloc_test`s; widget tests for Sign in and Profile.

**Delivery**
- CI workflows adapted (Serverpod 4.0.3, Flutter 3.47.5).
- First `serverpod cloud launch` (API + web app hosted by the server), with the Serverpod Cloud email service sending verification codes in production.

**Exit:** on the Cloud URL, a new user can sign up, verify their email, sign in, set the language to French, sign out. Android debug build does the same against Cloud.

**You'll need:** a Serverpod Cloud account (no project yet). Android application ID: `com.afesohromeo.plotwatch` (§8).

### M2: Projects, site, membership (D3)
**Goal:** a funder creates a project with a site and invites a site manager, who joins.

**Server**
- Models: `Project`, `Site`, `ProjectMember`, `Invitation`, `AuditLog`, `ActivityEvent` (written now, streamed in M5), with their enums and indexes (02 §7.3).
- Services:
  - `PermissionService`: the **whole matrix of 02 §3.2**, so later milestones only call it.
  - `AuditService` and `ActivityService` (write only).
  - `GeoService`: haversine distance, Plus Code encode/decode.
- Endpoints: `ProjectEndpoint` (`create`, `list`, `get`, `update`, `setStatus`), `SiteEndpoint` (`get`, `set`), `MembershipEndpoint` (`createInvitation`, `listInvitations`, `cancelInvitation`, `previewInvitation`, `acceptInvitation`, `listMembers`, `removeMember`).
- Tests:
  - Unit: `GeoService`, plus the `PermissionService` matrix as a table-driven test over every role × action.
  - Integration: each endpoint, including the AC-2 cases (code reused, code expired, wrong role).

**Client**
- Features `projects` (list, create wizard: Details → Site → *Stages placeholder* → Review), `site` (site picker: Google Maps pin, Plus Code entry, radius), `members` (members list, invite with code + share link, join with code).
- Deep link `/join/:code`.
- Paginated project list (13).

**Exit:** AC-2 passes between two accounts on the deployed build. A project with a site exists (the template part of AC-1 comes in M3).

**You'll need:** the Google Maps keys (Android, web), restricted to the application ID and to the localhost + Cloud referrers.

### M3: Stages, templates, checklists, budgets (D4)
**Goal:** the project's stage plan, from a template and editable.

**Server**
- Models: `StageTemplate`, `StageTemplateItem` (built-in templates from 02 §12.1, localized names), `Stage` (status enum per 02 §10.1), `ChecklistItem`; `budgetMinor` as a 64-bit integer (BUD-01/02).
- Endpoints: `TemplateEndpoint` (`list`, `get`); `StageEndpoint` (`list`, `get`, `create`, `update`, `reorder`, `delete`, `applyTemplate`, `start`).
- Tests:
  - Owner-only editing.
  - Reorder keeps order indexes contiguous.
  - `applyTemplate` creates stages and items in one transaction.

**Client**
- Wizard Stages step (template picker).
- Stage list (with progress), stage detail (checklist), edit stage.
- Money formatting by currency and locale.

**Exit:** AC-1 passes completely on the deployed build.

### M4: Verified capture (D5)
**Goal:** the strongest demo moment, AC-3: a capture on site appears live for the funder, with an explained badge.

**Server**
- Model: `Evidence` (02 §7.2), lifecycle per 02 §10.4, `immutable` where fields must never change (14 §1.1).
- `VerificationService`: checks V1–V8 as **pure functions** with unit tests, plus the level rule of 02 §8.2 and the thresholds of §8.4.
- `MediaService`: upload description, re-hash after upload, display copy and thumbnail. Signed or private access to be confirmed against Serverpod 4 storage in the M4 plan.
- `EvidenceEndpoint`: `commit`, `finalize`, `get`, `list`, `getMediaUrl`, in the flow of 02 §9.1, inside a transaction.
- Tests: hash mismatch → `unverified` (AC-3); outside radius → `unverified` with distance detail; site manager only.

**Client**
- `data/device/`: camera provider (in-app only, no gallery anywhere), location provider (accuracy, mock flag), hashing provider.
- Features `capture` (camera with GPS / inside-site indicator, capture review, commit → upload → finalize) and `evidence` (evidence detail, verification breakdown, "where and when, not quality" notice, VER-10).

**Exit:** AC-3 on a **real Android device outdoors**, with the funder watching on web. The live part becomes automatic in M5; until then the funder refreshes.

**Risk:** camera and GPS plugins misbehaving. That's why this is tested on the real device on D5, not later.

### M5: Review loop and real time (D6)
**Goal:** AC-4 and AC-6: submit, review and request changes live between two devices.

**Server**
- Models: `StageReview`, `ProgressUpdate`, `Notification`.
- `StageEndpoint` `submit` / `review` (02 §9.2, transactions).
- `UpdateEndpoint` (`create`, `list`, `get`).
- `NotificationService`.
- `ActivityEndpoint` (`list`, keyset-paginated; `watch(projectId)` stream with catch-up from the last event ID, 02 §6.3.4).
- `NotificationEndpoint` (`list`, `markRead`, `markAllRead`, `watch()` stream).
- The exact Serverpod 4 streaming and channel APIs are confirmed in the M5 plan.
- Tests:
  - The permission cases of AC-4.
  - Submit refused when the checklist is incomplete.
  - Stream catch-up: no missing and no duplicate events (AC-6).

**Client**
- Features `review` (stage review screen), `updates`, `feed` (live list per 14 §3.3), `notifications` (centre + live badge).
- Stream errors are mapped to `NetworkException` with automatic reconnect.

**Exit:** AC-4 and AC-6 between Android and web on the deployed build.

### M6: Ledger and dashboards (D7)
**Goal:** AC-5: the money loop.

**Server**
- Models: `FundRelease`, `Expense` (negative amounts only in reversal entries).
- `LedgerService`: summary as pure, unit-tested functions; entries can't be edited; reversals.
- `LedgerEndpoint` (`recordRelease`, `recordExpense`, `reverse`, `list`, `summary`).
- Activity events and notifications when releases are recorded.
- Tests: the AC-5 numbers exactly (released 500,000, spent 350,000, with receipt 300,000, unaccounted 200,000); edits refused; reversals.

**Client**
- Feature `ledger` (summary, record release, record expense with receipt capture).
- `dashboard` (funder dashboard, site manager home).

**Exit:** AC-5 on both devices, live.

### M7: Should-haves (D8)
Built in **reverse cut order** ([03 §3.4](03-mvp-scope.md#34-order-in-which-features-get-cut-if-time-runs-short)), so the most valuable one comes first:
1. Evidence requests: model, endpoint, check V9, `EvidenceRequestDeadlineCall` future call (AC-8).
2. Hash chain (VER-05).
3. Fund requests + release confirmation (FREQ-01–04, LED-02).
4. Comments; Google sign-in; schedule status; inactivity reminder.

Also in M7:
- Unaccounted alert (LED-05) and the review → release shortcut (REV-06), where time allows.
- **French review pass** (AC-7): every screen of the core loop, including error codes and formatted dates and amounts.

**Exit:** AC-8 passes. Whatever isn't done by the end of D8 is cut.

### M8: Hardening (D9)
- One end-to-end server integration test of the core loop (AC-1 → AC-5 in sequence).
- Re-run every acceptance criterion by hand on Android + web.
- Fix bugs.
- Seed demo data (a believable project with stages, captures and a ledger).
- Build the release APK and the web build; final deploy.
- Stretch goals (03 §3.3) **only if everything is green**.
- **Feature freeze at the end of the day.**

### M9: Submission (D10)
Work through [03 §9](03-mvp-scope.md#9-hackathon-submission-checklist):
- README with build/run instructions.
- Project description, including the AI tool disclosure.
- Demo video under 2:00 on YouTube / Vimeo.
- Screenshots.
- Testing access (Cloud URL, APK, demo login) kept live until 20 Oct.
- Secret scan, then make the repo public.
- Submit on BuilderBase.
- Feedback form from [serverpod-feedback.md](serverpod-feedback.md).
- Social post.

---

## 5. Testing strategy
| Layer | Tool | What | Where |
|-------|------|------|-------|
| Server integration | `serverpod_test` (`withServerpod`, `AuthenticationOverride`), embedded test Postgres | Each endpoint method: happy path, every permission rule, every `AppErrorCode` | `plotwatch_server/test/integration/` |
| Server unit | `test` | Verification checks, ledger maths, geo, permission matrix | `plotwatch_server/test/unit/` |
| Client unit | `test` + `mocktail` (§8) | `ApiErrorHandler`, repositories (page model → `PaginatedList`) | `plotwatch_flutter/test/` |
| BLoC | `bloc_test` | Every event handler: success, each failure type | `plotwatch_flutter/test/features/{feature}/` |
| Widget | `flutter_test` | Each new screen renders its states (loading, error, data) and dispatches events | `plotwatch_flutter/test/features/{feature}/` |
| End to end | server integration (M8) + manual run of every AC on devices | Core loop | — |

Generated code (Serverpod, Freezed, l10n) must be up to date before tests run. The plans say exactly when you run `serverpod generate`, `build_runner` and `flutter gen-l10n`.

---

## 6. Cross-cutting choices made in M1
| Topic | Plan |
|-------|------|
| Versions | Serverpod packages pinned to `4.0.3` (the template default); Flutter packages pinned in M1 at their latest versions compatible with Flutter 3.47.5 |
| Web hosting | The Flutter web build is served by the Serverpod web server (template `flutter_build` script); one Cloud deployment for API + web |
| Email | Development: verification codes are printed in the server log. Cloud: Serverpod Cloud email service (template default) |
| Storage | Serverpod Cloud storage (`private` for evidence), database fallback locally (template default) |
| Secrets | `config/passwords.yaml` gitignored; Cloud secrets via `serverpod cloud password set`; Maps keys in a gitignored client config file (decided in M2) |
| CI | Template GitHub workflows (analyze, format, tests) kept and adapted |

---

## 7. Risks
| Risk | Mitigation |
|------|------------|
| Serverpod 4 APIs not yet used by us (streams, channels, private storage URLs) | Checked against the 4.0.3 sources in each milestone plan before coding, as done for `_standards/14` |
| Camera / GPS issues on the real device | Real-device test on D5 (M4), outdoors |
| Real-time edge cases | Catch-up by last event ID; AC-6 test in M5 |
| Serverpod Cloud trial or billing problems | Launch on D2 (M1), so problems surface a week before the deadline; trial covers judging |
| Maps billing surprises | Separate Google Cloud project, budget alert, restricted keys |
| Windows-only machine | iOS untested (accepted in D-4); Android + web are the targets |
| Scope creep / fatigue | Cut order (03 §3.4), feature freeze D9, buffer day |
| Approval waits slow the day | Each milestone plan is ready the evening before, so approval happens before the day starts |

---

## 8. Decisions taken with this plan (2026-10-04)
1. **Android application ID:** `com.afesohromeo.plotwatch` (also used to restrict the Android Maps key).
2. **Git:** Claude commits and pushes after a meaningful amount of finished, tested work, not after every approval (§1.2).
3. **Mocking library for client tests:** `mocktail` (no code generation).
4. **Detailed plans:** each milestone plan is written before its day starts, starting with `04a-m1-foundation.md` for D2.
