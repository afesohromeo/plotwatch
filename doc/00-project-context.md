# Project Context & Session Handoff

> **Read this first.** This file records everything decided before any code was written: why this project exists, how the idea was chosen, the research behind it, the decisions made so far, and what to do next.
> **Created:** 2026-10-03, during the brainstorming session (held in the `plus_locate` workspace).
> **Last updated:** 2026-10-04
> **Product:** **Plotwatch**

---

## 1. Document index

| File | What it contains |
|------|------------------|
| [00-project-context.md](00-project-context.md) | This file: history, decisions, research, status, next steps |
| [01-project-overview.md](01-project-overview.md) | Problem, solution, users, objectives, differentiation, business model, roadmap, risks |
| [02-requirements-specification.md](02-requirements-specification.md) | Full functional and non-functional requirements (all phases), architecture (frontend, backend, database, storage, integrations), data model, verification engine, flows, state machines, open questions |
| [03-mvp-scope.md](03-mvp-scope.md) | What we build for the hackathon: in/out of scope, day-by-day plan, acceptance criteria, pending decisions, submission checklist, demo script |
| [04-implementation-plan.md](04-implementation-plan.md) | Master implementation plan: repo layout, milestones M1–M9 mapped to D2–D10, scope, tests and exit criteria per milestone. *Approved 2026-10-04.* Each milestone gets a detailed plan `04x-….md` |
| [04a-m1-foundation.md](04a-m1-foundation.md) | M1 detailed plan. Task group A (project creation + flutter_bloc_kit integration) approved 2026-10-04; groups B–E to follow |
| [serverpod-feedback.md](serverpod-feedback.md) | Feedback log on Serverpod SDKs/CLI/templates/docs, the source for the hackathon's Most Valuable Feedback form |

---

## 2. Instructions for a new Claude Code session

1. **Read in this order:** this file → `03-mvp-scope.md` → `02-requirements-specification.md` (sections relevant to the task) → `01-project-overview.md`.
2. **The user wants proper software development procedure. Do not fast-track.** Concretely:
   - Documents first, then an implementation plan, then code.
   - For every feature or fix: **present the plan, wait for the user's approval, save the approved plan as markdown in `doc/`, then implement step by step.** (The user has the same rule on their PlusLocate project.)
   - Don't treat proposals as decisions. Anything marked ⏳ in `03-mvp-scope.md §7` still needs the user's approval.
   - Ask questions when a decision is genuinely the user's to make; otherwise propose a recommendation.
3. **The user's binding engineering standards are in [`_standards/`](../_standards/README.md)** at the project root. They were copied on 2026-10-03 from `plus_locate/_standards` (identical to `bus tracking/smart_drive/_standards`; an older version also lives in `Flutter_Bloc_Kit/flutter_standards`, a GitHub repo). **All Flutter code must follow them:** Clean Architecture + flutter_bloc (BLoC pattern, Freezed events/state), `ResponsiveScaffoldWrapper` on every page, GoRouter named routes, no hardcoded text (ARB files), infinite-scroll pagination, and every RULE-* in `09_normalization_rules.md`. When generic advice (e.g. a skill recommending MVVM/ViewModels) conflicts with `_standards/`, **`_standards/` wins.**
   - `_standards/` was written for Dio/REST projects. How it maps onto Serverpod (generated models, error codes, page models, server conventions) was agreed on 2026-10-03 (D-12) and is written in **`_standards/14_serverpod_adaptation.md`**, which overrides files 01–13 where stated.
4. **Other engineering practices the user follows:**
   - TDD: no production code without a failing test first.
   - Systematic debugging: find the root cause before fixing.
   - Evidence before claims: run the tests/build and read the output before saying something works.
   - The user runs `build_runner` / l10n generation themselves in PlusLocate. Ask before assuming the same here.
   - PlusLocate review conventions the user enforces (likely to apply here too): import through the package barrel file, `context.goNamed(...)` instead of `context.go(path)`, colors from `customColors`, text styles from `context.textTheme`, and a dedicated l10n key for each error case (no generic `operationError`).
