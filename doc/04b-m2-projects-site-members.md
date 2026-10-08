# M2: Projects, site, membership (detailed plan)

> **Status:** **approved 2026-10-06** by the developer. **Revised the same day** (approved "as recommended"): the site is localized by the site manager on the plot and validated by the owner (decisions M2-15 to M2-19), replacing the owner's map pin and Plus Code entry. Group A was done before the revision and is unaffected.
> **Master plan:** [04 §4 M2](04-implementation-plan.md#m2-projects-site-membership-d3). **Requirements:** PROJ-01–05, 08; SITE-03, 04, 07; MEMB-01–05, 08; AUD-01 ([02 §4](02-requirements-specification.md)). **Permissions:** [02 §3.2](02-requirements-specification.md#32-permission-matrix). **Acceptance:** AC-2 and the project-and-site part of AC-1 ([03 §6](03-mvp-scope.md#6-acceptance-criteria-core-loop)).
> Facts about Serverpod were checked in the installed 4.0.3 sources and skills: model relations, `Map<String, String>` fields, `unique(per=…)` indexes, and the template's `config.json` route (built from the server's public URL, so it is correct on Cloud).

**Goal:** a funder creates a project and invites a site manager, who joins, localizes the plot with the phone's GPS on site, and the funder validates the location. The permission matrix is in place for every later milestone.

**Schedule note:** today (D3) is M2's day, but M1's Cloud checks are still open. We're about half a day behind. Server groups B–D today and D4 morning, app groups E–G on D4; the half day is recovered from the D8 should-have day (cut order of [03 §3.4](03-mvp-scope.md#34-order-in-which-features-get-cut-if-time-runs-short) unchanged).

---

