# M5: Review loop, progress updates, live feed and notifications (detailed plan)

> **Status:** **approved 2026-10-09** by the developer, with **(b)** for M5-9 (updates without photos) and M5-10 **included** (schedule status).
> **Master plan:** [04 §4 M5](04-implementation-plan.md#m5-review-loop-and-real-time-d6), revised schedule D7–D8 (`04c` M3-12). **Requirements:** STG-07, REV-01–05, UPD-01–02, FEED-01–03, 05, NOT-01, NOT-02 (core subset), NFR-REL-02 ([02 §4](02-requirements-specification.md)); review flow [02 §9.2](02-requirements-specification.md#92-stage-submission-and-review); real-time design [02 §6.3.4](02-requirements-specification.md); live lists [`_standards/14` §3.3](../_standards/14_serverpod_adaptation.md). **Acceptance:** AC-4, AC-6 ([03 §6](03-mvp-scope.md)).
> Facts about Serverpod were checked in the `serverpod-streams` and `serverpod-server-events` skills: an endpoint method returning `Stream<T>` gets a WebSocket-managed client stub, and its session lives until the stream ends; `session.messages.postMessage` / `createStream` deliver on named channels, **within one server instance unless Redis is enabled** (it isn't).

**Goal:** the loop that makes Plotwatch useful. The site manager submits a stage once every required item has a photo; the owner (or a co-funder allowed to approve) approves it or requests changes with a comment; the site manager adds photos and submits again. Every member sees what happens **live** in the project's activity feed, and the people who must act get an in-app notification. The site manager also posts progress updates.

**Schedule note:** D6 evening. M5 runs D7–D8; the design proposals (M3-13) come alongside.

---

## Decisions
| # | Decision | Proposal |
|---|----------|----------|
| M5-1 | **Groups and order** | **A** server: submit, review, review history, `NotificationService`. **B** server: the live feed and notifications (`ActivityEndpoint`, `NotificationEndpoint`, streams with catch-up). **C** server: progress updates. **D** app: submit and review on the stage page, review history. **E** app: the project's activity feed and the notification centre, both live. **F** app: posting a progress update. **G** (proposal, see M5-10): schedule status. |
| M5-2 | **Submitting (STG-07)** | `stage.submit(projectId, stageId)`, **site manager** only (`submitStage`), on an active project, for a stage `in_progress` or `changes_requested`, when **every required item has at least one finalized, not retracted capture** (`checklistIncomplete` otherwise; optional items don't block). The stage becomes `submitted` with `submittedAt`; it is then locked for edits and captures (M3-6, M4-9). Audit, activity `stageSubmitted`, notification to every approver. |
| M5-3 | **Reviewing (REV-03–05)** | `stage.review(projectId, stageId, decision, {comment})` by an **approver**: the owner, or a co-funder with `canApprove` (`reviewStage`, already in the matrix). Only a `submitted` stage (`invalidStageTransition`). **Approve:** `approved`, `approvedAt`, `approvedBy`; optional comment. **Request changes:** a comment is **required** (1–1,000, `reviewCommentRequired`); the stage goes to `changes_requested`. Each decision is a permanent `StageReview` (REV-05), listed by `stage.reviews` with the reviewer's name. One approver's decision is enough (two-approver rules are REV-07, P2). Project progress follows automatically (STG-09). Audit, activity `stageApproved` / `stageChangesRequested`, notification to the site managers. |
| M5-4 | **Notifications (NOT-01, NOT-02 core)** | Table `notification`: user, project, type, payload (numbers and names only; the app writes the sentence, `_standards/14` §2), `readAt`, `createdAt`. Triggers now: **stage submitted** → approvers; **stage approved** and **changes requested** → site managers; **member joined** → the owner. Fund releases come with the ledger (M6). Nobody is notified of their own action. Calls: `notification.list` (newest first, keyset pages, `_standards/14` §3.3), `unreadCount`, `markRead(id)`, `markAllRead`, `watch`. |
| M5-5 | **Live and catch-up (FEED-02, FEED-03, AC-6)** | `activity.watch(projectId, {afterId})` and `notification.watch({afterId})` return streams. The server first sends what the client missed (IDs above `afterId`, oldest first), then stays open. It wakes up on a **message** on channel `project:<id>` / `user:<id>` (posted when an event is written) **and every 3 seconds**. Each time it re-reads the events of the **last 60 seconds or above the last ID it sent**, and sends those it hasn't sent yet (it keeps their IDs). This answers two Serverpod facts: messages stay inside one server instance without Redis (the 3 s tick covers other instances), and a transaction that commits late can make IDs arrive out of order (the 60 s window catches them). The app de-duplicates by ID too. **No missed and no duplicate events.** Membership is checked again on each tick, so a removed member's stream ends with `projectNotFound` (MEMB-08). |
| M5-6 | **Reconnecting (NFR-REL-02)** | The app keeps the last ID it received. When a stream ends or fails, it waits 2 s, 4 s, 8 s … (at most 30 s), then subscribes again with that ID; meanwhile a small "Reconnecting…" line shows. Stream errors map to `NetworkException`. |
| M5-7 | **The feed (FEED-01, 05)** | `activity.list(projectId, {beforeId})` and `watch` return the event with the **actor's name** (`ActivityEntry`). The project page shows the **latest 5** with **See all**, a full feed page with infinite scroll (`_standards/14` §3.3: older pages below, live items on top through a separate BLoC event). Each event type has a sentence in EN and FR ("Ada approved Foundation", "Bob took a photo for Trenches: Verified"). Tapping opens the source: a photo opens its evidence page, a stage event its stage, a site event the project, a member event the members page. |
| M5-8 | **The review screen (REV-02)** | The stage page **is** the review screen: an approver looking at a `submitted` stage sees **Approve** and **Request changes** under the checklist and its photos with their badges. Below, the **review history** (decision, reviewer, date, comment) for everyone. The site manager sees **Submit for review**, enabled only when every required item is covered (otherwise it says which items are missing), and after changes were requested, the last comment at the top. The money released and spent for the stage (REV-02) comes with the ledger (M6). |
| M5-9 | **Progress updates (UPD-01, 02) — needs your choice** | **(a) With photos:** an update carries one or more photos taken with the in-app camera, verified like the others. Captures then also attach to an update instead of a checklist item: a model change (the item becomes optional, an `updateId` is added), a migration, and the capture flow told what it's attached to. About half a day more. **(b) Without photos (recommended):** text (1–2,000), optional stage, number of workers, weather (`sunny`, `cloudy`, `rain`, `storm`), issues; site manager only; shown live in the feed. Photos stay on checklist items, where they are checked against the plan. Photos on updates move to P1. **(c) Cut updates** from the MVP for now. |
| M5-10 | **Schedule status (STG-10, should-have) — needs your choice** | Your question of 2026-10-09: a stage past its planned end and not approved shows a **Late** chip on the plan and the stage page; a photo taken after the stage's planned end shows an **information line** on its evidence page ("Taken 5 days after the stage's planned end, 12 Oct"), with **no effect on the badge** (verification is about authenticity, lateness about the schedule). Computed in the app from dates it already has; no server change. About an hour. Recommendation: **include**. |
| M5-11 | **Out of M5** | Push, email and SMS notifications (NOT-03–05, P1/P2); "record a fund release" after approval (REV-06, with the ledger in M6); reopening an approval (REV-08, P1); several approvers per stage (REV-07, P2); feed filters (FEED-04, P1); editing updates (UPD-03, P1). |

**New models:** `stage_review.spy.yaml` (table), `review_decision.spy.yaml`, `stage_review_view.spy.yaml` (with the reviewer's name), `notification.spy.yaml` (table, index `userId, id`), `notification_type.spy.yaml`, `notification_page.spy.yaml` (with the unread count), `activity_entry.spy.yaml` (event + actor name), `activity_page.spy.yaml`, and with (b) `progress_update.spy.yaml` (table), `weather.spy.yaml`, `progress_update_draft.spy.yaml`. New `ActivityType` values: `stageSubmitted`, `stageApproved`, `stageChangesRequested`, `progressUpdatePosted`. One migration.

**New error codes:** `checklistIncomplete`, `reviewCommentRequired`, `notificationNotFound`, `invalidProgressUpdate` (EN + FR).

---

## Group A: submit, review, notifications (server, TDD)
`StageService.submit`, `StageService.review`, `StageService.reviews`; `NotificationService.notify(session, users, type, payload, transaction)` and the approvers / site managers of a project; `ActivityService.record` also posts the wake-up message (M5-5).
**Tests first:** submit by the site manager with every required item covered → `submitted`, one audit, one event, one notification per approver (owner and approving co-funder, not the co-funder without approval rights, not the actor); an optional item left empty doesn't block; a required item without a capture, or with only a retracted one, → `checklistIncomplete`; owner, co-funder, viewer can't submit (`permissionDenied`, AC-4); a draft or paused project → `projectNotActive`; a submitted stage refuses captures and edits. Review: approve by the owner and by an approving co-funder → `approved`, progress up; request changes without a comment → `reviewCommentRequired`, with one → `changes_requested` and the site manager notified; the site manager, a viewer and a co-funder without approval rights can't review (AC-4); reviewing a stage that isn't submitted → `invalidStageTransition`; resubmitting after changes, then approving, works (AC-4 end to end); the history lists every decision in order with the reviewer's name. Member joined → the owner is notified.

## Group B: live feed and notifications (server, TDD)
`ActivityEndpoint` (`list`, `watch`), `NotificationEndpoint` (`list`, `unreadCount`, `markRead`, `markAllRead`, `watch`).
**Tests first:** `list` pages by `beforeId` without overlap; `watch(afterId)` first sends the missed events oldest first, then live ones; an event written while the stream is open arrives once; an event whose transaction commits **after** a newer one arrives too, once (the 60 s window); a non-member can't watch (`projectNotFound`); a member removed while watching gets the stream closed; notifications: only the user's own, newest first, unread count, mark one and mark all read, `watch` sends only the user's own.

## Group C: progress updates (server, TDD) — with M5-9 (b)
`UpdateService`, `UpdateEndpoint` (`create`, `get`); the feed carries the update's ID and a short excerpt.
**Tests first:** the site manager posts an update (with and without a stage, every optional field); the limits; the others can't (`permissionDenied`); a stage of another project → `stageNotFound`; one event `progressUpdatePosted`.

## Group D: submit and review in the app (TDD)
`StageBloc` (+ `submitRequested`, `reviewRequested`, the history), the stage page (M5-8), the review dialog (decision, comment required for changes).
**Tests first:** Submit shown to the site manager, enabled only when complete, listing the missing items otherwise; Approve / Request changes only for approvers on a submitted stage; the comment is required for changes; the history shows each decision; the last requested change is shown to the site manager.

## Group E: feed and notifications in the app (TDD)
`ActivityRepository`, `NotificationRepository` with the reconnecting stream (M5-6); `FeedBloc` and `FeedPage` (infinite scroll + live), the project page's latest-activity section; `NotificationsBloc` (app-wide: unread count and live), the bell with its badge in the project list's app bar, `NotificationsPage` (mark read, mark all, tap → source); the sentence of each event and notification type (EN + FR).
**Tests first:** a live event goes on top once even if it also comes in a page; the reconnect resubscribes with the last ID after the backoff; the unread badge follows live notifications and mark-read; tapping an item opens its source; every event and notification type has a sentence in EN and FR.

## Group F: progress updates in the app (TDD) — with M5-9 (b)
`UpdateFormPage` (text, stage picker, workers, weather, issues) opened from the project page by the site manager; updates in the feed with their excerpt, tapping opens the full update.

## Group G: schedule status (app, TDD) — with M5-10
`StageX.isLate(today)`, the **Late** chip, the evidence page's information line. **Tests first:** late only when past the planned end and not approved; no planned end → never late; the line's wording with the number of days.

## You'll need
Two devices or windows signed in as different members (owner in Chrome, site manager on the emulator) to watch events arrive live.

## You run
- After groups A–C: `serverpod generate`, `serverpod create-migration`, `dart format .`, `dart analyze` (server); restart `serverpod start`. Claude runs `dart test`.
- After groups D–G: `flutter gen-l10n`, `dart run build_runner build --delete-conflicting-outputs`, `dart format .`, `dart analyze` (app). Claude runs `flutter test`; you check on the emulator and in Chrome side by side.

## Exit (M5)
AC-4 and AC-6 between the Android app and the web on the deployed build: the site manager submits a complete stage and the owner's bell lights up at once; the owner requests changes with a comment and the site manager sees it; after new photos and a resubmission the owner approves, the stage shows **Approved** and the project's progress goes up; with the phone offline for a while, the feed catches up on reconnection without gaps or duplicates. All tests pass, CI green, English and French complete.

---

## Outcomes

### Groups A to C outcome (2026-10-09)
Done. `dart test` **365/365** (new: 20 review-loop cases with the AC-4 permission cases, 9 live-feed and notification cases with the AC-6 catch-up and the late commit, 10 progress update cases). Seen red first: the new tests failed to compile until the models, services and endpoints existed.

Changes from the plan:
- The notification model is **`AppNotification`** (table `notification`): Flutter has its own `Notification` class, which the app imports alongside the client.
- One more error code, **`updateNotFound`**, so a missing update isn't reported as a missing project.
- `PeopleService` (names, approvers, site managers, owner) is shared by the review history, the feed and the notifications; a missing name never breaks them.

Found while testing (test mistakes, the server was right): `live_feed_test` runs without rollback, so it found an earlier project's membership and an earlier test's notifications; and Serverpod's test tools report the closed connection as a second error after the `projectNotFound` that ends a removed member's stream (checked with a throwaway debug test before changing the assertion).