5. **Tooling (set up 2026-10-03):** `.claude/skills/`, `.claude/knowledge/` and `.claude/settings.json` were copied from PlusLocate. PlusLocate's `.claude/CLAUDE.md` (titled SmartDrive, recommends MVVM) and `GEMINI.md` were **not** copied; their useful parts are merged into the root `CLAUDE.md`, which lists the skills with notes on where `_standards/` overrides them. The `dart` and `stitch` MCP servers are registered for this folder in the user's local Claude Code config (`dart` via `cmd /c dart mcp-server`, because `dart` is a `.bat` on Windows). Both were verified as connected. `.stitch/` was **not** copied (it points to PlusLocate's Stitch project); create a new Stitch project when UI design starts.
6. **Keep this file up to date.** When a decision is made or a milestone reached, update §6 (decisions) and §8 (status).
7. **Serverpod 4 tooling (verified 2026-10-04 with a throwaway project; CLI 4.0.3, Flutter 3.47.5, Dart 3.13.4):**
   - Install: `dart install serverpod_cli` → `%LOCALAPPDATA%\Dart\install\bin\serverpod.bat` (added to the user PATH). From Git Bash call it through PowerShell, since `.bat` files don't run from bash.
   - Create: `serverpod create <name> --database --auth --webapp --no-redis --no-website --ide none` (`quickstart` = `create` with defaults plus an editor prompt). Produces a Dart **workspace**: root `pubspec.yaml` + `<name>_server/`, `<name>_client/`, `<name>_flutter/`, plus `AGENTS.md`, `.github/workflows/` (analyze, format, tests) and `.vscode/`. `--ide <claude|cursor|vscode|…>` installs Serverpod's own agent skills and MCP config.
   - Run: `serverpod start` (code generation, server, Flutter app, hot reload; `--no-tui --no-flutter` for headless). Ports: API 8080, Insights 8081, web 8082, dev DB 8090, test DB 9090.
   - **Docker is not needed.** `config/development.yaml` and `config/test.yaml` set `database.dataPath`, so Serverpod runs an **embedded PostgreSQL** (data in the gitignored `.serverpod/`). `docker-compose.yaml` remains as an alternative.
   - Tests: `dart test` in the server package (embedded test DB, `withServerpod` helper in `test/integration/test_tools/`). The test Postgres keeps running afterwards; there is no `serverpod database stop`.
   - Template defaults: `serverpod_auth_idp` email sign-in (verification codes logged to the console in development, sent by Serverpod Cloud email in staging/production), JWT tokens with refresh, Serverpod Cloud storage with a database fallback.
   - Agent MCP: `serverpod mcp-server` bridges to a running `serverpod start` (migrations, logs, hot reload/restart, launching the Flutter app).

---

## 3. The hackathon

| Item | Detail |
|------|--------|
| Event | Serverpod hackathon celebrating **Serverpod 4, Serverpod Cloud and App Studio** |
| Platform | BuilderBase |
| Deadline | Submission Period ends **14 October 2026, 23:59 CEST**, no extensions ([Official Rules](https://tinyurl.com/SP-rules) §1, read 2026-10-04). Judging 15–20 Oct; winners announced 22 Oct at the Full Stack Flutter conference. Our target: **Tue 2026-10-13**. |
| Requirement | A full-stack app with Serverpod as the backend. **Newly created during the Submission Period** (from 15 Sep 2026), the entrant's original work and solely owned by them. Open source may be included if its licences are respected. AI coding tools are allowed but **must be disclosed in the text description**. |
| Submission must include | (1) Repository URL with all source, assets and instructions needed to run the project. A private repo must be shared with viktor@serverpod.dev, alexander@serverpod.dev and isak@serverpod.dev. (2) Text description of features and how it was built. (3) Build and run instructions. (4) Demo video **under 2 minutes** (judges needn't watch beyond 2:00), public on YouTube or Vimeo, showing the app on its target device, with no third-party trademarks or copyrighted music without permission. (5) Testing access (website, demo or test build; login credentials if needed), free and unrestricted for the sponsor, administrator and judges until judging ends. Everything in English. |
| Judging | Stage 1: pass/fail eligibility (AI-assisted completeness check, reviewed by a person). Stage 2 weights: **Does it work 30%** (core flow completes, nothing critical faked), **Use of the Serverpod stack 25%**, **Craft and technical creativity 25%**, **Usefulness 20%**. Ties are broken on "Does it work" first. |
| Prizes | 1st $5,000 + $2,500 Cloud credits; 2nd $3,000 + $2,000; 3rd $1,000 + $1,500; 4th $500 + $1,500; 5th $1,500 credits; Most Valuable Feedback $500 + $500 (feedback form with actionable comments on Serverpod SDKs/App Studio/docs); Best Hackathon Post $500 credits. |
| IP | Entrants keep full ownership. Entrants grant Serverpod AB and BuilderBase Labs AB a non-exclusive, royalty-free licence for 12 months after the Submission Period to use, reproduce and display the submission for judging, administration and promoting/reporting on the hackathon (§7). Results publication includes name, project title, summary and, for placed entrants, the video (§10). |
| Getting started | Install Serverpod and do the [Quickstart](https://docs.serverpod.dev/quickstart); join the [Serverpod Discord](https://serverpod.dev/discord) |
| Bonus prize | Social media post tagging Serverpod: LinkedIn (Serverpod), X [@ServerpodDev](https://x.com/ServerpodDev), Bluesky [@serverpod.dev](https://bsky.app/profile/serverpod.dev) |
| Kickoff video | https://www.youtube.com/watch?v=DcQdzNgUjEM |

### 3.1 The user's goals
- Build something **real**, full-stack (frontend + backend + database), and **professional**.
- Something they can **keep working on after the hackathon** and **put in real users' hands** (mobile, desktop or web).
- They want ideas that are **impressive**. They rejected "safe/small" ideas twice.

### 3.2 About the user (relevant background)
- Flutter developer. Built **PlusLocate** (`C:\New_folder\g+code_project\plus_locate`), a Flutter app for generating, searching, saving and sharing Google Plus Codes. It uses provider, flutter_bloc, go_router, EN/FR localization and Shorebird. This gives directly reusable experience with **maps, location, Plus Codes and EN/FR localization**.
- Works on Windows 11 (PowerShell / Git Bash), VS Code.

---

## 4. How the idea was chosen (decision history)

### Round 1: practical ideas (rejected as "not impressive")
1. Virtual queue for walk-in businesses
2. Rotating savings group (tontine/chama/susu) ledger
3. Last-mile delivery dispatch for small merchants
4. Feature flags / remote config for Flutter apps
5. Inspection checklists for field teams

### Round 2: AI/real-time ideas (rejected as "still not convincing")
1. Live translated captions for events
2. Flutter bug reporting with session replay + AI triage
3. AI grading of handwritten exams
4. Multiplayer quiz built from your own documents
5. Crowd-sourced live outage/shortage map

### Round 3: "best ideas, ignore the 11-day constraint"
1. **Remote construction oversight for people funding builds they can't see** ← *chosen*
2. Proof-of-reality capture (verified photos/videos as infrastructure)
3. Approval layer for AI agents (human sign-off for agent actions)
4. Offline-first sync engine for Dart/Serverpod
5. Verified work history / credit for informal workers
6. One-phone match recording and stats for amateur sports

The user liked **#1 and #4**. #4 (sync engine) was explained as "the WhatsApp-offline behaviour, as a reusable component for other developers". It was set aside because it's a developer library rather than an app for end users, and because of the learning curve under deadline. It may come back later as offline mode for this product (requirement OFF-05).

### Ideas from ChatGPT that the user brought (evaluated, not chosen)
- **HomeOps** (maintenance history for buildings): real but crowded (Buildium, AppFolio…). **Kept as the natural later phase of this product** (requirements: MNT module, Phase 4).
- **LifeLedger** (inventory of household possessions): weak retention (enter once, rarely return); competitors exist (Sortly, Encircle).
- **WidgetFoundry** (Flutter component lab): overlaps directly with Widgetbook, which Serverpod/Flutter judges know.

### Concern raised and how it was resolved
- The user worried the **audience might be small**, since they only know one person in this situation.
- Research (§5) confirmed the problem is real and that people pay (competitors exist), but showed that the diaspora segment alone is niche in each country.
- **Resolution:** widen the target to **anyone funding a build they can't watch**: people abroad, people working in a city who build in their home town, NGOs/donors, small investors and landlords. Keep the diaspora story for the demo, where it has the most emotional pull.
- The user asked whether a user survey could be **simulated between two AI agents**. Answer: a simulation only reflects the assumptions put into it and can't validate demand. Real public evidence (web research) and the real contact are better. AI role-play is only useful for rehearsing an interview.
- **Final decision (2026-10-03):** proceed with remote construction oversight.

---

## 5. Market research findings
*(Web searches run on 2026-10-03)*

### 5.1 The problem is documented
Articles describe the same failure patterns in several countries: staged/"ghost" progress photos, quantity inflation, material substitution, large advances followed by stalled work, and funds diverted by relatives. The guides recommend **separating duties** (the person who reports progress shouldn't also be the one who receives the money) and **independent verification**.
- [How Diaspora Kenyans Lose Money When Building Back at Home](https://www.gypsumceilingkenya.co.ke/how-diaspora-kenyans-lose-money-when-building-back-at-home/)
- [Sending Money Home to Build: Why Diaspora Construction Projects Fail (Nigeria)](https://naijaproperty.com/blog/local-insights/sending-money-home-to-build-why-diaspora-construction-projects-fail-and-how-to-protect-yours)
- [Avoiding Construction Fraud in Nepal: A Diaspora Homeowner's Checklist](https://tools.housedesigninnepal.com/blog/avoiding-construction-fraud-nepal-diaspora)
- [How Diaspora Buyers Get Burned (Jamaica)](https://www.jamaica-homes.com/p/how-diaspora-buyers-get-burned)
- [Avoiding Property Scams in Nigeria (Zira)](https://sendzira.com/2025/08/29/avoiding-property-scams-in-nigeria/)
- [The Remittance Trap (Property Hotshot Nigeria)](https://propertyhotshot.ng/the-remittance-trap-data-on-how-much-diaspora-money-is-lost-to-family-managed-property-projects/)

### 5.2 Competitors / similar services (proof people pay)
Mostly **human-service models** (vetted contractors, inspectors, managed builds), not verification technology on top of the funder's own builder:
- [DiasporaBuild](https://diasporabuild.com/): remote project supervision in Africa, verified professionals, milestone workflows
- [HoDiaspora](https://www.hodiaspora.com/): vetted professionals, transparent budgets, on-the-ground oversight
- [GURI Build](https://thebrief.co.ke/kenya-diaspora/guri-build-helping-kenyan-diaspora-build-homes-hustle-free/) (Kenya)
- [Ugandan startup helping the diaspora build](https://globalpressjournal.com/africa/uganda/startup-helps-ugandan-diaspora-build-back-home-without-losing-money/)
- [Buildove](https://buildove.com/2025/10/31/construction-management-apps-are-shaping-the-future-of-nigeria-building-sector/): construction management app (Nigeria)
- [Ghana Buildings diaspora services](https://www.ghanabuildings.com/diaspora-services/)

**Our positioning:** technology instead of hired supervisors. It works with the builder the funder already has, links money to verified proof, and offers on-demand spot checks. It could even partner with the service companies above.

### 5.3 Market size: honest numbers
- Kenya 2025 Remittances Household Survey: **only 2.6% of recipient households invested in construction** (2.2% in real estate); most remittances go to food, school fees and health. ([Business Today Kenya](https://businesstoday.co.ke/diaspora-cash-fuels-household-survival/))
- The share of remittances spent on housing varies by country, from about **0.7% (El Salvador) to 16% (Indonesia)**, and **5–20% in Mexico**. ([ScienceDirect overview](https://www.sciencedirect.com/topics/social-sciences/migrants-remittance))
- A Nigeria-focused paper claims a very high share goes to construction/home purchase. Treat it as unverified until read in full. ([ResearchGate](https://www.researchgate.net/publication/382516233_Contributions_of_Diaspora_Remittances_to_Economic_Growth_Development_in_Nigeria_A_Housing_Finance_Infrastructure_Perspective_2000-2023))
- **Conclusion:** the diaspora segment is real but niche in each country, so the wider "remote funder" positioning is necessary.

---

## 6. Decisions

### 6.1 Made
| Date | Decision |
|------|----------|
| 2026-10-03 | Build **remote construction oversight** (verified progress + stage-based funding + shared ledger) for the Serverpod 4 hackathon |
| 2026-10-03 | Target audience is **anyone funding a build they can't watch**, not only the diaspora |
| 2026-10-03 | Project folder created as `C:\New_folder\remote_build_oversight` (temporary name), docs in `doc/` |
| 2026-10-04 | Folder renamed to **`C:\New_folder\plotwatch`**; MCP server registrations moved to the new path |
| 2026-10-03 | Follow a full documentation-first process: overview → requirements → MVP scope → implementation plan → TDD implementation |
| 2026-10-03 | Name "BuildProof" rejected; product name still open (not a priority yet) |
| 2026-10-04 | **D-2 Product name: Plotwatch.** Dart packages `plotwatch_server` / `plotwatch_client` / `plotwatch_flutter`. Other candidates and why they were dropped: Témoin (sounds too French), Batisure (user disliked it), BuildProof (liked, but taken in the same category: an App Store construction punch-list app with photo proof, buildproof.com, buildproof.dev), Groundtruth (crowded: AWS, ad company), Footing / Plumbline / Buildsight (not chosen). Known overlap for Plotwatch: plotwatch.ai (real-estate price tracking for buyers, adjacent field) and the discontinued "PlotWatcher Pro" hunting camera. **Before public launch:** trademark check + domain choice (e.g. plotwatch.app / getplotwatch.com). Package names are invisible to users, so a later rebrand only changes display name, logo and store listing. |
| 2026-10-03 | **D-4 Platforms approved:** one Flutter codebase → mobile app (Android, iOS) for site managers and funders; web app for funders/co-funders/viewers, with no capture on web. Hackathon: Android + web tested; iOS only if a Mac is available. |
| 2026-10-03 | **D-5 Payments approved:** record-keeping only, no real money movement until Phase 3 (licensed partner needed). The funder logs releases made outside the app; the site manager confirms receipt. |
| 2026-10-03 | **D-6 Verification approved:** in-app camera only, GPS inside the boundary + accuracy, mock-location detection, server timestamp via commit, hash match on upload; three-level badge with explained checks. Duplicate detection P1; device attestation/C2PA P2. |
| 2026-10-03 | **D-7 Auth approved:** email + password (verification, reset); Google sign-in as Should; invitation by code/link. Phone/OTP in P1; may move earlier depending on what the contact says about site managers' email use. |
| 2026-10-03 | **D-3 Roles approved:** owner, co-funder (optional approval rights), viewer, site manager; inspector in P2. |
| 2026-10-03 | **D-8 Languages approved:** English + French from day one, with locale formatting. |
| 2026-10-03 | **D-9 Currency approved:** one currency per project, chosen at creation; second-currency display in P2. |
| 2026-10-03 | **D-10 Client architecture settled by `_standards/`:** Clean Architecture + flutter_bloc (BLoC pattern). `_standards/` copied into the project root and binding for all Flutter code. Requirements and MVP docs corrected (they previously said MVVM/ViewModels). |
| 2026-10-03 | **D-12(a) Models approved:** Serverpod-generated model classes are used directly as the app's domain models (shared server/client). Freezed stays for BLoC events/state and client-only models (e.g. offline upload queue items). Localized enum labels are extensions on generated enums. RULE-018–023 apply only to client-only models. |
| 2026-10-03 | **D-12(b) Errors approved:** the server throws one serializable `AppException` carrying an error **code** (enum), never display text. Client API providers catch Serverpod exceptions → `ApiErrorHandler.handle(e)` → the standard names `HttpException400` (business error + code), `HttpException401`, `NetworkException`. `AppApiResponse` is dropped: repositories return typed models and failures are thrown; the null-failure step is only used where an endpoint can legitimately return nothing. BLoCs set error messages via `e.code.message(LocalizationService.localization)`. |
| 2026-10-03 | **D-12(c) Pagination approved:** the server returns one generated page model per list (e.g. `EvidencePage { items, page, pageSize }`); repositories convert it into a client-only `PaginatedList<T>`, so BLoCs/UI follow `_standards/13_mobile_pagination.md` as written. For the live activity feed and notifications only, `pageKey` = ID of the last loaded item (keyset pagination, avoiding duplicates as new items arrive); live items are inserted at the top through a separate BLoC event. Filters/search always server-side. |
| 2026-10-03 | **D-12(d) Server conventions approved:** `models/`, `endpoints/`, `services/`, `future_calls/`, `web/`; thin endpoints (sign-in → permission → validate → one service call); domain services don't call each other (only Permission/Activity/Notification/Audit are shared); `AppException` codes only; multi-table writes in transactions; money in minor units; UTC server timestamps; generated migrations only; no secrets in logs; integration tests per endpoint + unit tests for pure logic. **D-12 complete** → [`_standards/14_serverpod_adaptation.md`](../_standards/14_serverpod_adaptation.md). |
| 2026-10-04 | **Repository:** git initialized (branch `main`), remote [github.com/afesohromeo/plotwatch](https://github.com/afesohromeo/plotwatch), **private while building, public before submission** (secret scan first). No open-source licence: README says "All rights reserved", with the hackathon licence (§3, IP) as the stated exception. `.claude/skills/` and `.claude/knowledge/` stay local (gitignored, third-party content; sources listed in `CLAUDE.md`); `CLAUDE.md`, `.claude/settings.json`, `doc/` and `_standards/` (the user's own work) are committed. LF line endings via `.gitattributes`. |
| 2026-10-04 | **Serverpod 4 verification approved:** `_standards/14` corrected against Serverpod 4.0.3. Layer folders kept even though the template groups by feature. Exact client exception classes (`ServerpodClientUnauthorized`, `ServerpodClientForbidden`, `ServerpodClientNetworkException`, `MethodStreamException`). Auth module errors mapped to `AppErrorCode` values. `serverpod_auth_idp` instead of legacy `serverpod_auth`. Exact upload, transaction, future-call and test-helper APIs. **Migrations: strict rule kept** (never edited by hand); Serverpod allows editing `migration.sql` only to avoid data loss, which we can revisit once there is production data. Docker not used (embedded Postgres). |
| 2026-10-04 | **`03-mvp-scope.md` aligned with the Official Rules:** deadline 14 Oct 23:59 CEST; demo video under 2:00 (outline compressed); checklist gains build/run instructions, testing access until 20 Oct, AI-tool disclosure, English materials and the Most Valuable Feedback form. Feedback log started in `doc/serverpod-feedback.md`. |
| 2026-10-04 | **Process for implementation:** (1) two levels of plans: master `04-implementation-plan.md` plus one detailed plan per milestone, each approved before coding; (2) **the developer runs every command except tests**; Claude runs only `dart test` / `flutter test` and writes every other command as a "You run:" step (this answers §2 item 4 on `build_runner` / l10n); (3) the real project is created with `--ide claude`: Serverpod's MCP server is registered, its skills stay local, the template `.gitignore` is narrowed to keep `.claude/settings.json`, and `AGENTS.md` is merged into `CLAUDE.md`. |
| 2026-10-04 | **Repository layout and Flutter app base (developer's decision):** Serverpod's standard layout: `plotwatch_server/`, `plotwatch_client/`, `plotwatch_flutter/` at the repo root, next to `doc/`, `_standards/`, `.claude/` and `CLAUDE.md`. The GitHub repo is **not** created from the developer's kit template (the existing `afesohromeo/plotwatch` repo is used). After `serverpod create plotwatch`, the generated Flutter app in `plotwatch_flutter/` is **replaced with the developer's [flutter_bloc_kit](https://github.com/afesohromeo/flutter_bloc_kit)** (local copy `C:\New_folder\Flutter_Bloc_Kit\flutter_bloc_kit`): copy `lib/`, `Makefile`, `l10n.yaml`, `analysis_options.yaml` and the dependencies; rename the package to `plotwatch_flutter`; remove `dio`; add `plotwatch_client` + `serverpod_flutter`; adapt `data/api/config/` per `_standards/14`. Integration plan approved the same day and saved as task group A of [`04a-m1-foundation.md`](04a-m1-foundation.md): unused kit dependencies dropped, Freezed/build_runner bumped to PlusLocate's versions, `flutter_secure_storage` ^10, `fakeToken` / `SecureStorageHelper` / `AuthCheckHelper` removed, Makefile copied unchanged, l10n generated automatically as in PlusLocate. |
| 2026-10-04 | **Git branches (developer's decision):** work happens on a **`dev`** working branch created from `main`; more branches only if needed later. (Claude had proposed one branch per task group with pull requests; not approved.) |
| 2026-10-04 | **Design system (developer's answers):** no existing brand, colours or reference apps; the developer decides after seeing Claude's proposals. **Light theme only for the MVP** (high contrast for outdoor use; dark mode later). A design-system step (`doc/05-design-system.md` + `.stitch/DESIGN.md`, Stitch mock-ups of 3–4 key screens, tokens applied through `app_theme_kit` / `MyAppColors`) runs **after M1 groups C/D**, before M2 screens. Starting proposal: calm and factual personality, deep teal primary, terracotta/ochre accent, verification status in green/amber/red always with icon + text, one bundled sans-serif font. |
| 2026-10-06 | **Design direction A "Calm Ledger" approved** (Claude's recommendation, chosen from three on the [design canvas](https://claude.ai/artifact/HkBGZE6BjTtff6HAKQXvoH)) → [`doc/05-design-system.md`](05-design-system.md): deep teal `#0E5A52`, terracotta accent `#A44A24`, Manrope bundled (OFL), white app bar with ink text, 12 px corners, status colours always with icon + text. Implemented as `PlotwatchTheme` (replaces `app_theme_kit`'s `AppTheme.light`, which coloured body text with the secondary colour and downloaded Quicksand at runtime); the kit's input decoration, button and dialogs now follow the theme. Pulled forward from "after group D" because the developer found the kit's default look unacceptable. Same day, also from the developer's review: **confirm-password fields** on sign-up and password reset, and **errors through `DialogUtils.handleFailure`** (the kit's dialog, RULE-031) instead of SnackBars. |
| 2026-10-04 | **Imports through barrels (developer's convention, PlusLocate pattern):** app code imports only `package:plotwatch_flutter/plotwatch_flutter.dart` (root barrel over core, shared, domain, features, data, `app_theme_kit`; one barrel per layer and per feature; `domain/models` re-exports the generated `plotwatch_client` models). Tests import the app barrel plus one `test/helpers/helpers.dart` barrel (relative, because `test/` can't be reached with `package:`). |
| 2026-10-04 | **`04-implementation-plan.md` approved.** Android application ID **`com.afesohromeo.plotwatch`**; client test mocks with **`mocktail`**; **Claude commits and pushes after a meaningful amount of finished, tested work** (not after every approval). |
| 2026-10-03 | **D-11 Maps approved:** Google Maps (`google_maps_flutter`), as in PlusLocate. Requires an API key with billing (Android/iOS and web). OpenStreetMap is the fallback if costs grow. |
| 2026-10-06 | **M2 plan approved** ([`04b`](04b-m2-projects-site-members.md), decisions M2-1 to M2-14), then **revised by the developer's scenario (approved "as recommended")**: the owner creates the project (`draft`); the **site manager localizes the plot with the phone's GPS on site** (accuracy 20 m or better, mocked positions refused); the **owner validates** on a satellite map and sets the radius (default 50 m) or rejects with a reason; the first validation makes the project `active`, and captures need an active project. SITE-04 becomes must-have; SITE-01 (owner's map pin), SITE-02 (Plus Code entry) and the site time zone (SITE-06) move to P1. Reason: a remote funder can't reliably find the plot on a map; the person on the plot can. Safeguard: the owner's validation (decision M2-19). |

### 6.2 Pending (need the user's approval)
See [03-mvp-scope.md §7](03-mvp-scope.md#7-decisions-to-confirm-before-implementation): as of 2026-10-04 **all decisions D-1 to D-12 are made** (see the table above).

---

## 7. User validation

- The user knows **one person** funding a build remotely (the funder side). They don't have this person's direct contact and will reach them **through an intermediary**.
- Don't block on this interview: write the docs in parallel and mark assumptions (requirements §2.5) for validation.
- **Message prepared for the intermediary to forward:**

> Hi! A friend of mine is building an app to help people fund construction they can't supervise in person, and he'd value 15 minutes of your experience. A few questions, answer whichever you like, voice notes are perfect:
> 1. How do you get updates on your build today (photos, calls, someone visiting)?
> 2. How do you send money: all at once, stage by stage, or when asked?
> 3. Has anything gone wrong, or nearly gone wrong? What happened?
> 4. Who is on site day to day, and do they have a smartphone with data?
> 5. If an app showed you verified progress and let you release money only stage by stage, would you use it? What would it be worth to you?

- **Longer interview guide** (if a call happens):
  1. Tell me the story of your build so far. What went wrong, or what are you afraid will go wrong?
  2. How do you get updates today: WhatsApp photos, calls, a relative visiting?
  3. How do you send money: all at once, by stage, or whenever someone asks?
  4. Have you ever doubted that a photo or an update was real? What happened?
  5. What would you pay to never worry about this? Per month, or per project?
  6. Who is on site: a contractor, a relative, a foreman? Do they have a smartphone and data?
- **Where to find more users after the hackathon:** diaspora Facebook groups, WhatsApp communities, TikTok/YouTube comments under construction-scam stories, NGOs funding remote builds.
- Record interview answers in this file (new section) when they arrive, and update requirement priorities (open question Q8).

---

## 8. Current status & next steps

**Status (2026-10-04):** Documentation drafted (01, 02, 03, this file, `_standards/14_serverpod_adaptation.md`); all decisions D-1 to D-12 made; tooling (`.claude/`, MCP servers) set up. Git repository initialized and pushed to GitHub (private). Official Rules read and `03` aligned with them. Serverpod CLI 4.0.3 installed and quickstart verified; `_standards/14` corrected against Serverpod 4.0.3. `doc/04-implementation-plan.md` approved. **M1 task group A done** (2026-10-04): the Serverpod 4 workspace is at the repo root, the Flutter app is built on flutter_bloc_kit with the `_standards/14` API config (`ApiProvider`, `ApiErrorHandler`, 21 tests passing), and the kit's Home page runs on web and Android against the local server. M1 groups B (server profile), C (auth screens) and D (profile, language) done, design system A "Calm Ledger" in place (`05-design-system.md`); 144 app tests and 10 server tests passing. Group D (profile screen and language) done; 160 app tests. Group E (2026-10-06): deployed to Serverpod Cloud; the name-lost-at-sign-up bug found there was fixed (single sign-up request) and browser/phone autofill added; 174 app tests and 14 server tests passing. Next: redeploy and finish the group E checks (see `04a`). M2 ([`04b`](04b-m2-projects-site-members.md)) started 2026-10-06: server groups A–D done (models, permission matrix, projects, membership, site localization and validation), 200 server and 214 app tests passing. Next: deploy, then app groups E–G. Project folder: `C:\New_folder\plotwatch`.

**Next steps:**
1. The user reviews `01`, `02`, `03` and requests changes. Iterate until approved.
2. Confirm the pending decisions (`03-mvp-scope.md §7`).
3. ~~Confirm the exact deadline in the hackathon rules.~~ Done 2026-10-04: 14 Oct 2026, 23:59 CEST (see §3).
4. ~~Decide whether to copy the `.claude/` skills setup from PlusLocate~~ Done 2026-10-03 (see §2 item 5).
5. ~~Initialize a git repository (and a GitHub repo for submission).~~ Done 2026-10-04 (see §6.1, "Repository").
6. ~~Install tooling: Serverpod CLI, Docker (for local Postgres); do the Serverpod 4 quickstart.~~ Done 2026-10-04: Serverpod CLI 4.0.3 installed, quickstart verified (see §2 item 7). Docker not installed: not needed with embedded Postgres. `_standards/14` corrections approved and applied.
7. ~~Write `doc/04-implementation-plan.md` (task-by-task, TDD), get approval, then start D2 of the schedule.~~ Done 2026-10-04; M1 group A completed the same day (see `04a-m1-foundation.md`).
9. Plan M1 groups B–E in `04a-m1-foundation.md`, get approval, implement on D2.
8. Send the forwardable message to the intermediary.
