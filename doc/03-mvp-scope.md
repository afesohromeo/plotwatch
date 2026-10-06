# MVP Scope: Serverpod 4 Hackathon Build

> **Status:** Draft v0.1, awaiting review
> **Date:** 2026-10-03
> **Source:** A subset of [02-requirements-specification.md](02-requirements-specification.md). Requirement IDs refer to that document.
> **Product name:** **Plotwatch** (chosen 2026-10-04).

---

## 1. MVP goal

> **A funder can set up a remote construction project, invite a site manager, receive verified photo evidence for each stage in real time, approve or reject each stage, and see exactly where every unit of money went.**

The MVP must show one complete, working loop on real devices, deployed on Serverpod Cloud:

```
Funder creates project + site + stages
        ↓
Funder invites site manager (code/link)
        ↓
Site manager captures verified photos per checklist item  ──► funder sees them live (badge + checks)
        ↓
Site manager submits stage
        ↓
Funder reviews → approves (or requests changes)
        ↓
Funder records fund release; site manager records expenses with receipts
        ↓
Ledger shows budget / released / spent / unaccounted, live for both sides
```

---

## 2. Timeline

| Item | Date |
|------|------|
| Today (documentation) | Sat 2026-10-03 |
| Hackathon deadline | **14 October 2026, 23:59 CEST**, no extensions ([Official Rules](https://tinyurl.com/SP-rules) §1, confirmed 2026-10-04) |
| **Our target submission** | **Tue 2026-10-13**, one day of buffer |

### 2.1 Day-by-day plan (proposal)
| Day | Date | Focus | Output |
|-----|------|-------|--------|
| D0 | Sat 10-03 | Documentation | Overview, requirements, MVP scope, context docs |
| D1 | Sun 10-04 | Review and approve docs; settle open decisions (§7); write implementation plan; install tooling (Serverpod CLI, Docker) | Approved docs, `doc/04-implementation-plan.md` |
| D2 | Mon 10-05 | Create Serverpod project; deploy a "hello" build to Serverpod Cloud; auth (email); app skeleton (routing, theme, l10n, architecture) | Running backend in the cloud; sign up/in works |
| D3 | Tue 10-06 | Projects + site (map pin / Plus Code + radius) + membership/invitations | Funder creates project and invites; site manager joins |
| D4 | Wed 10-07 | Stages, templates, checklists; stage list/detail | Stage plan from template, editable |
| D5 | Thu 10-08 | **Verified capture**: camera, GPS, hash, commit → upload → finalize, verification checks, badge UI | Verified photo attached to checklist item |
| D6 | Fri 10-09 | Stage submit/review flow; activity feed stream; in-app notifications stream | Live review loop between two devices |
| D7 | Sat 10-10 | Ledger: releases, expenses with receipts, summary; funder dashboard; site manager home | Full money loop |
| D8 | Sun 10-11 | Should-haves: evidence requests (+ deadline future call), fund requests, comments; French pass | Spot-check demo works |
| D9 | Mon 10-12 | Hardening: integration test of the core flow, bug fixes, seed demo data, final deploy. Stretch goals only if green. **Feature freeze at end of day.** | Release build (APK + web) |
| D10 | Tue 10-13 | Demo video, project description, README, screenshots, **submit**, social post | Submission done |
| — | Wed 10-14 | Buffer (only if the deadline allows) | — |

Each day starts by checking the plan and ends with: tests passing, code committed, and the deployed build updated.

---

## 3. In scope

### 3.1 Must have (`MVP`)
| Area | Requirement IDs | Summary |
|------|-----------------|---------|
| Auth | AUTH-01, 02, 03, 07, 08 | Email sign-up/in, verification, reset, persistent session, sign-out |
| Profile | PROF-01, 02, 03 | Name, country, language (EN/FR), edit profile |
| Projects | PROJ-01, 02, 03, 04, 05, 08 | Create (wizard), list, edit, status |
| Site | SITE-03, 04, 06, 07 | Site manager localizes with GPS on the plot, owner validates and sets the radius; address; changes logged (revised 2026-10-06, `04b` M2-15) |
| Members | MEMB-01, 02, 03, 04, 05, 08 | Invitation code/link, join, member list, remove, cancel |
| Stages | STG-01 → 09 | Create/edit/reorder, templates, checklist, statuses, submit, progress |
| Budget | BUD-01, 02 | Stage budgets, minor units + currency code |
| Capture | CAP-01 → 09 | In-app camera only, GPS overlay, metadata, hash, commit/upload/finalize, attach to stage/item, immutable |
| Verification | VER-01, 02, 03, 04, 10 | Checks V1–V8, level, explained badge, hash mismatch rejection, "where and when, not quality" notice |
| Updates | UPD-01, 02 | Progress update with captures, live in feed |
| Review | REV-01 → 05 | Submit → approve / request changes, permanent history |
| Ledger | LED-01, 03, 04, 06 | Record releases and expenses (with receipt capture), summary, reversals |
| Feed | FEED-01, 02, 03, 05 | Activity feed via Serverpod streaming, reconnect + catch-up |
| Notifications | NOT-01, NOT-02 *(core subset)* | In-app notification centre streamed live. Triggers: stage submitted, stage reviewed, release recorded, member joined |
| Dashboards | DASH-01, 02 | Funder dashboard; site manager home |
| Localization | L10N-01, 02, 03 | EN + FR, locale formatting, translated error codes |
| Audit | AUD-01 | Append-only audit log for financial and security actions |
| Non-functional | NFR-SEC-01→06, NFR-INT-01→04, NFR-PERF-01→04, NFR-REL-01→03, NFR-UX-01/02/03/05, NFR-MNT-01→05, NFR-SCL-03, NFR-PRV-01, NFR-DEP-01→03 | See requirements doc §5 |

### 3.2 Should have (`MVP-S`), planned but cut first
| Area | Requirement IDs | Why it matters |
|------|-----------------|----------------|
| Evidence requests (spot checks) | REQ-01 → 04, check V9 | **Strongest demo moment** and main differentiator; uses Serverpod future calls |
| Fund requests | FREQ-01 → 04 | Completes the money loop from the site manager's side |
| Comments | COM-01, 02 | Conversation on evidence and stages |
| Release confirmation | LED-02 | Site manager confirms receipt of money |
| Unaccounted alert | LED-05 | Makes the key number visible |
| Google sign-in | AUTH-04 | Faster onboarding |
| Schedule status | STG-10 | On time / late |
| Inactivity reminder | UPD-05 | Second future call |
| Review → release shortcut | REV-06 | Smooth flow in the demo |
| Hash chain | VER-05 | Tamper-evident history (strong technical story) |
| Upload timeout job | `UploadTimeoutCall` | Cleans up abandoned commits |
| Privacy policy | NFR-PRV-02 | Needed before sharing builds publicly |

### 3.3 Stretch (`MVP-X`), only if everything above is done and stable
| Area | Requirement IDs |
|------|-----------------|
| Public verification page | PUB-01, 04, 05, NFR-PRV-04 |
| Offline capture queue | CAP-10, OFF-01 → 03, NFR-SEC-08 |
| Server signatures | VER-06 |

### 3.4 Order in which features get cut if time runs short
1. Stretch items (§3.3)
2. Comments → Google sign-in → schedule status → inactivity reminder
3. Fund requests → release confirmation
4. Hash chain
5. Evidence requests (**last** to cut, because of their demo value)

---

## 4. Out of scope for the MVP
Everything marked `P1`–`P4` in the requirements specification, notably:
- Real payments, escrow, contracts, disputes (P3)
- Push notifications, email notifications, SMS (P1/P2). The MVP uses in-app notifications only.
- Phone/OTP and Apple sign-in (P1)
- Video and audio capture, compass, resumable uploads (P1)
- Duplicate photo detection, device attestation, C2PA (P1/P2)
- Inspectors, AI features, organizations, maintenance phase (P2/P4)
- Documents vault, PDF reports, exports, budget lines, materials (P1/P2)
- Admin panel (P1)
- Store releases (P1). The MVP is distributed as an APK plus a web build.

---

## 5. MVP architecture subset

### 5.1 Entities
`UserProfile`, `Project`, `Site`, `ProjectMember`, `Invitation`, `StageTemplate`, `StageTemplateItem`, `Stage`, `ChecklistItem`, `Evidence`, `ProgressUpdate`, `StageReview`, `FundRelease`, `Expense`, `ActivityEvent`, `Notification`, `AuditLog`.
*Should-haves add:* `EvidenceRequest`, `FundRequest`, `Comment`. *Stretch adds:* `ShareLink`.

### 5.2 Endpoints
Auth module, `ProfileEndpoint`, `ProjectEndpoint`, `SiteEndpoint`, `MembershipEndpoint`, `TemplateEndpoint`, `StageEndpoint`, `EvidenceEndpoint`, `UpdateEndpoint`, `LedgerEndpoint`, `ActivityEndpoint` (stream), `NotificationEndpoint` (stream).
*Should-haves add:* `EvidenceRequestEndpoint`, `FundRequestEndpoint`, `CommentEndpoint`.

### 5.3 Scheduled jobs
*Should-haves:* `EvidenceRequestDeadlineCall`, `InactivityReminderCall`, `UploadTimeoutCall`. Invitation expiry is checked when an invitation is accepted (no job needed).

### 5.4 Screens
| Role | Screens |
|------|---------|
| Everyone | Welcome, Sign in, Sign up, Verify email, Forgot password, Project list, Join with code, Notifications, Profile/Settings, Activity feed, Evidence detail + verification breakdown, Stage list, Stage detail, Ledger summary |
| Funder | Create project wizard (Details → Stages → Review), Validate site, Members & invite, Edit stage, Stage review, Record release, Funder dashboard, *(S)* New evidence request, *(S)* Fund request decision |
| Site manager | Site manager home, Localize site, Camera, Capture review, New progress update, Record expense, *(S)* Fulfil evidence request, *(S)* New fund request |

### 5.5 Platform targets
- **Android:** site manager and funder (main demo device)
- **Web:** funder (proves cross-platform; no capture on web)
- **iOS:** builds from the same code, but isn't tested for the hackathon unless a Mac is available

---

## 6. Acceptance criteria (core loop)

**AC-1 Project setup**
- Given a signed-in user, when they complete the wizard with name, currency and a template, then a `draft` project exists with them as `owner` and the template's stages and checklist items.
- Given a site manager of that project standing on the plot with a GPS accuracy of 20 m or better, when they localize the site, then the owner sees the proposal on a map. When the owner sets the radius and validates it, the project becomes `active` with that site. *(Revised 2026-10-06, `04b` M2-15: the site comes from the site manager's GPS, not the owner's map pin or Plus Code.)*

**AC-2 Invitation**
- Given an owner, when they create a site-manager invitation, then a code and link are shown. When another signed-in user enters the code, they join as `site_manager`. Using the code again fails with a clear message, and so does an expired code.

**AC-3 Verified capture**
- Given a site manager inside the site radius with good GPS, when they capture a photo for a checklist item, then within a few seconds the capture appears on the funder's device (without refreshing) with a **Verified** badge, and the breakdown lists each passed check.
- Given a site manager **outside** the radius, the capture is accepted but marked **Unverified**, with the reason "Taken X m from the site; allowed: Y m".
- Given a file whose bytes don't match the committed hash, finalize marks it **Unverified** (`hash_mismatch`). Covered by a server test.
- The gallery can't be used as a source anywhere in the app.

**AC-4 Stage review**
- Given a stage whose required items all have captures, when the site manager submits, then approvers get an in-app notification immediately. When an approver requests changes with a comment, the stage returns to the site manager with the comment. When they resubmit and the approver approves, the stage shows **Approved** and overall progress increases.
- A site manager can't approve; a viewer can't submit. Covered by server permission tests.

**AC-5 Ledger**
- Given an approved stage, when the funder records a release of 500,000 for the next stage and the site manager records expenses of 300,000 (with receipts) and 50,000 (without receipt), then the summary shows released 500,000, spent 350,000, spent with receipt 300,000, unaccounted 200,000, on both devices, live.
- Ledger entries can't be edited; a reversal entry corrects a mistake.

**AC-6 Real-time and resilience**
- If a device loses its connection and reconnects, the feed catches up on missed events without duplicates.

**AC-7 Localization**
- Switching the language to French translates every screen in the core loop, including error messages and formatted dates/amounts.

**AC-8 (Should) Evidence request**
- Given a funder creates a request with a 30-minute deadline, the site manager sees it live. A capture taken after the request was created fulfils it, and the funder sees **Fulfilled on time**. If nobody responds, the request becomes **Expired** at the deadline (future call) and the funder is notified.

---

## 7. Decisions to confirm before implementation
These were proposed during brainstorming and are **not yet approved**:

| # | Decision | Proposal | Status |
|---|----------|----------|--------|
| D-1 | Project location | `C:\New_folder\plotwatch` (renamed from `remote_build_oversight` on 2026-10-04) | ✅ Created |
| D-2 | Product name | **Plotwatch.** Dart packages: `plotwatch_server`, `plotwatch_client`, `plotwatch_flutter`. Trademark/domain check before public launch (plotwatch.ai is used by an unrelated real-estate tool). | ✅ Approved 2026-10-04 |
| D-3 | Roles in MVP | Owner, co-funder (approval rights optional), viewer, site manager; inspector in P2 | ✅ Approved 2026-10-03 |
| D-4 | Platforms | One Flutter codebase → mobile app (Android, iOS) for site managers and funders; web app for funders/co-funders/viewers (no capture on web). Hackathon: Android + web tested, iOS only if a Mac is available. See [overview §6.1](01-project-overview.md#61-platforms) | ✅ Approved 2026-10-03 |
| D-5 | Payments | Record-keeping only, no real money movement. The funder pays outside the app and logs it (amount, method, reference, optional proof); the site manager confirms receipt. Real payments/escrow stay in Phase 3. | ✅ Approved 2026-10-03 |
| D-6 | Verification level for MVP | In-app camera only; GPS inside site boundary + accuracy; mock-location detection (Android); server timestamp via commit; hash match on upload. Badges: Verified / Partially verified / Unverified with explained checks. Duplicate detection P1; attestation/C2PA P2. | ✅ Approved 2026-10-03 |
| D-7 | Auth | Email + password with verification and reset (Google sign-in as Should); join projects by invitation code/link. Phone/OTP stays in P1, to be reprioritized after user feedback. | ✅ Approved 2026-10-03 |
| D-8 | Languages | English + French from day one, with locale formatting of dates, numbers and money | ✅ Approved 2026-10-03 |
| D-9 | Currency | One per project, chosen at creation; second-currency display in P2 | ✅ Approved 2026-10-03 |
| D-10 | State management & client architecture | flutter_bloc (BLoC pattern) with Clean Architecture, as required by the developer's binding standards in [`_standards/`](../_standards/README.md) | ✅ Settled by `_standards/` 2026-10-03 |
| D-12 | Applying `_standards/` to Serverpod | Generated models vs Freezed, exceptions, pagination, server-side conventions (requirements Q10) → `_standards/14_serverpod_adaptation.md` | ✅ Approved 2026-10-03, all four parts: (a) generated models used directly; (b) `AppException` error codes → standard exception names; (c) page model per list → client `PaginatedList<T>`, last-item-ID keys for feed/notifications; (d) server conventions. Written up in [`_standards/14_serverpod_adaptation.md`](../_standards/14_serverpod_adaptation.md) |
| D-11 | Maps provider | Google Maps (`google_maps_flutter`), already used in PlusLocate with `geolocator` + `open_location_code`. Needs an API key with billing enabled; mobile maps free, web billed beyond a free monthly allowance. OpenStreetMap to reconsider after the hackathon if costs grow. | ✅ Approved 2026-10-03 |

---

## 8. Definition of done (per feature)
- [ ] Planned in `doc/` and approved before coding
- [ ] Tests written first (TDD): server endpoint tests, BLoC (`bloc_test`) and repository unit tests, widget tests for new screens
- [ ] Follows [`_standards/`](../_standards/README.md): layers, BLoC patterns, naming, `ResponsiveScaffoldWrapper`, routing, no hardcoded text, and every RULE-* in `09_normalization_rules.md` (with the Serverpod adaptation, D-12)
- [ ] `dart analyze` clean; all tests pass
- [ ] Permissions enforced on the server and covered by tests
- [ ] EN + FR strings added
- [ ] Works on Android (and web for funder screens)
- [ ] Deployed to Serverpod Cloud
- [ ] Committed with a clear message

---

## 9. Hackathon submission checklist
*Requirements from the [Official Rules](https://tinyurl.com/SP-rules) §4 (read 2026-10-04).*
- [ ] Working project (Flutter + Serverpod), deployed
- [ ] Demo video **under 2 minutes** (judges needn't watch beyond 2:00), **public on YouTube or Vimeo**, showing the app on its target devices; no copyrighted music or third-party trademarks without permission
- [ ] Project description: features, functionality and how it was built, **including disclosure of the AI tools used** (Claude Code, Stitch)
- [ ] **Build and run instructions** (README)
- [ ] **Testing access** (deployed web URL + APK + demo login credentials), free and unrestricted for the sponsor, administrator and judges **until judging ends (20 Oct 2026, 17:00 CEST)**. Keep the Serverpod Cloud deployment running until then.
- [ ] Repository link with all source, assets and instructions: make the repo **public** before submitting (secret scan first). If it stays private, share it with viktor@serverpod.dev, alexander@serverpod.dev and isak@serverpod.dev.
- [ ] All materials in English
- [ ] Submitted on BuilderBase before **14 Oct 2026, 23:59 CEST**
- [ ] *(Bonus, Best Hackathon Post: $500 credits)* Public post during the hackathon, clearly identifying it and showing real work (LinkedIn: Serverpod, X: @ServerpodDev, Bluesky: @serverpod.dev)
- [ ] *(Most Valuable Feedback: $500 + $500 credits)* Feedback form with actionable comments on the Serverpod SDKs, App Studio or docs, drawn from [`serverpod-feedback.md`](serverpod-feedback.md)
- [ ] Joined the Serverpod Discord

### 9.1 Demo video outline (< 2:00, draft)
| Time | Scene |
|------|-------|
| 0:00–0:15 | **The problem:** "You send money home to build a house. You get photos on WhatsApp. Are they real?" One headline from the research. |
| 0:15–0:35 | **Setup:** the funder (web/phone) creates a project, sets the site by Plus Code, applies a template, invites the site manager. |
| 0:35–1:10 | **Verified capture:** the site manager on site captures a photo, which appears live on the funder's screen with a ✅ Verified badge. Then a photo taken *outside* the plot shows ❌ Unverified, with the reason. |
| 1:10–1:30 | **Spot check:** the funder sends "show me the north wall now"; the site manager responds; "Fulfilled on time". |
| 1:30–1:50 | **Review + money:** the stage is submitted, approved, the release recorded, expenses with receipts; the ledger shows the unaccounted amount. |
| 1:50–1:59 | **How it's built + vision:** one architecture frame (streaming, future calls, ORM, file uploads, Serverpod Cloud) and the roadmap (inspectors, escrow, maintenance history). |

---

## 10. MVP risks
| Risk | Impact | Mitigation |
|------|--------|------------|
| Serverpod 4 is new and its APIs differ from older docs | Slows the backend | Do the official quickstart on D1; check every API against current docs; keep the scope of each endpoint small |
| GPS indoors or with weak signal during the demo | Captures marked unverified at the wrong moment | Record the demo outdoors; set a reasonable radius; show "partially verified" as a feature, not a failure |
| Camera/GPS plugin issues on specific Android versions | Capture broken | Test on the real device on D5, not later |
| Real-time streaming edge cases | Missing or duplicate events | Catch-up by last event ID; integration test AC-6 |
| Scope creep | Missed deadline | The cut order in §3.4; feature freeze D9 |
| Working alone, little time | Fatigue, bugs | Daily goals, TDD, commit often, buffer day |
