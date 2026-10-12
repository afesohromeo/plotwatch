# M6: The ledger and the Money tab (detailed plan)

> **Status:** **approved 2026-10-11** by the developer: one table (M6-1), receipts **(a)** (M6-5), M6-3 and M6-8 **included**. Money already in a shared account: the two agree on a withdrawal, the site manager takes the money out, the funder records the release with the method **Withdrawn by the site manager**; the app knows nothing of the account (it may serve other purposes than the project), so unaccounted stays honest.
> **Master plan:** [04 §4 M6](04-implementation-plan.md#m6-ledger-and-dashboards-d7). **Requirements:** LED-01, 03, 04, 06 (MVP), LED-02 and LED-05 (should-have), BUD-01–02, DASH-01 (in part), FEED-01, NOT-01 ([02 §4.14](02-requirements-specification.md)); flow [02 §9.5](02-requirements-specification.md#95-fund-release-and-expense); D-5: record-keeping only, no money moves through the app. **Acceptance:** AC-5 ([03 §6](03-mvp-scope.md)).

**Goal:** the money loop. A funder records a release made outside the app. The site manager confirms receiving it and records expenses, with a photo of the receipt. Everyone sees the same summary live: **budget, released, spent, spent with receipt, unaccounted** (released − spent with receipt) and **remaining** (budget − released), for the project and for each stage. Entries are never edited; a reversal corrects a mistake.

**Schedule:** D8 (11 Oct). M6 D8–D9, then M8 (hardening, freeze) D9–D10 and M9 (submission) before 14 Oct. Fund requests (FREQ) stay out.

---

## Decisions
| # | Decision | Proposal |
|---|----------|----------|
| M6-1 | **One table for both kinds** | `ledger_entry` with `kind` (`release`, `expense`) and the fields of each kind nullable, instead of the two tables of [02 §8](02-requirements-specification.md). One list, one keyset paging, one reversal rule, one summary query. The server checks each kind's required fields. |
| M6-2 | **A release (LED-01)** | Amount (> 0, ≤ the money limit), date (not in the future), method (`bankTransfer`, `mobileMoney`, `cash`, `withdrawnBySiteManager`, `other`), reference (optional, ≤ 100), optional stage, optional note (≤ 500). Recorded by an **approver** (the owner, or a co-funder allowed to approve; `recordFundReleases` is already in the matrix). **No proof file in M6:** the reference covers it (proof screenshots → P1). |
| M6-3 | **Confirming a release (LED-02, should-have)** | The site manager taps **Confirm received**; `confirmedBy` and `confirmedAt` are set once. Until then the release shows **Not confirmed yet**. About an hour. Recommendation: **include**. |
| M6-4 | **An expense (LED-03)** | Amount, date, category (`materials`, `labour`, `transport`, `permits`, `equipment`, `other`), description (1–300), vendor (optional, ≤ 100), optional stage, **optional receipt photo**. Recorded by the **site manager** (`recordExpenses`). |
| M6-5 | **The receipt photo — needs your choice** | **(a) Taken with the app's camera, not checked against the site (recommended).** Receipts are paid at the hardware store, not on the plot, so the location checks would mark every receipt Unverified. The app's camera only, no gallery; the photo is uploaded as for site photos (upload description, SHA-256 checked by the server) and kept with the expense. Shown as **Receipt** (no badge). Phone only, like site photos; an expense without a receipt can be recorded anywhere. **(b) A full verified capture**, with all eight checks: a model change (captures attached to an expense instead of a checklist item) and badges that would mostly say Unverified. **(c) No photo**, a "has receipt" switch: weakens "spent with receipt". |
| M6-6 | **Reversals (LED-06)** | `ledger.reverse(entryId, reason)` writes a new entry of the same kind with the **negative amount**, `reversesId` pointing at the original, and the reason (1–300, required). Only the person who recorded the original, only once, never a reversal of a reversal, on an open project. The original shows **Reversed** with the reason; both stay in the list. Nothing is ever updated or deleted. |
| M6-7 | **The summary (LED-04)** | Pure functions on the server (unit-tested): per stage and for the project, **budget** (the stages' budgets, BUD-01), **released**, **spent**, **spent with receipt**, **unaccounted** = released − spent with receipt, **remaining** = budget − released. Entries without a stage count for the project only, in a **Not tied to a stage** row. Reversals subtract by their sign. AC-5's numbers exactly. |
| M6-8 | **Unaccounted alert (LED-05, should-have)** | The unaccounted amount is highlighted (terracotta, with an icon and a sentence) when it is **above 20 % of what was released**. A fixed rule for now (settings → P1). Minutes of work. Recommendation: **include**. |
| M6-9 | **Live, feed and notifications** | New activity types `fundReleased`, `releaseConfirmed`, `expenseRecorded`, `entryReversed`, live in the feed (they also get an Activity chip, **Money**). The Money tab refreshes its summary and list when one of them arrives (the existing project stream, no new one). Notifications: a **release** → the site managers; a **release confirmed** → the person who recorded it; an **expense** → the owner and the co-funders allowed to approve; a **reversal** → the other side. |
| M6-10 | **The Money tab** | Fourth tab, as planned in DP-3: **Overview · Stages · Money · Activity**. Top: the summary card (released, spent, with receipt, unaccounted, remaining, against the budget). Then **By stage** (one row per stage with its numbers). Then the **entries**, newest first, infinite scroll, chips **All · Releases · Expenses** and the stage picker, filtered on the server (`_standards/13`). The button: **Record a release** for approvers, **Record an expense** for the site manager. An entry opens its page: all its fields, the receipt photo, **Confirm received** or **Reverse** when allowed. Closed projects read-only. |
| M6-11 | **The Overview (DASH-01, in part)** | A **Money** card on the Overview: released, spent with receipt, unaccounted (highlighted per M6-8), opening the Money tab. A separate "site manager home" (DASH-02) stays out: the Overview with its attention card already plays that part. |
| M6-12 | **Design first** | The Money tab (phone and web), the two forms and the entry page are drawn on the canvas and approved **before** they are built, like the update page (doc/05 §9.6). |
| M6-13 | **Out of M6** | Fund requests (FREQ-01–04), proof files for releases, budget lines (BUD-03), exports and real payments (D-5). |

## Groups
- **A, server: entries and summary.**
  - Models: `ledger_entry` (table), `ledger_entry_kind`, `release_method`, `expense_category`, `ledger_entry_view` (with the names), `ledger_page`, `ledger_summary` and `ledger_stage_line`, `release_draft`, `expense_draft`.
  - `LedgerService`: record release, record expense, confirm, reverse, list (kind and stage filters, keyset pages), summary.
  - `LedgerEndpoint`: `recordRelease`, `recordExpense`, `confirmRelease`, `reverse`, `list`, `summary`, `get`.
  - Permissions and closed projects; audit; activity and notifications (M6-9).
  - New error codes: `invalidLedgerEntry`, `ledgerEntryNotFound`, `alreadyReversed`, `alreadyConfirmed`, `notEntryAuthor`.
- **B, server: receipts (with M6-5 a).**
  - `ledger.receiptUploadDescription(projectId)` → a path under the project.
  - `recordExpense` checks the uploaded file and its SHA-256.
  - `ledger.receipt(projectId, entryId)` returns the photo to members.
- **C, canvas:** the Money tab (phone and web), Record a release, Record an expense, the entry page. Approval.
- **D, app:**
  - the Money tab with the summary, by stage, the entries with chips and the stage picker, live;
  - the Overview's Money card;
  - the Money tab in the shell (bottom bar, rail, sidebar).
- **E, app:**
  - the two forms: the date picker, the stage list, the money field, the receipt camera;
  - the entry page with Confirm received and Reverse;
  - the Money chip on Activity, and the notification sentences (EN and FR).

## Tests
- **Server:**
  - AC-5 exactly: released 500,000; spent 350,000; with receipt 300,000; unaccounted 200,000; remaining as budgeted.
  - The summary per stage and the "not tied to a stage" row.
  - Every permission refused for the wrong role; closed projects.
  - Reversal rules (own, once, not of a reversal) and confirm once.
  - The kind and stage filters with paging.
  - The receipt hash.
  - Activity and notifications.
- **App:**
  - Bloc tests: summary, list, filters, live refresh, forms.
  - Widget tests: the tab per role, the alert, the entry page actions, the forms' checks.
  - The shell's fourth tab.
  - Screenshots added to the harness.

## You run
- `serverpod generate` (or let `serverpod start` do it), then `serverpod create-migration` and apply it.
- `dart run build_runner build --delete-conflicting-outputs`
- `flutter gen-l10n`
- `dart format .`
- `dart analyze`

## Changes after the developer's check (2026-10-12)
- The labels on the teal summary card (Released, Spent, With a receipt) are light teal, as in the mockup; they had the accent-on-dark colour.
- **Phone:** under the summary, a switch **Entries · By stage** (the §9.4 pattern), so a long plan doesn't push the entries down. Entries is shown first, with its chips.
- **Phone and web:** tapping a stage's line shows that stage's entries.
- **Expenses on an approved stage (2026-10-12, developer):** allowed, made visible:
  - both forms list each stage with its status;
  - the expense form warns "Walls was approved on 8 Oct. This expense will still count for it.";
  - the server marks an expense recorded after its stage's approval (`afterApproval`, not stored), shown as an **After approval** tag in the Money list and a line on the entry page.
