# M2: Projects, site, membership (detailed plan)

> **Status:** **approved 2026-10-06** by the developer, all decisions M2-1 to M2-14 as written (including moving SITE-06 to P1).
> **Master plan:** [04 §4 M2](04-implementation-plan.md#m2-projects-site-membership-d3). **Requirements:** PROJ-01–05, 08; SITE-01, 02, 03, 06, 07; MEMB-01–05, 08; AUD-01 ([02 §4](02-requirements-specification.md)). **Permissions:** [02 §3.2](02-requirements-specification.md#32-permission-matrix). **Acceptance:** AC-2, the project-and-site part of AC-1 ([03 §6](03-mvp-scope.md#6-acceptance-criteria-core-loop)).
> Facts about Serverpod were checked in the installed 4.0.3 sources and skills: model relations, `Map<String, String>` fields, `unique(per=…)` indexes, and the template's `config.json` route (built from the server's public URL, so it is correct on Cloud).

**Goal:** a funder creates a project with a site and invites a site manager, who joins. The permission matrix is in place for every later milestone.

**Schedule note:** today (D3) is M2's day, but M1's Cloud checks are still open. We're about half a day behind. Proposal: server groups A–C today, app groups D–F on D4 morning, and the half day is recovered from the D8 should-have day (cut order of [03 §3.4](03-mvp-scope.md#34-order-in-which-features-get-cut-if-time-runs-short) unchanged).

---

## Decisions in this draft
| # | Decision | Proposal |
|---|----------|----------|
| M2-1 | **Groups and order** | **A** server foundation (models, `PermissionService`, `AuditService`, `ActivityService`, `GeoService`), **B** `ProjectEndpoint` + `SiteEndpoint`, **C** `MembershipEndpoint`, **D** app: project list, create wizard (Details → Site → Review) and project overview, **E** app: site picker (Google Maps, Plus Code, radius), **F** app: members, invite, join, `/join/:code`. Same TDD batching as M1-9: tests first, then one generator batch per group. |
| M2-2 | **Owner** | The owner is the `ProjectMember` row with role `owner`; no separate `ownerId` column on `Project` (one source of truth). `02` §7.2's `ownerId` is read that way. Users are referenced by the auth user ID (`UuidValue`), as decided in M1-1. |
| M2-3 | **Creation in one request** | The wizard sends details and site together: `project.create` creates project, site, owner membership, audit entry and activity event **in one transaction**. No half-created project can exist (the lesson of the sign-up bug). |
| M2-4 | **Project status** | A finished wizard creates the project as **`active`**. Allowed transitions: `active ↔ paused`, `active / paused → completed`, `completed → archived`. `draft` stays in the enum for P1 ("save the wizard and finish later"). Read-only archived projects are PROJ-06 (P1), not enforced in M2. |
| M2-5 | **Permission design** | A server-only Dart enum `ProjectAction` with **one value per row of `02` §3.2** (also the rows used from M3 on). `PermissionService.require(session, projectId, action)` returns the caller's active `ProjectMember` or throws. **A non-member gets `projectNotFound`, the same as a missing project** (it doesn't reveal that a project exists). A member without the right gets `permissionDenied`. A removed member is a non-member (MEMB-08; streams follow in M5). |
| M2-6 | **Invitation code** | 8 characters from an alphabet without look-alikes (`23456789ABCDEFGHJKMNPQRSTUVWXYZ`, about 8.5 × 10¹¹ codes), made with `Random.secure()`, shown as `ABCD-EFGH`. Input is normalised (upper case, spaces and hyphens removed). Unique index; a new code is drawn on collision. Expires after **7 days**; single use (accepting changes `pending → accepted` in a transaction). The owner role can't be invited. |
| M2-7 | **Co-funder approval rights** | The owner chooses `canApprove` when inviting a co-funder (default off). Changing it later is MEMB-07 (P1). |
| M2-8 | **Link and deep link** | The link is `https://plotwatch.serverpod.space/join/ABCDEFGH`. It opens the web app's `/join/:code` route. A signed-out user goes through sign-in or sign-up first and comes back to the join screen (MEMB-03). **Android App Links** (the link opening the installed app) need `assetlinks.json` and the release signing fingerprint: moved to M8. On Android the user types or pastes the code. |
| M2-9 | **Site** | `site.set(projectId, lat, lng, radiusM, addressText)`; radius 10–500 m, default 50. The server computes the Plus Code from the coordinates (`GeoService`). In the picker the owner drops a pin, or enters a Plus Code that the **app** decodes; a short code is recovered relative to the visible map centre, **with no geocoding API** (no extra billing). Every change writes an audit entry (before/after) and an activity event (SITE-07). |
| M2-10 | **Site time zone (SITE-06)** | **Moved to P1** (a scope change, so it needs your approval). The column stays nullable; no UI. Choosing a time zone well needs a zone database or a lookup service; the MVP shows times in the viewer's zone. |
| M2-11 | **Maps keys** | **Android:** key in a gitignored `plotwatch_flutter/android/secrets.properties`, read by Gradle into a manifest placeholder. **Web:** key stored as a Cloud password `googleMapsWebKey` (locally in `config/passwords.yaml`), added to the server's `config.json` as `mapsApiKey`; the app loads the Maps script with it before the first map opens. The key is never committed. |
| M2-12 | **Project list** | `ProjectSummary` (project, my role, progress) in a `ProjectSummaryPage`, page numbers per `_standards/14` §3.1, newest activity first (`updatedAt` desc, then `id` desc). Progress is 0 until M3 adds stages. The signed-in home page becomes this list. |
| M2-13 | **Currency** | ISO 4217 codes from a fixed list of constants on the server (as `ProfileService.supportedLocales`), mirrored in the app's picker (like `supportedLanguageCodes`). "Currency locked once money is recorded" (PROJ-04) is enforced in M6, when the ledger exists. |
| M2-14 | **New packages** | App: `google_maps_flutter`, `open_location_code`, `geolocator` ("centre on my position" in the picker, needed in M4 anyway), `share_plus` (share the invitation). Server: `open_location_code` (pure Dart). You add them with `flutter pub add` / `dart pub add`. |

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
- `geo_service_test` (unit): haversine: 0 m for the same point, one degree on a meridian and on the equator ≈ 111,195 m, 50 m north = 50 m, the short way across the antimeridian; the Plus Code of a site centre is its 10-digit code. Decoding and recovering short codes happen in the app (M2-9), so they're tested in group E.

