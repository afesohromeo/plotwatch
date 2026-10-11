# M3: Stages, templates, checklists, budgets (detailed plan)

> **Status:** **approved 2026-10-08** by the developer (all decisions, including M3-2 templates in the app, M3-12 schedule and M3-13 design pass after M4).
> **Master plan:** [04 §4 M3](04-implementation-plan.md#m3-stages-templates-checklists-budgets-d4). **Requirements:** STG-01–09, BUD-01, BUD-02 ([02 §4](02-requirements-specification.md)); stage state machine [02 §10.1](02-requirements-specification.md#101-stage); built-in templates [02 §12.1](02-requirements-specification.md#121-built-in-stage-templates-initial-proposal). **Permissions:** [02 §3.2](02-requirements-specification.md#32-permission-matrix). **Acceptance:** AC-1 completely ([03 §6](03-mvp-scope.md)).

**Goal:** the owner gives the project a stage plan, from a template or by hand: stages with a budget, planned dates and a checklist of required evidence. Everybody sees the plan, the total budget and the progress. The site manager starts a stage. Submitting, reviewing and approving stages come in M5; captures attached to checklist items in M4.

**Schedule note:** today is D5 (Thu 10-08), the day planned for M4. M2 took D3 to D5, so we're about two days behind. See decision M3-12 for how to catch up.

---

## Decisions
| # | Decision | Proposal |
|---|----------|----------|
| M3-1 | **Groups and order** | **A** server: models, `StageService`, `StageEndpoint`, project creation with stages, budget total and progress. **B** app: data layer, templates, money formatting and input. **C** app: the wizard's Stages step and the Stages page (list, totals, reorder, start from a template). **D** app: stage page (details, checklist, Start) and the stage form (details and checklist editor). |
| M3-2 | **Templates live in the app, not on the server** | `02` §7.2 planned seeded `StageTemplate` tables and a `TemplateEndpoint`. But template content is display text (stage names, checklist labels), and the server never sends display text (`_standards/14` §2; error codes work the same way). So the built-in templates of `02` §12.1 are **constants in the app, with their texts in the ARB files** (EN + FR). Choosing a template fills the plan in the owner's language; the stages are then ordinary, editable text. **No template tables, no seed migration, no `TemplateEndpoint`.** Templates: *Single-storey house* (10 stages), *Renovation* (6), *Custom* (empty). |
| M3-3 | **Creation in one request** | The wizard gets a **Stages** step: Details → **Stages** (pick a template, see its stages) → Review. `project.create(details, {stages})` creates the project, its stages and their checklist items **in one transaction** (M2-3, AC-1). A project without stages (Custom, or created in M2) gets **Start from a template** on its empty Stages page: `stage.createPlan(projectId, stages)`, refused when the project already has stages (`stagePlanNotEmpty`). |
| M3-4 | **Stage fields** | `Stage`: `projectId`, `orderIndex`, `name` (1–100), `description?` (≤ 1,000), `budgetMinor` (int, 0 to 10¹⁵, default 0), `plannedStart?`, `plannedEnd?` (end ≥ start), `status`, `startedAt?`, `submittedAt?`, `approvedAt?`, `approvedBy?` (the last three are used from M5; the columns come now so M5 needs no migration on this table). Limits: 50 stages per project (`tooManyStages`). |
| M3-5 | **Checklist items** | `ChecklistItem`: `stageId`, `orderIndex`, `label` (1–200), `required` (default true). 30 items per stage. They are edited with their stage: `stage.update(stageId, draft)` sends the full item list; **existing items keep their ID** (M4 attaches captures to them), items sent without an ID are created, items left out are deleted. `evidenceType` (photo, video, document) is P1 (STG-14): no column yet. |
| M3-6 | **Who edits what, when** | Creating, editing, reordering and deleting stages: **owner only** (`manageStages`). Editing and reordering are allowed while a stage is `not_started` or `in_progress` (STG-02: "not submitted yet"); a later status gives `stageLocked`. **Deleting only a `not_started` stage** (M4 captures may hang off an in-progress one). Changing the budget of an in-progress stage is allowed and audited; the reason and change order are BUD-04 (P1). Planning is allowed in every project status except `completed` and `archived` (`projectNotEditable`). |
| M3-7 | **Order** | `orderIndex` is always 0…n−1 without gaps. `stage.reorder(projectId, stageIds)` takes **all** the project's stage IDs in the new order (anything else gives `invalidStageOrder`) and rewrites the indexes in one transaction. Creating appends at the end; deleting closes the gap. The app reorders by dragging (owner only). |
| M3-8 | **Starting a stage** | STG-06: `not_started → in_progress`, by the **site manager** (new `ProjectAction.startStage`, a new row in `02` §3.2), and only on an `active` project (`projectNotActive`: no work before the site is validated). In M4 the first capture also starts the stage. Other transitions give `invalidStageTransition`. |
| M3-9 | **Money** | `budgetMinor` is an integer in the currency's minor units, with the project's ISO 4217 code (BUD-02). The app converts with the currency's decimal digits from `intl` (XAF 0, EUR and USD 2): the owner types `1 500 000` (XAF) or `1 250,50` (EUR), and the app stores `1500000` or `125050`. Display: `intl` currency format in the app language (`1 500 000 FCFA`, `€1,250.50`). **Amended 2026-10-11 (developer):** FCFA (the symbol of XAF, the ISO code of the Central African CFA franc) is written `1,500,000 FCFA` in every language, commas between groups of three digits, the symbol after; short figures `12.5 M FCFA`; the budget field shows `1,500,000` and also reads `1.500.000`. A shared `MoneyField` input and a `formatMoney` helper. The project budget is the sum of its stages (BUD-01), computed by the server. |
| M3-10 | **Progress** | Stage progress (STG-08) = checklist items with at least one capture / items: 0 until M4. Project progress (STG-09) = budget-weighted share of `approved` stages (stages weigh the same when every budget is 0): 0 until M5. Computed by the server, so `ProjectSummary.progressPercent` (the project list) becomes real now. |
| M3-11 | **Screens and routes** | Nested under the project page (H-1): `stages` (the plan: total budget, progress, the stages with status chip, budget and checklist progress; owner: Add stage, reorder, Start from a template when empty), `stages/new`, `stages/:stageId` (details, checklist, status; owner: Edit, Delete; site manager: Start), `stages/:stageId/edit`. The project page gets a **Stages** card (count, total budget, progress) that opens the plan. **The plan isn't paginated**: at most 50 stages, and reordering and the total need the whole list (`_standards/13` covers paginated feeds). Audit and activity: `stage.create/update/delete/reorder/start/createPlan`; new activity types `stagePlanChanged` (create, update, delete, reorder, plan) and `stageStarted`. |
| M3-12 | **Catching up (needs your decision)** | Two days behind, six milestones left (M3–M8) before submission on D10 (Tue 10-13). Proposal: M3 today and tomorrow morning (D5–D6), M4 verified capture D6–D7, M5 review and real time D7–D8, M6 ledger D8–D9, **M7 should-haves dropped as a milestone** (evidence requests become a stretch, cut order of `03` §3.4), M8 hardening D9 with feature freeze, M9 submission D10, D11 buffer. |
| M3-13 | **Design pass (needs your decision)** | You found the design flat (2026-10-07). M3 adds four screens. Options: **(a)** a design pass now, before the M3 screens, so they are built in the new style once; **(b)** after M4, on the screens of the demo (project list, project page, stage plan, capture, evidence), when they all exist. Recommendation: **(b)**, half a day on D7. The theme tokens are shared, so M3 screens pick up most of it, and the demo screens matter most for the video. |

**New error codes:** `stageNotFound`, `stageLocked`, `invalidStageName`, `invalidStageDescription`, `invalidBudget`, `invalidStageDates`, `invalidChecklistItem`, `tooManyStages`, `tooManyChecklistItems`, `invalidStageOrder`, `stagePlanNotEmpty`, `invalidStageTransition`, `projectNotActive`, `projectNotEditable` (EN + FR messages in the app).

---

## Group A: server (Claude, TDD)
**Models** (`plotwatch_server/lib/src/models/`): `stage.spy.yaml` (table, relation to `project`, cascade; index `projectId, orderIndex`), `stage_status.spy.yaml` (`notStarted`, `inProgress`, `submitted`, `changesRequested`, `approved`), `checklist_item.spy.yaml` (table, relation to `stage`, cascade), `stage_draft.spy.yaml` and `checklist_item_draft.spy.yaml` (`immutable`, what the app sends), `stage_view.spy.yaml` (stage, its items, items covered: 0 until M4), `stage_plan.spy.yaml` (stages, `budgetTotalMinor`, `progressPercent`). `ProjectOverview` gets `stageCount`, `budgetTotalMinor`, `progressPercent`. New `ActivityType` and `AppErrorCode` values. One migration (two new tables).

**Services and endpoints**
| Call | Who | Rules |
|------|-----|-------|
| `project.create(details, {stages})` | signed in | M3-3: one transaction; stages validated first |
| `stage.plan(projectId)` | member | stages in order with items, total, progress |
| `stage.get(projectId, stageId)` | member | `stageNotFound` for another project's stage |
| `stage.createPlan(projectId, stages)` | owner | only when empty (`stagePlanNotEmpty`) |
| `stage.create(projectId, draft)` | owner | appended; 50 max |
| `stage.update(projectId, stageId, draft)` | owner | M3-5 item diff; M3-6 lock |
| `stage.delete(projectId, stageId)` | owner | `not_started` only; indexes closed |
| `stage.reorder(projectId, stageIds)` | owner | M3-7 |
| `stage.start(projectId, stageId)` | site manager | M3-8 |

`PermissionService`: `ProjectAction.startStage` (site manager). `ProjectService`: overview and summary carry the totals; progress from `StageService.progressPercent` (a pure function, unit tested).

**Tests first**
- `stage_endpoint_test`: each call for the owner; co-funder, viewer and site manager refused for editing (`permissionDenied`), outsider `projectNotFound`; another project's stage `stageNotFound`; every validation limit (name 0 / 101, description 1,001, budget −1 / 10¹⁵+1, end before start, label 0 / 201, 51st stage, 31st item); items keep their IDs on update, new ones are created, missing ones deleted; reorder gives 0…n−1 and refuses a missing, extra or foreign ID; delete closes the gap and refuses an in-progress stage; editing a submitted stage gives `stageLocked` (status set directly in the test); start by the site manager on an active project, refused on a draft project and twice; `createPlan` refused when stages exist; every change writes one audit entry and one activity event; a failing stage in `project.create` creates nothing (no project, no member).
- `permission_matrix_test`: the `startStage` row.
- Unit `progress_test`: budget-weighted share, all budgets 0, no stages.
- `project_endpoint_test`: the overview and the list carry the totals.

## Group B: app data layer, templates, money (Claude, TDD)
**Files:** `data/api/stage/stage_api_provider.dart`, `domain/repository/stage_repository.dart`, `ProjectRepository.createProject` with stages, `shared/utils/stage_templates.dart` (template IDs → ordered stage and item keys, texts from the ARB), `shared/utils/money.dart` (`minorUnitsFor`, `formatMoney`, `parseMoney` per currency and locale), `shared/components/money_field.dart`, `StageStatus` labels.
**Tests first:** repository calls and rethrow; every template builds in EN and FR with the stage count of `02` §12.1 and no empty label; `parseMoney` / `formatMoney` for XAF, EUR and USD in EN and FR (grouping, decimals, invalid input); `MoneyField` validation.

## Group C: wizard Stages step, Stages page (Claude, TDD)
**Files:** `CreateProjectBloc` (+ template choice, stages sent with the project), `CreateProjectPage` (Stages step: three template cards, the chosen template's stages listed), `features/stages/` with `StagePlanBloc` and `StagePlanPage` (summary, list, drag to reorder for the owner, Add stage, Start from a template when empty), the project page's Stages card, routes `stages`, `stages/new`.
**Tests first:** wizard sends the template's stages, Custom sends none; plan loads, owner sees Add and reorder, others don't; a drag sends the new order and a refused order restores the list; empty plan offers templates to the owner only; the project page card shows count, total and progress and opens the plan.

## Group D: stage page and form (Claude, TDD)
**Files:** `StageBloc` and `StagePage` (details, budget, dates, checklist with progress, status; owner Edit and Delete with confirmation, site manager Start), `StageFormBloc` and `StageFormPage` (create and edit: name, description, `MoneyField`, date range, checklist editor: add, remove, reorder, required switch), routes `stages/:stageId`, `stages/:stageId/edit`.
**Tests first:** each bloc's success and failure paths; the form validates like the server (name, description, budget, dates, labels); a locked stage shows no Edit for the owner; Start only for the site manager on a `not_started` stage; delete only on `not_started`; ARB keys in EN and FR.

## You'll need
Nothing new: no new packages (`intl` is already in the app), no keys.

## You run
- After group A: `serverpod generate`, `serverpod create-migration`, `dart format .`, `dart analyze` (server); restart `serverpod start` so the migration is applied. Claude runs `dart test`.
- After groups B–D: `flutter gen-l10n`, `dart run build_runner build --delete-conflicting-outputs`, `dart format .`, `dart analyze` (app). Claude runs `flutter test`; you check on the emulator and in Chrome.

## Exit (M3)
On the deployed build: AC-1 completely. The owner creates a project from the *Single-storey house* template and sees its 10 stages and their checklists; edits a stage's budget, dates and checklist, reorders and deletes a stage; the total budget follows. The site manager sees the plan and starts a stage once the site is validated. Co-funders and viewers see everything and change nothing. English and French complete; all tests pass; CI green.

---

## Outcome (2026-10-08)
Groups A to D done as planned. `dart test` **275/275** (51 new), `flutter test` **581/581** (new: money, templates, `MoneyField`, stage status labels, stage repository, wizard Stages step, `StagePlanBloc` and page, `StageBloc` and page, `StageFormBloc` and page, validators, routes, the project page's Stages card). Seen red first: every new test failed to compile until the code existed.

Notes:
- `intl` writes `FCFA1,500,000` in English (no space between letters and digits); `formatMoney` adds a no-break space. French groups digits with a narrow no-break space (U+202F); `parseMoney` ignores every kind of space and accepts a dot as well as a comma for the decimals in French.
- `ReorderableListView.onReorder` is deprecated in Flutter 3.47; the plan uses `onReorderItem`, which gives the final position.
- Serverpod models have no value equality (also found in group H), so bloc tests build each state once and compare against it.
- Found by the tests and fixed in the tests: `MoneyField` needs a `Material` ancestor in a widget test; the wizard lists stages with their number.

To check on the emulator and in Chrome, then on Cloud for the M3 exit: see "Exit (M3)" above.

## Fixes found in testing (approved 2026-10-08)
| # | Found | Cause | Fix |
|---|-------|-------|-----|
| M3-F1 | After deleting a stage, the app stayed on the deleted stage's page. | `ReloadOnReturn` (group H, H-1a) reloads when its page becomes the top route again, and a dialog counts as a route. Closing the confirm dialog therefore started a reload **at the same time** as the delete. The reload reset the page state, so the delete finished with its marker ("deleting") lost and the page took it for another action. The "one extra request, accepted" of H-1a was in fact a race. | **(a) Root cause:** `ReloadOnReturn` follows the **router's address** instead of the route stack: it reloads when the address comes back to its page's address (Back, or going to the parent). Dialogs, menus and sheets don't change the address, so they no longer trigger a reload, and H-1a's side effect disappears. **(b) Hardening:** `StageBloc`, `StagePlanBloc` and `MembersBloc` keep the action's flow step when they report its result, so a reload can never relabel an action. Tests first: a dialog closing doesn't reload; Back and going to the parent still do; the delete flow ends on the stage plan; a concurrent reload doesn't change the reported flow step. |
| M3-F2 | No Edit or Delete on the stage page on the emulator. | Not reproduced in the code: the app bar shows its actions on mobile as on the web, and the icons appear for the **owner** only (M3-6). The emulator account was the site manager in the M2 tests. | Confirmed by the developer: the emulator account was the site manager. Working as designed, no change. |


### M3-F3: dragging a stage doesn't scroll the page (approved 2026-10-08)
| Found | Cause | Fix |
|-------|-------|-----|
| Dragging stage 10 up towards stage 1 stops at the top of the screen: the page doesn't scroll, so the stage has to be dropped, the page scrolled, and the stage dragged again. | The stage list is a `ReorderableListView` with `shrinkWrap` and `NeverScrollableScrollPhysics` inside the page's `SingleChildScrollView` (`AuthFormLayout`). A drag only auto-scrolls the list's own scroll view, and this list has none. | The stage plan page becomes **one `CustomScrollView`**: the title, total budget and progress as a `SliverToBoxAdapter`, the stages as a `SliverReorderableList`, which auto-scrolls the page it is in while a stage is dragged near the top or bottom edge. Same look as `AuthFormLayout` (padding, 420 px wide at most, pull to refresh). Test first: a widget test drags the last of 20 stages to the top on a small screen and checks that the page scrolled and the move was sent as "from 19 to 0". |

### Fixes outcome (2026-10-08)
M3-F1 done. Seen red first: the new `ReloadOnReturn` test (a dialog closing reloaded the page) and the new `StageBloc` test (a reload during a delete reset the flow step to `none`) both failed before the fix. `ReloadOnReturn` now follows the router's address (`routerDelegate.currentConfiguration`) instead of the route stack; `StageBloc`, `StagePlanBloc` and `MembersBloc` set the action's flow step again when they report its result. A navigation test with a real router checks that a successful delete opens the stage plan. `flutter test` **585/585**. M3-F2: working as designed (the emulator account was the site manager).
M3-F3 done. Seen red first: the new widget test held stage 20 at the top edge and the page stayed at 1,904 px. The stage plan page is now one `CustomScrollView` with a `SliverReorderableList`, which scrolls the page during a drag; the dragged stage is shown raised. `flutter test` **586/586**. Checked by the developer on the emulator (2026-10-08).