## Decisions
| # | Decision | Decided |
|---|----------|---------|
| M2-1 | **Groups and order** | **A** server foundation (done), **B** projects, **C** membership, **D** site localization and validation (needs a site manager, so after C), **E** app: project list, create wizard (Details → Review; the Stages step comes in M3), project overview, **F** app: members, invite, join, `/join/:code`, **G** app: "Localize site" (site manager) and "Validate site" (owner). Same TDD batching as M1-9: tests first, then one generator batch per group. |
| M2-2 | **Owner** | The owner is the `ProjectMember` row with role `owner`; no separate `ownerId` column on `Project` (one source of truth). `02` §7.2's `ownerId` is read that way. Users are referenced by the auth user ID (`UuidValue`), as decided in M1-1. |
| M2-3 | **Creation in one request** | `project.create` creates the project, the owner membership, the audit entry and the activity event **in one transaction**. No half-created project can exist (the lesson of the sign-up bug). The site is not part of creation (M2-15). |
| M2-4 | **Project status** | A new project is **`draft`** (waiting for its site). **Validating the first site location makes it `active`** (automatically, M2-15). The owner can then change it: `active ↔ paused`, `active / paused → completed`, `completed → archived`. `draft → active` by hand is refused (`invalidStatusTransition`). Read-only archived projects are PROJ-06 (P1). |
| M2-5 | **Permission design** | A server-only Dart enum `ProjectAction` with **one value per row of `02` §3.2** (also the rows used from M3 on). `PermissionService.require(session, projectId, action)` returns the caller's active `ProjectMember` or throws. **A non-member gets `projectNotFound`, the same as a missing project** (it doesn't reveal that a project exists). A member without the right gets `permissionDenied`. A removed member is a non-member (MEMB-08; streams follow in M5). |
| M2-6 | **Invitation code** | 8 characters from an alphabet without look-alikes (`23456789ABCDEFGHJKMNPQRSTUVWXYZ`, about 8.5 × 10¹¹ codes), made with `Random.secure()`, shown as `ABCD-EFGH`. Input is normalised (upper case, spaces and hyphens removed). Unique index; a new code is drawn on collision. Expires after **7 days**; single use (accepting changes `pending → accepted` in a transaction). The owner role can't be invited. |
| M2-7 | **Co-funder approval rights** | The owner chooses `canApprove` when inviting a co-funder (default off). Changing it later is MEMB-07 (P1). |
| M2-8 | **Link and deep link** | The link is `https://plotwatch.serverpod.space/join/ABCDEFGH`. It opens the web app's `/join/:code` route. A signed-out user goes through sign-in or sign-up first and comes back to the join screen (MEMB-03). **Android App Links** (the link opening the installed app) need `assetlinks.json` and the release signing fingerprint: moved to M8. On Android the user types or pastes the code. |
| M2-9 | ~~Site set by the owner (pin, Plus Code)~~ | **Replaced by M2-15** (revision of 2026-10-06). SITE-01 and SITE-02 move to P1. |
| M2-10 | **Site time zone (SITE-06)** | **Moved to P1.** The column stays nullable; no UI. The MVP shows times in the viewer's zone. |
| M2-11 | **Maps keys** | The map is used by the owner's "Validate site" screen. **Android:** key in a gitignored `plotwatch_flutter/android/secrets.properties`, read by Gradle into a manifest placeholder. **iOS:** key in a gitignored `plotwatch_flutter/ios/Flutter/Secrets.xcconfig`, passed through `Info.plist` to `AppDelegate.swift` (G2-2). **Web:** key stored as a Cloud password `googleMapsWebKey` (locally in `config/passwords.yaml`), added to the server's `config.json` as `mapsApiKey`; the app loads the Maps script with it before the first map opens. The key is never committed. |
| M2-12 | **Project list** | `ProjectSummary` (project, my role, progress) in a `ProjectSummaryPage`, page numbers per `_standards/14` §3.1, newest activity first (`updatedAt` desc, then `id` desc). Progress is 0 until M3 adds stages. The signed-in home page becomes this list. |
| M2-13 | **Currency** | ISO 4217 codes from a fixed list of constants on the server (as `ProfileService.supportedLocales`), mirrored in the app's picker (like `supportedLanguageCodes`). "Currency locked once money is recorded" (PROJ-04) is enforced in M6, when the ledger exists. |
| M2-14 | **New packages** | App: `google_maps_flutter`, `geolocator`, `share_plus`. Server: `open_location_code` (pure Dart, added in group A). You add them with `flutter pub add` / `dart pub add`. |
| M2-15 | **Site localization flow** (developer's scenario) | 1. The owner creates the project (`draft`). 2. The site manager joins. 3. On the plot, the site manager opens the project, taps **Localize site**, watches the GPS accuracy, and saves a **proposal**. This is done in the phone app only (web has no reliable GPS). 4. The owner sees the proposal on a satellite map with the circle, sets the radius and **validates** or **rejects** it with an optional reason. 5. Validating creates or moves the `Site`; the first validation makes the project `active`. 6. Moving the site later is the same flow. Every step writes an audit entry and an activity event (SITE-07). Captures (M4) are only possible on an `active` project. |
| M2-16 | **Radius** | Set by the **owner when validating** (10–500 m, default 50), because they see the plot on the map. |
| M2-17 | **GPS accuracy** | A proposal needs an accuracy of **20 m or better**, checked in the app and **enforced on the server** (`siteAccuracyTooLow`). A position that Android reports as mocked is refused (`siteMockLocation`). No fallback in the MVP: with a poor fix, the site manager moves to open sky and tries again. |
| M2-18 | **Rejecting** | The owner may reject a proposal with an optional reason; the site manager proposes again. A new proposal supersedes a pending one. |
| M2-19 | **Safeguard against a wrong location** | The site manager sets the location their own photos are later checked against. The owner's validation is the safeguard, so the owner sees the satellite view, the GPS accuracy and the time of the reading; mocked positions never reach them. A verified photo of the plot attached to the proposal is an M4 option if time allows. |

---

## Group A: server foundation (Claude, TDD)
**Files**
- Create in `plotwatch_server/lib/src/models/`: `project.spy.yaml`, `project_type.spy.yaml`, `project_status.spy.yaml`, `site.spy.yaml`, `project_member.spy.yaml`, `project_role.spy.yaml`, `member_status.spy.yaml`, `invitation.spy.yaml`, `invitation_status.spy.yaml`, `audit_log.spy.yaml`, `activity_event.spy.yaml`, `activity_type.spy.yaml`
- Modify `app_error_code.spy.yaml` (codes below)
- Create `lib/src/services/permission_service.dart` (+ `ProjectAction`), `geo_service.dart`. `audit_service.dart` and `activity_service.dart` are written in group B, whose endpoint tests are the first to use them (test first).
- Tests: `test/unit/permission_matrix_test.dart`, `test/unit/geo_service_test.dart`, `test/integration/permission_service_test.dart`

**Models** (main ones; enums follow `02` §7.2)
```yaml
# project.spy.yaml
class: Project
table: project
fields:
  name: String
  description: String?
  type: ProjectType
  status: ProjectStatus
  ### ISO 4217, e.g. XAF. Locked once ledger entries exist (M6).
  currencyCode: String
  plannedStart: DateTime?
  plannedEnd: DateTime?
  createdAt: DateTime
  updatedAt: DateTime
```
```yaml
# site.spy.yaml
class: Site
table: site
fields:
  projectId: int, relation(parent=project, onDelete=Cascade)
  centerLat: double
  centerLng: double
  ### Computed by the server from the centre.
  plusCode: String
  ### 10–500 m (SITE-03).
  radiusM: int
  addressText: String?
  ### IANA zone; no UI in the MVP (decision M2-10).
  timezone: String?
  updatedAt: DateTime
indexes:
  site_project_idx:
    fields: projectId
    unique: true
```
```yaml
# project_member.spy.yaml
class: ProjectMember
table: project_member
fields:
  projectId: int, relation(parent=project, onDelete=Cascade)
  authUserId: UuidValue
  role: ProjectRole
  canApprove: bool, default=false
  status: MemberStatus
  joinedAt: DateTime
  removedAt: DateTime?
indexes:
  project_member_idx:
    fields: projectId, authUserId
    unique: true
  project_member_user_idx:
    fields: authUserId
```
```yaml
# invitation.spy.yaml
class: Invitation
table: invitation
fields:
  projectId: int, relation(parent=project, onDelete=Cascade)
  role: ProjectRole
  canApprove: bool, default=false
  ### 8 characters, stored without the hyphen (decision M2-6).
  code: String
  status: InvitationStatus
  expiresAt: DateTime
  createdBy: UuidValue
  acceptedBy: UuidValue?
  createdAt: DateTime
indexes:
  invitation_code_idx:
    fields: code
    unique: true
```
- `AuditLog`: `actorId UuidValue?`, `projectId int?`, `action String`, `entityType String`, `entityId int?`, `before Map<String, String>?`, `after Map<String, String>?`, `createdAt`. **Append-only:** only `AuditService.record` writes it; nothing updates or deletes it.
- `ActivityEvent`: `projectId`, `actorId`, `type ActivityType` (M2: `projectCreated`, `projectUpdated`, `projectStatusChanged`, `siteChanged`, `memberJoined`, `memberRemoved`), `targetType`, `targetId`, `payload Map<String, String>?`, `createdAt`; index `(projectId, id)` for M5's catch-up.

**New error codes:** `projectNotFound`, `invalidProjectName`, `invalidProjectDescription`, `invalidCurrencyCode`, `invalidProjectDates`, `invalidStatusTransition`, `invalidSiteLocation`, `invalidSiteRadius`, `invitationNotFound`, `invitationExpired`, `invitationUsed`, `invalidInvitationRole`, `alreadyMember`, `cannotRemoveOwner`. Each gets EN + FR messages in the app (`AppErrorCodeX.message`).

**Tests first**
- `permission_matrix_test` (unit, table-driven): for **every `ProjectAction` × role** (owner, co-funder with and without `canApprove`, viewer, site manager) the expected allow/deny equals `02` §3.2. The test's table is written from the document, so a wrong cell in the code fails.
- `permission_service_test` (integration): no membership → `projectNotFound`; missing project → `projectNotFound`; removed member → `projectNotFound`; member without the right → `permissionDenied`; member with the right → returns the membership.
- `geo_service_test` (unit): haversine: 0 m for the same point, one degree on a meridian and on the equator ≈ 111,195 m, 50 m north = 50 m, the short way across the antimeridian; the Plus Code of a site centre is its 10-digit code. (Entering Plus Codes moved to P1 with the revision, M2-15.)


## Group B: projects (Claude, TDD)
**Files:** `endpoints/project_endpoint.dart`, `services/project_service.dart`, `services/audit_service.dart`, `services/activity_service.dart`, models `project_details.spy.yaml` (input: name, description, type, currency, planned dates), `project_summary.spy.yaml`, `project_summary_page.spy.yaml`, `project_overview.spy.yaml` (project + site or null + my role + pending proposal flag); test `test/integration/project_endpoint_test.dart`.

| Method | Who | Does |
|--------|-----|------|
| `project.create(ProjectDetails details)` | any signed-in user | M2-3: one transaction; `draft`; returns `ProjectOverview` |
| `project.list({page, pageSize})` | signed-in | the caller's active memberships only |
| `project.get(projectId)` | member | `ProjectOverview` |
| `project.update(projectId, ProjectDetails)` | owner | audit (before/after) + `projectUpdated` |
| `project.setStatus(projectId, ProjectStatus)` | owner | M2-4 transitions; audit + `projectStatusChanged` |

**Tests first** (each: happy path, every permission rule, every error code)
- create: the caller becomes `owner`; the project is `draft` with no site; one audit entry and one `projectCreated` event; invalid name / description / currency / dates → its code and **nothing is created**; unauthenticated → refused.
- list: only the caller's projects, with their role; a removed membership isn't listed; pagination (page 0 and 1, page size).
- get: member OK; non-member → `projectNotFound`.
- update / setStatus: owner OK; co-funder, viewer, site manager → `permissionDenied`; every allowed transition and every refused one, including `draft → active` by hand.

## Group C: membership (Claude, TDD)
**Files:** `endpoints/membership_endpoint.dart`, `services/membership_service.dart`, models `invitation_preview.spy.yaml` (project name, role, inviter name, expiry), `member_view.spy.yaml` (member + name + email); members and pending invitations are returned as **plain lists, not pages**, because a project has only a few of each; test `test/integration/membership_endpoint_test.dart`.

| Method | Who | Does |
|--------|-----|------|
| `createInvitation(projectId, role, {canApprove})` | owner | M2-6/7; audit |
| `listInvitations(projectId)` | owner | pending ones |
| `cancelInvitation(invitationId)` | owner | `pending → cancelled`; audit |
| `previewInvitation(code)` | signed-in | what the joiner sees before accepting; works without membership |
| `acceptInvitation(code)` | signed-in | creates the membership; audit + `memberJoined` |
| `listMembers(projectId)` | member | active members with name and email |
| `removeMember(projectId, memberId)` | owner | `active → removed`; audit + `memberRemoved` |

**Tests first** (AC-2 cases marked ★)
- ★ owner creates a site-manager invitation → 8-character code, expires in 7 days; ★ another user accepts → active `site_manager`; ★ the same code again → `invitationUsed`; ★ an expired code → `invitationExpired`; ★ a non-owner creating an invitation → `permissionDenied`.
- unknown code → `invitationNotFound`; lower case and `ABCD-EFGH` input accepted; inviting role `owner` → `invalidInvitationRole`; an existing member accepting → `alreadyMember` and the invitation stays pending; a cancelled code → `invitationUsed`.
- **two users accepting the same code at the same time → exactly one membership** (`RollbackDatabase.disabled`; the find-or-create lesson from M1).
- co-funder invited with `canApprove` → membership has it.
- removeMember: owner removes a site manager → they get `projectNotFound` on `project.get` right after (MEMB-08); removing the owner → `cannotRemoveOwner`; non-owner → `permissionDenied`.

## Group D: site localization and validation (Claude, TDD)
**Files**
- Create models `site_proposal.spy.yaml` (table), `site_proposal_status.spy.yaml`; modify `site.spy.yaml` (+ `validatedProposalId`, `validatedBy`, `validatedAt`); new error codes `siteProposalNotPending`, `siteAccuracyTooLow`, `siteMockLocation` (EN + FR).
- `ProjectAction.proposeSite` (site manager only), added to the matrix test and to `02` §3.2. Validating and rejecting use `editProject` (owner).
- `endpoints/site_endpoint.dart`, `services/site_service.dart`; test `test/integration/site_endpoint_test.dart`.

```yaml
# site_proposal.spy.yaml
### A site location proposed by a site manager on the plot (decision M2-15).
### Rows are never deleted: they are the history of the site's location.
class: SiteProposal
table: site_proposal
fields:
  projectId: int, relation(parent=project, onDelete=Cascade)
  proposedBy: UuidValue
  lat: double
  lng: double
  ### GPS accuracy of the reading in metres; at most 20 (M2-17).
  accuracyM: double
  ### When the server received the proposal (trusted time).
  proposedAt: DateTime
  status: SiteProposalStatus
  decidedBy: UuidValue?
  decidedAt: DateTime?
  rejectReason: String?
indexes:
  site_proposal_project_idx:
    fields: projectId, status
```

| Method | Who | Does |
|--------|-----|------|
| `site.get(projectId)` | member | the validated site, or null |
| `site.propose(projectId, lat, lng, accuracyM, isMocked)` | site manager | M2-17 checks; supersedes a pending proposal; audit + activity |
| `site.listProposals(projectId)` | member | newest first (pending first in the app) |
| `site.validate(proposalId, radiusM, {addressText})` | owner | creates or moves the `Site` (Plus Code computed); first time `draft → active`; one transaction; audit (before/after) + `siteChanged` |
| `site.reject(proposalId, {reason})` | owner | `pending → rejected`; audit + activity |

**Tests first**
- propose: site manager OK; owner, co-funder, viewer → `permissionDenied`; non-member → `projectNotFound`; accuracy 20 m accepted, 20.1 m → `siteAccuracyTooLow`; mocked → `siteMockLocation`; latitude / longitude out of range → `invalidSiteLocation`; a second proposal supersedes the first.
- validate: owner OK; site manager → `permissionDenied`; radius 9 / 501 → `invalidSiteRadius`; first validation creates the site, sets the Plus Code and makes the project `active`; a later validation moves the site and keeps the project's status; validating a rejected or superseded proposal → `siteProposalNotPending`; audit has before/after, one `siteChanged` event.
- reject: owner OK with or without a reason; not pending → `siteProposalNotPending`; the project stays `draft` when its first proposal is rejected.

**You run** after groups B–D (one batch): `serverpod generate`, `serverpod create-migration` (the `site_proposal` table and the `site` columns), `dart format`, `dart analyze`; Claude runs `dart test`; you deploy.

## Group E: app, projects (Claude, TDD)
**Files:** `data/api/project/project_api_provider.dart`, `domain/repository/project_repository.dart`, features `projects/` (`ProjectListBloc` with `infinite_scroll_pagination` per `_standards/13`, `CreateProjectBloc` for the wizard, `ProjectOverviewBloc`), pages `ProjectListPage` (replaces the home placeholder), `CreateProjectPage` (Details → Review; the Stages step is added in M3), `ProjectOverviewPage` (details, status, site state: *waiting for localization* / *proposal to validate* / *validated*, members button, owner actions: edit, change status), `EditProjectPage`. Localized labels for project type, status and role (`_standards/14` §1.3). Routes: `projects`, `projects/new`, `projects/:id`, `projects/:id/edit`.

**Tests first:** repository (page → `PaginatedList`, errors rethrown); each BLoC's handlers (success and every failure type, RULE-009 order); widget tests: list states (loading, empty, error, items with role chip and status), wizard validation and Review sending one `create`, overview shows owner actions only to the owner and the right site state.

## Group F: app, members and join (Claude, TDD)
**Files:** `data/api/membership/…`, `domain/repository/membership_repository.dart`, features `members/` (`MembersBloc`: list, remove, pending invitations, cancel; `InvitationBloc`: create, share), `join/` (`JoinProjectBloc`: preview, accept), pages `MembersPage`, `InviteSheet` (role, `canApprove` for co-funders, then code + link + share), `JoinProjectPage` (code field, preview, Join). Route `/join/:code` (deep link, M2-8); the auth guard keeps the target through sign-in and sign-up.

**Tests first:** BLoCs (each handler and failure); widget tests: members list with remove only for the owner, invite flow shows the formatted code, join with a code shows the preview then joins; router: signed-out `/join/X` → welcome, and after sign-in → `/join/X`.

## Group G: app, localize and validate the site (Claude, TDD)
**Files:** `data/device/location_provider.dart` (geolocator: permission, position stream with accuracy, mock flag), `data/api/site/…`, `domain/repository/site_repository.dart`, features `site/` (`LocalizeSiteBloc`, `ValidateSiteBloc`), pages `LocalizeSitePage` (site manager, Android: live accuracy, "Save" enabled at ≤ 20 m, permission and GPS-off states), `ValidateSitePage` (owner: satellite map with the point and the circle, radius slider 10–500 m, accuracy and time of the reading, Validate / Reject with reason), web Maps loader (`core/maps_loader.dart`, reads `mapsApiKey` from `config.json`), Android manifest placeholder.

**Tests first:** `LocalizeSiteBloc` (permission denied, GPS off, accuracy improving to ≤ 20 m enables saving, mocked position refused, save success / each failure), `ValidateSiteBloc` (radius limits, validate, reject, failures); widget tests with the location provider and the map replaced by test doubles (the Google map can't render in widget tests).

**You'll need:** a Google Cloud project with **Maps SDK for Android**, **Maps SDK for iOS** and **Maps JavaScript API** enabled, a budget alert, and three keys: Android (restricted to `com.afesohromeo.plotwatch` + your debug SHA-1), iOS (restricted to the bundle ID `com.afesohromeo.plotwatch`, G2-3) and web (restricted to `localhost` and `plotwatch.serverpod.space`). Then `serverpod cloud password set googleMapsWebKey <key>`.

**You run** after groups E–G: `flutter pub add google_maps_flutter geolocator share_plus`, `build_runner`, `gen-l10n`, `dart format`, `dart analyze`; Claude runs `flutter test`; you deploy.

---

## Exit (M2)
On the deployed build, with two accounts (owner in Chrome, site manager on Android):
1. The owner creates a project; it is listed as **draft**, waiting for its site.
2. The owner invites a site manager; the code and link are shown and shared.
3. The site manager joins with the code (and, once, through the link on the web); both see the project with their role.
4. The code used again → "already used"; an expired code → "expired" (expiry is shortened only in the server test, not on Cloud).
5. Outdoors, the site manager localizes the site (accuracy ≤ 20 m) and saves.
6. The owner sees the proposal on the map, sets the radius, validates; the project becomes **active**. A second proposal is rejected with a reason and the site stays where it was.
7. The owner removes the site manager, who loses access immediately.
8. All tests pass, CI is green, English and French complete.

---

---

## Outcomes

### Group A outcome (2026-10-06)
Done and verified: 12 models (tables `project`, `site`, `project_member`, `invitation`, `audit_log`, `activity_event`) in one migration, 14 error codes with EN + FR messages, `PermissionService` (full matrix of `02` §3.2) and `GeoService`. `dart test` **118/118** (the permission matrix alone is 91 cases), `flutter test` **202/202**.

Changes from the plan:
- **`ProjectType.expansion`** instead of `extension` (renamed by the developer: `extension` is a reserved word in Dart, so generation failed). The app's label can still read "Extension".
- `AuditService` and `ActivityService` move to group B, where tests first use them.
- The migration was created after group A instead of after group C: all M2 tables are in group A.

### Groups B–D outcome (2026-10-06)
Done and verified: `ProjectEndpoint`, `MembershipEndpoint` and `SiteEndpoint` with their services, plus `AuditService` and `ActivityService`. `dart test` **200/200** (projects 31, membership 21, site 25, permission service 6, permission matrix 97), `flutter test` **214/214**. Seen red first: the tests failed to compile until the endpoints and models existed. Two rules were then broken on purpose to check the tests catch them: an accuracy limit of 25 m instead of 20, and no row lock when accepting an invitation (the concurrent-accept test). Both made the tests fail.

Changes from the plan:
| Item | Change | Reason |
|------|--------|--------|
| Endpoint signatures | `cancelInvitation`, `removeMember`, `site.validate` and `site.reject` also take the project ID | The permission check on the project comes first, as in every endpoint (`_standards/14` §4.2) |
| Optional parameters | `project.list({int? page, int? pageSize})`, `createInvitation(…, {bool? canApprove})`; defaults applied on the server | Serverpod 4.0.3 makes a named parameter with a default **required** in the generated client (feedback F-8) |
| Error codes | 6 more than planned: `memberNotFound`, `siteProposalNotFound`, `textTooLong` (address > 200, reject reason > 500 characters), besides `siteProposalNotPending`, `siteAccuracyTooLow`, `siteMockLocation` | Cases found while writing the tests |
| Activity types | `siteProposed`, `siteProposalRejected`; the first validation also writes `projectStatusChanged` | The feed shows every step of the site flow (SITE-07) |
| Migration | Created with `--force`: adding required columns made Serverpod drop and recreate `site` | Safe: the table was empty everywhere (not deployed yet). Once `site` holds data, a change like this needs a nullable column or a default (feedback F-9) |
| Invitation status | A pending code past its expiry is refused but stays `pending` in the database; `expired` is reserved for a later cleanup job | A refused accept rolls back its transaction, so it can't also store the status |

### Group E outcome (2026-10-06)
Done and verified: project list (signed-in home page, infinite scroll per `_standards/13`), create wizard (Details → Review, one create request), project page (details, role, status, site state; owner: edit and status menu), edit page. `flutter test` **285/285**, `dart test` **200/200**.

Changes and fixes found along the way:
| Item | Change | Reason |
|------|--------|--------|
| `PaginatedList<T>` | Created in `domain/models/` (Freezed) | `_standards/14` §3.2; first paginated list of the app |
| `ProjectDetails` | `immutable: true` | Generated models have no `==`; BLoC events carrying the details must compare by value |
| Kit `formatDate` | Takes the app language (was always `fr_FR`) | AC-7: dates in the user's language. Test added |
| Kit `SearchableDropdownField` | Dismissing the sheet keeps the value (it used to clear it, also on the profile's country); closes with `Navigator` instead of go_router | Bug found while writing the form tests; the test was seen failing without the fix |
| Barrels | `searchable_dropdown_field` and `date_picker_field` exported; profile page imports through the barrel; duplicate exports removed from the extensions barrel | The barrel-only convention |
| Home page | M1's placeholder `HomePage` and its two texts removed; the project list keeps the profile and sign-out buttons | Decision M1-8 said the project list replaces it in M2 |
| Site on the project page | Three texts: owner (what happens next), site manager (go and localize), other members (waiting) | The owner's text didn't fit viewers and co-funders. The proposal state and actions come with group G |
| Currencies | 19 codes (`supportedCurrencyCodes`), mirroring the server | Decision M2-13 |

---

## Group E2: brand: logo, app icon, splash (approved 2026-10-07)
Inserted before group F at the developer's request ("a splash screen and a logo before deploying"). Logo chosen on the [concept canvas](https://claude.ai/artifact/SzFhi7nQJVq31FcmB3heEi): **D1**, a location pin whose head holds an outlined house with two stage bars (the current stage in the accent): concept A (plot pin) combined with concept C (built in stages), the developer's proposal.

### Decisions in this draft
| # | Decision | Proposal |
|---|----------|----------|
| E2-1 | **One mark, three levels of detail** | D1's bars disappear at small sizes, so the master SVGs come in three levels: **full** (two bars) for the splash and the welcome page; **launcher** (one accent bar, thicker strokes) for the app icon, which Android shows at 48–192 px; **tiny** (pin only) for the 16–32 px favicon. |
| E2-2 | **Colours** | Icon background `primary` `#0E5A52`; mark white; the current-stage bar in a light accent tint **`#E8A27E` (`accentOnDark`)**, because `#A44A24` is too dark on teal. The token is added to `doc/05` §2. Splash and web background: `ground` `#F4F6F4`. |
| E2-3 | **App icon** | `flutter_launcher_icons` (new dev dependency). Android **adaptive icon**: teal background plus the launcher mark as foreground inside the 66 % safe zone; **monochrome** layer for Android 13 themed icons; legacy icon for older launchers. Web: `Icon-192/512` and the maskable versions. |
| E2-4 | **Splash** | `flutter_native_splash` (already a dependency). **Revised by the developer (2026-10-07), as in SmartDrive:** the whole screen in `primary` with the white mark on it (no circle); on Android 12+ the round icon area takes the same teal. No wordmark at the bottom (it would need the Manrope text converted to outlines; P1). |
| E2-5 | **Web details** | `favicon.png` from the tiny mark; `manifest.json`: `theme_color` `#0E5A52`, `background_color` `#F4F6F4`, a real description; `index.html` description too. |
| E2-6 | **Logo in the app** | The full mark above the title on the welcome page, through `flutter_svg` (new dependency; `flutter_gen` already has its integration switched on, so the SVG gets a typed `Assets.brand…` accessor). Widget test: the welcome page shows the logo with its semantic label. |
| E2-7 | **SVG → PNG** | The two generators need PNGs. They are exported from the committed SVGs with **headless Chrome** (already installed), one command per file in a "You run" step: no new tool. The SVGs are the source; the PNGs are committed too, so a clone builds without Chrome. |

### Files
- `plotwatch_flutter/assets/brand/`: `mark_full.svg`, `mark_launcher_foreground.svg` (mark in the adaptive safe zone, transparent background), `mark_monochrome.svg`, `icon_launcher.svg` (teal rounded square plus mark: legacy and web), `mark_tiny.svg`, `splash_mark.svg` (full mark in a teal circle); the exported `*.png` beside them.
- `plotwatch_flutter/flutter_launcher_icons.yaml`, `plotwatch_flutter/flutter_native_splash.yaml`.
- `web/manifest.json`, `web/index.html`; `lib/src/features/welcome/views/welcome_page.dart`; `doc/05-design-system.md` (logo section, `accentOnDark`).

### You run (after Claude writes the SVGs and configs)
1. The PNG exports (headless Chrome, commands given with the files).
2. `flutter pub add flutter_svg dev:flutter_launcher_icons`
3. `dart run flutter_launcher_icons` and `dart run flutter_native_splash:create`
4. `dart run build_runner build --delete-conflicting-outputs` (asset accessors), `dart format`, `dart analyze`.

Then Claude runs `flutter test`, and you check the icon and splash on the emulator and in Chrome.

### Group E2 outcome (2026-10-07)
Done and checked by the developer on the Android emulator and in Chrome: app icon (adaptive, monochrome, legacy, iOS, web), splash (full-screen `primary` with the white mark, revised by the developer as in SmartDrive), favicon (pin only), web manifest colours and description, and the logo on the welcome page. `flutter test` **286/286** (new: the welcome page shows the logo with its screen-reader label).

Also fixed with this group:
- **Release manifest:** `android.permission.INTERNET` was missing from `main/AndroidManifest.xml` (only the debug manifest had it), so a release APK couldn't reach Serverpod Cloud.
- **Debug manifest:** `usesCleartextTraffic` for debug builds only, so the emulator can reach the local server over `http://10.0.2.2:8080`.
- **VS Code:** launch configurations for the Android emulator (local server) and for Cloud; a local `serverpod_start_server_only` task (`serverpod start --no-flutter`).
- SVG → PNG export runs with `tool/export_brand_pngs.cmd` (headless Chrome).

### Group F outcome (2026-10-07)
Done and verified: members page (members with role; owner: invite, remove with confirmation, pending invitations with formatted code and cancel), invite sheet (role, approval rights for a co-funder, code + link + share), join page (code or `/join/:code` link → preview → join → opens the project), entry points (Members button on the project page, Join action on the project list). `flutter test` **338/338**. Seen red first (missing classes); then two rules were broken on purpose and the tests caught both (owner-only actions, and remembering the invitation link through sign-in).

Changes and decisions taken while implementing:
| Item | Change | Reason |
|------|--------|--------|
| Invitation link through sign-in (MEMB-03) | The router remembers a `/join/…` address opened while signed out, sends to the welcome page, and returns there after sign-in or sign-up | Plan's "the auth guard keeps the target"; kept in the `RouteManager` instance, cleared once used |
| Web URLs | `usePathUrlStrategy()` (`flutter_web_plugins`): no `#` in addresses | So the link reads `https://plotwatch.serverpod.space/join/ABCD2345`; the server's `FlutterRoute` already falls back to `index.html` for any path |
| Link base | `--dart-define=WEB_APP_URL`, else the current site on web, else the Cloud web app | The Android app has no site of its own |
| `share_plus` | **13.3.1**, not PlusLocate's 10.x | 10.x needs `win32` 5; Serverpod 4.0.3 needs `win32` 6 |
| Confirmation dialog | New shared `showConfirmDialog` | The kit has none; removing a member is destructive |
| Removal and cancelling | The lists update locally after the server confirms; no reload | One request each |

---

## Group F2: join page fix and Android App Links (approved 2026-10-07)
Found by the developer while testing group F.

| # | Decision |
|---|----------|
| F2-1 | **Join page:** Join used the code saved at check time, so after editing the field the preview (and Join) still belonged to the old code. Not a security issue (the server checks every code), but misleading. Fix: as soon as the field no longer matches the checked code, the preview, errors and Join button disappear until the code is checked again (`JoinProjectEvent.codeEdited`). |
| F2-2 | **Android App Links now, not in M8** (changes M2-8): the invitation link `https://plotwatch.serverpod.space/join/<code>` opens the installed app on the join page; without the app it still opens the web app. An `autoVerify` intent filter for `/join` in the Android manifest, and `/.well-known/assetlinks.json` served by the Serverpod web server with the package name and the **debug** key's SHA-256 fingerprint. The release fingerprint is added in M8. The file lives in `plotwatch_server/web/app_links/` (not a dot folder: Serverpod Cloud skips hidden folders on upload). Verified on Cloud after a deploy (Android only verifies the real domain). |

## Group F3: re-share an invitation, copy the link (approved 2026-10-07)
Found by the developer while testing group F: the code could only be shared from the sheet right after creating it (a mis-click on Done lost it), and the share sheet isn't always available in desktop browsers.

| # | Decision |
|---|----------|
| F3-1 | Each pending invitation on the members page has a **share** button that opens the "Invitation ready" sheet for that invitation (`InvitationBloc` can start from an existing invitation). |
| F3-2 | The sheet has **Copy link** next to Share; after copying, the button reads "Link copied ✓" (no dialog, no snackbar). The clipboard sits behind a `ClipboardProvider` (`data/device`), like sharing. |
| F3-3 | The share error seen while testing (`MissingPluginException`) was a running app built before `share_plus` was added: a new plugin needs a full rebuild, not a hot restart. |

---

## Group G: detailed plan (approved 2026-10-07)
Expands the group G section above. Written after Claude had started (developer's remark: plan first). Already drafted, uncommitted, kept or changed according to this approval: the server change and its tests (G-1, G-2), the app's repository and BLoC tests, the fixtures, and the `SubmitButton` change (G-9).

### Decisions
| # | Decision | Proposal |
|---|----------|----------|
| G-1 | **Pending proposal on the project page** | `ProjectOverview` gains `pendingSiteProposal` (server: one more read of `site_proposal` in `ProjectService`; no table change). The project page then shows the owner **Review the location** and the site manager **Waiting for the owner**, without an extra request. |
| G-2 | **Web Maps key** | Served in `config.json` as `mapsApiKey`, from the Serverpod password `googleMapsWebKey` (Cloud: `serverpod cloud password set`; locally: `config/passwords.yaml`, gitignored). For the local web debug run (`flutter run`, which doesn't use the server's `config.json`), `--dart-define=MAPS_API_KEY=…` in the web launch configuration. The app loads the Maps script with the key the first time a map opens. |
| G-3 | **Android Maps key** | In a gitignored `plotwatch_flutter/android/secrets.properties` (`MAPS_API_KEY=…`), read by `build.gradle.kts` into a manifest placeholder for `com.google.android.geo.API_KEY`. Without the file the app builds, and only the map stays blank. |
| G-4 | **Where each screen runs** | **Localize site:** phone app only. On web it shows "Localize the site with the Plotwatch app on your phone, standing on the plot" (browsers' GPS is coarse and can't report mocked positions). **Validate site:** web and phone. |
| G-5 | **Localize site screen** | Asks for location permission when it opens. States: checking; denied (button **Allow location**, asks again); denied for good (button **Open settings**); GPS off (button **Turn on location**); live reading. The reading shows the accuracy large (e.g. "± 8 m"), green at 20 m or better, amber otherwise, with "Wait for 20 m or better, in the open". A mocked position shows the refusal reason. **Save** is enabled only at ≤ 20 m and not mocked, mirroring the server (decision M2-17). After saving, a success dialog, then back to the project page. |
| G-6 | **Validate site screen** | Satellite map with the proposed point and the circle; radius slider 10–500 m (starts at the current site's radius, else 50); the reading's accuracy and time; optional address or landmark (≤ 200 characters); **Validate** and **Reject**; Reject asks for an optional reason in a dialog. After either, a success dialog, then back to the project page (the first validation makes the project active). No pending proposal: "No location is waiting for validation". |
| G-7 | **Project page, site section** | No site, nothing pending: owner "waiting for the site manager" (current text); site manager **Localize site**. Proposal pending: owner **Review the location**; site manager "Waiting for the owner" and **Localize again** (a new proposal supersedes the pending one). Site validated: Plus Code, radius, address; site manager **Propose a new location** (moving the site, M2-15 step 6). |
| G-8 | **Map in tests** | Google maps can't render in widget tests: `ValidateSitePage` takes the map as a builder (default: the real `SiteMap`); tests pass a plain box. `LocationProvider` (geolocator: permission, service, position stream with accuracy and mock flag) is mocked like `ShareProvider`. |
| G-9 | **`SubmitButton` can be disabled** | `onPressed` becomes nullable (null disables it), for Save until the accuracy is good. Existing callers are unchanged. |
| G-10 | **Permissions declared** | Android: `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`. iOS (untested, D-4): `NSLocationWhenInUseUsageDescription`, so an iOS build doesn't crash when asking. |
| G-11 | **Packages** | `geolocator`, `google_maps_flutter`: the newest versions that resolve with Serverpod 4.0.3 (the `share_plus` lesson: `win32` 6). |
| G-12 | **The owner can localize too** (developer, 2026-10-07) | An owner standing on the plot localizes the site themselves: "propose the site location" becomes **owner and site manager** (`02` §3.2; co-funders and viewers still can't). After saving, the owner goes straight to the Validate screen for that proposal (radius, address, validate). If they stop there, the proposal stays pending and the project page shows **Review the location**. Project page without a site, owner: "Invite a site manager to localize the plot, or localize it yourself if you're on the plot." plus **Localize site**. No new endpoint; the audit log shows the owner proposed and validated. The M2-19 safeguard (owner validation) targets the site manager, so it isn't needed against the owner. Tests: permission matrix row and the server test that refused the owner change. |

### Files
- Server: `models/project_overview.spy.yaml` (+ `pendingSiteProposal`), `services/project_service.dart`, `web/routes/app_config_route.dart` (+ `mapsApiKey`), `server.dart`; tests `site_endpoint_test.dart` (+ overview carries the pending proposal), `test/unit/app_config_route_test.dart`.
- App data: `data/api/site/site_api_provider.dart`, `data/device/location_provider.dart`, `domain/repository/site_repository.dart`, `domain/models/gps_reading.dart` (Freezed: lat, lng, accuracy, mocked) and `LocationAccess` (granted, denied, deniedForever, serviceDisabled).
- App features `site/`: `LocalizeSiteBloc`, `ValidateSiteBloc`, `LocalizeSitePage`, `ValidateSitePage`, `widgets/site_map.dart`; `core/maps/maps_loader.dart` (web: loads the Maps script; elsewhere nothing).
- Routes: `/projects/:projectId/site/localize`, `/projects/:projectId/site/validate`. Project page site section (G-7). EN + FR texts.
- Android: `AndroidManifest.xml` (permissions, Maps key placeholder), `build.gradle.kts` (reads `secrets.properties`), `.gitignore`. iOS: `Info.plist`.

### Tests first
- Server: the overview carries the pending proposal and drops it once validated; `config.json` with and without a Maps key.
- Repository: propose sends position, accuracy and mock flag; list, validate, reject; errors rethrown.
- `LocalizeSiteBloc`: allowed → readings stream in; denied, denied for good, GPS off → no readings; `canPropose` at exactly 20 m, not at 20.5 m, not when mocked; save success; server refusal (`siteAccuracyTooLow`); unexpected failure; nothing sent with a poor reading.
- `ValidateSiteBloc`: pending proposal with default radius; existing site's radius as the start; nothing pending; radius clamped to 10–500; validate sends radius and address; reject sends the reason; `siteProposalNotPending`.
- Widgets: Localize (each permission state and its button; accuracy colours; Save disabled until ≤ 20 m; mocked message; web message), Validate (map placeholder, slider, Validate and Reject with reason), project page site section (each role × each state of G-7).

### You'll need
The Google Maps keys (group G above). Without them everything is testable; only the real map stays blank.

### You run (one batch)
`serverpod generate` (server); `flutter pub add geolocator google_maps_flutter`, `flutter gen-l10n`, `dart run build_runner build --delete-conflicting-outputs`, `dart format`, `dart analyze` (app). Then Claude runs both test suites, and you check on the emulator (localize, using its virtual location set inside a plot) and in Chrome (validate).

### Groups F2, F3 and G outcome (2026-10-07)
Done: join fix (F2-1), Android App Links with the debug fingerprint (F2-2; to verify on Cloud), refresh button and pull-to-refresh on the members and project pages, re-share and copy link (F3), site localization and validation (G, with G-12: the owner can localize too). `dart test` **205/205**, `flutter test` **395/395**.

Found by the tests and fixed: the reject dialog disposed its text controller while its closing animation still used it (now a small widget that owns the controller).

Also: the GitHub Format workflow had failed since group B because some server files were committed unformatted; both packages are now formatted with `dart format .`, and every "You run" batch formats whole packages from now on.

## Group G2: iOS setup without a Mac (approved 2026-10-07)
The app targets Android and iOS (and the web). The iOS project is set up from Windows, the same way PlusLocate was; it is built and checked on a Mac or a cloud Mac build later.

| # | Item | Decision |
|---|------|----------|
| G2-1 | **Bundle ID** | `com.afesohromeo.plotwatch`, the same as the Android application ID (tests target: `com.afesohromeo.plotwatch.RunnerTests`). Changed in `Runner.xcodeproj/project.pbxproj`. |
| G2-2 | **iOS Maps key** | In a gitignored `ios/Flutter/Secrets.xcconfig` (`MAPS_API_KEY = …`), included with `#include?` from `Debug.xcconfig` and `Release.xcconfig` (the `?` means a missing file is not an error). `Info.plist` exposes it as `GMSApiKey = $(MAPS_API_KEY)`; `AppDelegate.swift` reads `GMSApiKey` and calls `GMSServices.provideAPIKey` when it is not empty. A committed `Secrets.xcconfig.example` shows the format. Same pattern as PlusLocate. Without the file the app builds, and only the map stays blank. |
| G2-3 | **Third Google key** | Maps SDK for iOS enabled in the same Google Cloud project; a key restricted to iOS apps with the bundle ID `com.afesohromeo.plotwatch`. |

**Files:** `ios/Runner.xcodeproj/project.pbxproj`, `ios/Flutter/Debug.xcconfig`, `ios/Flutter/Release.xcconfig`, `ios/Flutter/Secrets.xcconfig.example`, `ios/.gitignore`, `ios/Runner/Info.plist`, `ios/Runner/AppDelegate.swift`.

**Tests:** native configuration only, no Dart code changes, so no new Dart tests. It can't be compiled on Windows; the first iOS build (Mac or cloud Mac) is the check.

### Group G2 outcome (2026-10-07)
Done as planned. Not compiled yet (no Mac); the first iOS build is the check.

### Fix found while testing (2026-10-08)
The Android build failed: `build.gradle.kts` wrote `java.util.Properties()`, and in a Gradle Kotlin script `java` is the project's Java extension, not the package. Fixed with `import java.util.Properties` at the top of the script. Claude doesn't build the app, so native build files are checked only by the developer's first build after a change.

## Group H: Back button, owner site actions, member roles (approved 2026-10-08)
Found by the developer while testing on the emulator: the Android Back button closed the app on every page; after validation the owner had no way to move the site or change its radius; a role could only be changed by removing and re-inviting the member.

### Decisions
| # | Item | Decision |
|---|------|----------|
| H-1 | **Nested routes** | Routes are nested by hierarchy (as in SmartDrive), so `goNamed` builds the page stack and Android Back goes up one level. The project list moves from `/home` to `/`; every other address is unchanged, including `/join/<code>` (invitation links, App Links). Back on the project list closes the app (Android convention). Tree: `/` (projects) → `projects/new`, `projects/:projectId` → (`edit`, `members`, `site/localize`, `site/validate`, `site/edit`), `join` → `:code`, `profile`. Welcome, sign-in, sign-up and password reset stay top level. The `root` redirect route is removed (the list is at `/`). Path constants: top-level paths keep their leading `/`, child paths are relative segments (SmartDrive convention); the full paths used by the redirect logic (`/join`) stay as constants. |
| H-1a | **Reload when shown again** | With nesting, the pages underneath stay alive, so the project list and the project page would show stale data after a child page changes something (a new project, a validated site). A small shared widget `ReloadOnReturn` calls a callback when its page becomes the top page again (`ModalRoute.isCurrentOf`). The project list refreshes and the project page reloads. A dialog or menu closing on the page also counts as a return (one extra request, accepted; replaced by M3-F1 in `04c`: the reload raced with the dialog's action). The in-page back arrows keep using `goNamed` to the parent. |
| H-2 | **Owner moves the site** | Once a site is validated, the owner also sees **Propose new location** (the same localize flow, phone only; the web page explains this, as before the first validation). Server unchanged: `proposeSite` already allows the owner (G-12). |
| H-3 | **Owner edits the site** | **Edit site** for the owner once a site exists: the map with the current point and circle, the radius slider and the address, prefilled; **Save** changes only the radius and the address. New `site.update(projectId, {radiusM, addressText})`, owner only (`editProject`), same limits as validation (10–500 m, address ≤ 200), `siteNotFound` when no site exists yet. Audit `site.update` (before/after) and activity `siteChanged`. A blank address removes it. Photos keep the result they got at capture time (each capture is checked against the site as it was then). App: `EditSiteBloc`, `EditSitePage`, route `site/edit` (`edit-site`); the radius slider row moves into a shared `SiteRadiusField` used by both the validate and the edit page. |
| H-4 | **Change a member's role** | New `membership.changeRole(projectId, memberId, role)`, owner only (`manageMembers`). The target must be an active member of the project (`memberNotFound`); the owner's role can't be changed (`cannotChangeOwnerRole`); the new role can't be owner (`invalidMemberRole`). The same role is a no-op (nothing recorded). Leaving co-funder resets `canApprove` to false. Audit `member.changeRole` (before/after), activity `memberRoleChanged` (new `ActivityType` value; enums are stored by name, so no migration). A pending site proposal made by a site manager whose role changes stays pending; the owner still decides. App: on the members list the owner gets a **Change role** button next to Remove, opening a dialog with co-funder, viewer and site manager (current role marked); the list updates in place. `canApprove` (the co-funder approval switch) comes in M3 with approvals. |
| H-5 | **Scope** | MEMB-07 (role change only) moves into the MVP (`03` §3.1); setting `can_approve` stays with M3. |
| H-6 | **Android Gradle Plugin** | 9.1.0 → 9.1.1, as in SmartDrive and PlusLocate. |

### Files
- Server: `site_endpoint.dart` (+ `update`), `site_service.dart` (+ `update`), `membership_endpoint.dart` (+ `changeRole`), `membership_service.dart` (+ `changeRole`), models `app_error_code.spy.yaml` (+ `siteNotFound`, `cannotChangeOwnerRole`, `invalidMemberRole`), `activity_type.spy.yaml` (+ `memberRoleChanged`).
- App: `route_paths.dart`, `route_names.dart` (+ `edit-site`), `route_manager.dart`; `shared/components/reload_on_return.dart`; `project_list_page.dart`, `project_overview_page.dart` (site section, `ReloadOnReturn`); `features/site/` (`EditSiteBloc`, `EditSitePage`, `widgets/site_radius_field.dart`; `ValidateSitePage` uses the field); `SiteApiProvider`/`SiteRepository` (+ `update`); `MembershipApiProvider`/`MembershipRepository` (+ `changeRole`); `MembersBloc` (+ `changeRole`), `MembersPage` (button and dialog); `app_error_code_extensions.dart`; ARB EN + FR.
- Android: `settings.gradle.kts` (AGP 9.1.1).
- Docs: `02` (MEMB-07 → MVP for the role), `03` §3.1, `00` status.

### Tests first
- Server `site_endpoint_test`: owner updates radius and address (audit before/after, one `siteChanged`); blank address removes it; radius 9 / 501 → `invalidSiteRadius`; no site → `siteNotFound`; site manager, co-funder, viewer → `permissionDenied`; outsider → `projectNotFound`.
- Server `membership_endpoint_test`: owner changes viewer → co-funder (audit, one `memberRoleChanged`); co-funder with `canApprove` → viewer resets it; same role records nothing; owner's role → `cannotChangeOwnerRole`; role owner → `invalidMemberRole`; removed or unknown member → `memberNotFound`; non-owner → `permissionDenied`; the member's permissions follow the new role (a new site manager can propose).
- App: router (`redirectFor` with `/` as home; `go('/projects/1/members')` builds the list, project and members pages; popping returns to the project page); `ReloadOnReturn` (called when the page above is popped, not on first show); `EditSiteBloc` (load prefills radius and address, radius clamp, save success and each failure); `EditSitePage` (prefilled, Save sends radius and address); overview site section (owner with a site: Propose new location and Edit site; site manager: Propose new location only; viewer: neither); `MembersBloc.changeRole` (updates the row, failure keeps it); `MembersPage` (Change role only for the owner and not on the owner's row; picking a role sends it); repositories and API providers.

### You run (one batch, after Claude writes the code)
`serverpod generate` (server; no migration needed), `flutter gen-l10n`, `dart run build_runner build --delete-conflicting-outputs`, `dart format .` (both packages), `dart analyze`. Then Claude runs both test suites, and you check on the emulator: Back from members → project → list → app closes; owner moves and edits the site; owner changes a role.

### Group H outcome (2026-10-08)
Done as planned (H-1 to H-6). `dart test` **224/224** (new: 13 site edit and 9 role change cases), `flutter test` **443/443** (new: route tree, `ReloadOnReturn`, `EditSiteBloc`, `EditSitePage`, owner site buttons, role change in `MembersBloc` and `MembersPage`, repositories). Seen red first: every new test failed to compile until the code existed.

Notes:
- `serverpod start` regenerated the client while the server edits were half done, and the client lost the `site` and `membership` endpoints until the developer ran `serverpod generate`. When `serverpod start` runs, server edits should be complete before saving, or generation fixed afterwards.
- The role change bloc test compares roles, not whole states: Serverpod's `MemberView` and `ProjectMember` have no value equality.

Checked by the developer on the Android emulator (2026-10-08), no issues: Back from members → project → list → app closes; the owner moves the site (new reading) and edits its radius and address; the owner changes a role; a new project shows in the list after going back.