## Group B: projects and site (Claude, TDD)
**Files:** `endpoints/project_endpoint.dart`, `endpoints/site_endpoint.dart`, `services/project_service.dart`, `services/site_service.dart`, models `project_details.spy.yaml` (input), `site_input.spy.yaml` (input), `project_summary.spy.yaml`, `project_summary_page.spy.yaml`, `project_overview.spy.yaml` (project + site + my role); tests `test/integration/project_endpoint_test.dart`, `site_endpoint_test.dart`.

**Endpoints**
| Method | Who | Does |
|--------|-----|------|
| `project.create(ProjectDetails details, SiteInput site)` | any signed-in user | M2-3: one transaction; returns `ProjectOverview` |
| `project.list({page, pageSize})` | signed-in | the caller's active memberships only |
| `project.get(projectId)` | member | `ProjectOverview` |
| `project.update(projectId, ProjectDetails)` | owner | audit (before/after) + activity |
| `project.setStatus(projectId, ProjectStatus)` | owner | M2-4 transitions; audit + activity |
| `site.get(projectId)` | member | |
| `site.set(projectId, SiteInput)` | owner | M2-9; audit (before/after) + activity |

**Tests first** (each: happy path, every permission rule, every error code)
- create: the caller becomes `owner`; project, site and membership exist; Plus Code computed; one audit entry and one `projectCreated` event; invalid name/currency/dates/radius/location → its code and **nothing is created**; unauthenticated → refused.
- list: only the caller's projects, with their role; removed membership not listed; pagination (page 0/1, page size).
- get: member OK; non-member → `projectNotFound`.
- update / setStatus / site.set: owner OK; co-funder, viewer, site manager → `permissionDenied`; each allowed and refused status transition; site change audited with before/after and announced as `siteChanged`.

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

**You run** after groups A–C (one batch): `dart pub add open_location_code` in `plotwatch_server`, `serverpod generate`, `serverpod create-migration`, `dart format`, `dart analyze`. Then Claude runs `dart test`, and you deploy (`serverpod cloud deploy`; Cloud applies the migration).

## Group D: app, projects (Claude, TDD)
**Files:** `data/api/project/project_api_provider.dart`, `domain/repository/project_repository.dart`, features `projects/` (`ProjectListBloc` with `infinite_scroll_pagination` per `_standards/13`, `CreateProjectBloc` for the wizard, `ProjectOverviewBloc`), pages `ProjectListPage` (replaces the home placeholder), `CreateProjectPage` (steps Details → Site → Review; the Stages step is added in M3), `ProjectOverviewPage` (details, status, site summary, members button, owner actions: edit, change status), `EditProjectPage`. Localized labels for project type, status and role (`_standards/14` §1.3). Routes: `projects`, `projects/new`, `projects/:id`, `projects/:id/edit`.

**Tests first:** repository (page → `PaginatedList`, errors rethrown); each BLoC's handlers (success and every failure type, RULE-009 order); widget tests: list states (loading, empty, error, items with role chip), wizard step validation and Review sending one `create`, overview shows owner actions only to the owner.

## Group E: app, site picker (Claude, TDD)
**Files:** `data/device/location_provider.dart` (geolocator), `features/site/` (`SitePickerBloc`, `SitePickerView` used by the wizard's Site step and by `EditSitePage`), web Maps loader (`core/maps_loader.dart`, reads `mapsApiKey` from `config.json`), Android manifest placeholder.

- Pin: tap the map to move the centre; the radius is drawn as a circle; slider 10–500 m.
- Plus Code field: full code, or short code recovered near the map centre; invalid → field message.
- "Centre on my position" button (permission asked only when tapped).

**Tests first:** `SitePickerBloc` (pin moved, radius limits, Plus Code full/short/invalid, position permission denied); widget test with the map replaced by a test double (the Google map can't render in widget tests), so the controls, the Plus Code field and the circle state are tested.

**You'll need:** a Google Cloud project with **Maps SDK for Android** and **Maps JavaScript API** enabled, a budget alert, and two keys: Android (restricted to `com.afesohromeo.plotwatch` + your debug SHA-1) and web (restricted to `localhost` and `plotwatch.serverpod.space`). Then `serverpod cloud password set googleMapsWebKey <key>`.

## Group F: app, members and join (Claude, TDD)
**Files:** `data/api/membership/…`, `domain/repository/membership_repository.dart`, features `members/` (`MembersBloc`: list, remove, pending invitations, cancel; `InvitationBloc`: create, share), `join/` (`JoinProjectBloc`: preview, accept), pages `MembersPage`, `InviteSheet` (role, `canApprove` for co-funders, then code + link + share), `JoinProjectPage` (code field, preview, Join). Route `/join/:code` (deep link, M2-8); the auth guard keeps the target through sign-in and sign-up.

**Tests first:** BLoCs (each handler and failure); widget tests: members list with remove only for the owner, invite flow shows the formatted code, join with a code shows the preview then joins; router: signed-out `/join/X` → welcome, and after sign-in → `/join/X`.

**You run** after groups D–F: `flutter pub add google_maps_flutter open_location_code geolocator share_plus`, `build_runner`, `gen-l10n`, `dart format`, `dart analyze`; Claude runs `flutter test`; you deploy.

---

## Exit (M2)
On the deployed build, between two accounts (one in Chrome, one on Android):
1. Account 1 creates a project with a site (pin and Plus Code both tried) and sees it in the list as owner.
2. Account 1 invites a site manager; the code and link are shown and shared.
3. Account 2 joins with the code (Android) and through the link (web); both see the project with their role.
4. The code used again → "already used"; an expired code → "expired" (expiry is shortened only in the server test, not on Cloud).
5. Account 1 removes account 2, who loses access immediately.
6. All tests pass, CI is green, English and French complete.

---

## Outcomes

### Group A outcome (2026-10-06)
Done and verified: 12 models (tables `project`, `site`, `project_member`, `invitation`, `audit_log`, `activity_event`) in one migration, 14 error codes with EN + FR messages, `PermissionService` (full matrix of `02` §3.2) and `GeoService`. `dart test` **118/118** (the permission matrix alone is 91 cases), `flutter test` **202/202**.

Changes from the plan:
- **`ProjectType.expansion`** instead of `extension` (renamed by the developer: `extension` is a reserved word in Dart, so generation failed). The app's label can still read "Extension".
- `AuditService` and `ActivityService` move to group B, where tests first use them.
- The migration was created after group A instead of after group C: all M2 tables are in group A.
