# M4: Verified capture (detailed plan)

> **Status:** **approved 2026-10-08** by the developer, with option **(a)** for M4-4 (photos viewed through the server).
> **Master plan:** [04 §4 M4](04-implementation-plan.md#m4-verified-capture-d5), revised schedule D6–D7 (`04c` M3-12). **Requirements:** CAP-01–09, VER-01–04, VER-10 ([02 §4](02-requirements-specification.md)); the Evidence entity ([02 §7.2](02-requirements-specification.md)); checks V1–V8 and thresholds ([02 §8.2, §8.4](02-requirements-specification.md#8-verification-engine-detailed-design)); the capture flow ([02 §9.1](02-requirements-specification.md#91-verified-capture-online)); the upload lifecycle ([02 §10.4](02-requirements-specification.md#104-evidence-upload-lifecycle)). **Acceptance:** AC-3 ([03 §6](03-mvp-scope.md)).
> Facts about Serverpod were checked in the installed 4.0.3 sources and the `serverpod-file-uploads` skill: `session.storage.createUploadDescription` with `UploadOptions(maxFileSize, preventOverwrite, expirationDuration)`, `verifyUpload`, `retrieveFile`, `storeFile`; the template registers Serverpod Cloud storage (`private`, `public`) with a database fallback, and the database storage supports private temporary download URLs.

**Goal:** the site manager, standing on the plot, opens a stage's checklist item, takes a photo with the in-app camera while the screen shows the GPS accuracy and whether they are inside the site, and sends it. The server checks where and when the photo was taken and that the stored file is the one that was photographed, and gives it a badge with each check explained. The funder sees it on the stage (after a refresh until M5 makes it live).

---

## Decisions
| # | Decision | Proposal |
|---|----------|----------|
| M4-1 | **Groups and order** | **A** server: models, `VerificationService` (pure functions), `EvidenceService`, `EvidenceEndpoint`, checklist coverage. **B** app data and device: camera, device info and hashing providers, evidence API provider (with the upload) and repository, the check texts. **C** app capture flow: `CaptureBloc`, `CapturePage` (camera, GPS overlay, review, sending, result). **D** app evidence views: the stage page's items with their photos and a capture button, `EvidencePage` (photo, badge, breakdown, details, retract). |
| M4-2 | **What is hashed (Q6)** | **The exact bytes that are uploaded.** The camera takes the photo at a fixed size (`ResolutionPreset.veryHigh`, about 1920 × 1080, roughly 0.5–1.5 MB), so **no recompression**: the app reads the JPEG the camera wrote to its private cache, computes SHA-256, and uploads those bytes. The file never goes anywhere the user can change before hashing (CAP-04). The server stores it unchanged (CAP-07). Answers `02` §11 Q6. |
| M4-3 | **Upload flow** | As `02` §9.1: **commit** (hash and metadata; the server records its own time and answers with an evidence ID and an upload description), **upload** the bytes with `FileUploader`, **finalize** (the server reads the stored file, computes its SHA-256, makes the thumbnail, runs the checks). The upload description is limited to **10 MB**, can't overwrite (`preventOverwrite`, the stored photo never changes) and expires after 10 minutes; `evidence.uploadDescription` issues a new one while the capture is still `committed` (retry). |
| M4-4 | **Storage and viewing** | Photos go to the **`private`** storage, path `projects/<projectId>/evidence/<evidenceId>/photo.jpg` and `thumb.jpg`, never chosen by the client. **Viewing goes through the server**: `evidence.media(projectId, evidenceId, variant)` checks membership and returns the bytes (thumbnail about 30 KB, photo up to a few MB). This avoids signed URLs and their cross-origin rules on the web, and works the same with the database storage locally and Serverpod Cloud storage. The app keeps the bytes in memory while a page is open. Temporary download URLs can replace it later if traffic grows. **Needs your choice** (alternative: temporary download URLs, faster for the browser but with a cross-origin risk on the web that can only be checked on Cloud). |
| M4-5 | **Display copy and thumbnail (CAP-07)** | The photo itself is the display version (it is already about 1920 px). The server makes **one thumbnail** (400 px wide, JPEG) at finalize, with the pure-Dart `image` package. If the file can't be decoded, finalize still completes and the app shows a placeholder; the hash check doesn't depend on it. |
| M4-6 | **Checks (VER-01, `02` §8.2)** | V1 `in_app_capture` (the app attests; the web can't capture), V2 `location_present`, V3 `location_accuracy` (≤ 30 m, non-critical), V4 `inside_site` (distance ≤ radius + min(accuracy, 30 m)), V5 `not_mock_location`, V6 `hash_match`, V7 `clock_consistency` (≤ 10 min, non-critical), V8 `prompt_commit` (≤ 15 min, non-critical). Thresholds of `02` §8.4 as constants. Each check is a **pure function** with unit tests at its limits. Level: `verified` if all pass, `partially_verified` if only non-critical ones fail, `unverified` if a critical one fails (VER-02). A hash mismatch doesn't throw: the capture is finalized as `unverified` with V6 failed (VER-04). V9 (evidence requests) is out with M7; V10, V11 are P1/P2. |
| M4-7 | **No display text from the server** | Each check is stored as `{name, passed, critical, details}` where `details` holds numbers only (e.g. `distanceM`, `allowedM`, `accuracyM`, `skewSeconds`). The app writes the sentences in the user's language ("Taken 12 m from the site centre; allowed: 65 m") (`_standards/14` §2). |
| M4-8 | **Weak GPS doesn't block (`02` §8.1)** | A capture without a GPS fix, or with poor accuracy, **is accepted**: it is simply not verified (V2 or V4 fails). The camera screen shows the accuracy and inside/outside live, so the site manager knows before shooting. |
| M4-9 | **Who, where, when** | Only the **site manager** captures (`captureEvidence`), only on an **active** project (`projectNotActive`), only for a checklist item of a stage that is `not_started`, `in_progress` or `changes_requested` (`stageLocked` otherwise). The first capture on a `not_started` stage **starts it** (STG-06), with its audit entry and `stageStarted` event. Optional caption ≤ 500 characters (CAP-06). |
| M4-10 | **Coverage (STG-08)** | A checklist item is covered when it has at least one **finalized, not retracted** capture, whatever its level; the reviewer judges the badges in M5. `StageView.itemsCovered` becomes real; the stage page lists each item's captures. |
| M4-11 | **Retracting (CAP-09)** | The site manager who took a capture can retract it with a reason (1–500 characters); it stays visible as "Retracted: <reason>", stops counting for coverage, and the audit log keeps it. Nothing is ever deleted or edited. |
| M4-12 | **Stuck uploads (`02` §10.4)** | A capture still `committed` after 24 h is shown and returned as `upload_failed` (checked when it is read, no scheduled job). The site manager's phone keeps the photo until finalize succeeds and offers **Retry** while the app is open; after a restart the capture stays failed and the photo can be taken again. |
| M4-13 | **Out of M4** | Live appearance on the funder's screen (M5, streams); the hash chain VER-05 (MVP-S, 4th in the cut order); offline captures CAP-10 (MVP-X); iOS capture (no Mac to test; the code is the same, the camera permission text is added). The web shows captures but has no camera button (V1). |
| M4-15 | **Checklist items with photos** (found while writing group A) | Editing a stage deletes the checklist items left out (M3-5), but a photo points to its item. The server **refuses to remove an item that has captures** (`checklistItemHasEvidence`); its label can still be changed. In the database the photo refers to its stage and item with `onDelete=Restrict`, so nothing can remove them by accident. |
| M4-14 | **New packages** | App: `camera`, `crypto`, `device_info_plus`, `package_info_plus`. Server: `crypto`, `image`. Android: the `CAMERA` permission; iOS: `NSCameraUsageDescription`. |

**New error codes:** `evidenceNotFound`, `checklistItemNotFound`, `evidenceNotCommitted` (finalize or new upload description after finalize), `uploadMissing` (finalize before the upload), `evidenceFileTooLarge`, `invalidEvidenceMetadata` (hash not 64 hex characters, impossible coordinates, missing device time), `evidenceAlreadyRetracted`, `notYourCapture` (retracting someone else's capture), `checklistItemHasEvidence` (M4-15). EN + FR messages in the app.

---

## Group A: server (Claude, TDD)
**Models** (`plotwatch_server/lib/src/models/`): `evidence.spy.yaml` (table; fields of `02` §7.2 for the MVP: project, stage, checklist item, `capturedBy`, `status`, `sha256`, `photoPath`, `thumbPath`, `fileSizeBytes`, `deviceCapturedAt`, `serverCommittedAt`, `finalizedAt`, `lat`, `lng`, `accuracyM`, `altitudeM`, `isMockLocation`, `distanceFromSiteM`, `capturedInApp`, `deviceModel`, `osVersion`, `appVersion`, `verificationLevel`, `checks`, `caption`, `retractedAt`, `retractedReason`; indexes on project, stage and item), `evidence_status.spy.yaml` (`committed`, `finalized`, `uploadFailed`, `retracted`), `verification_level.spy.yaml` (`pending`, `verified`, `partiallyVerified`, `unverified`), `verification_check.spy.yaml` (`name`, `passed`, `critical`, `details: Map<String, String>?`), `verification_check_name.spy.yaml` (V1–V8), `evidence_commit.spy.yaml` (`immutable`, what the app sends), `evidence_commit_result.spy.yaml` (evidence, upload description), `media_variant.spy.yaml` (`photo`, `thumbnail`). New `ActivityType` values `evidenceCaptured`, `evidenceRetracted`; new `AppErrorCode` values. One migration (one table).

**Services and endpoint**
| Call | Who | Rules |
|------|-----|-------|
| `evidence.commit(projectId, commit)` | site manager | M4-9; validates the metadata; server time; may start the stage; returns the upload description (M4-3) |
| `evidence.uploadDescription(projectId, evidenceId)` | the capture's author | only while `committed` |
| `evidence.finalize(projectId, evidenceId)` | the capture's author | `verifyUpload`, read the file, size ≤ 10 MB, SHA-256, thumbnail, checks, level; one transaction for the database writes; audit + `evidenceCaptured` |
| `evidence.list(projectId, stageId)` | member | newest first, with checks; `committed` older than 24 h shown as `uploadFailed` (M4-12) |
| `evidence.get(projectId, evidenceId)` | member | |
| `evidence.media(projectId, evidenceId, variant)` | member | bytes of the photo or thumbnail (M4-4) |
| `evidence.retract(projectId, evidenceId, reason)` | the capture's author | M4-11; audit + `evidenceRetracted` |

`VerificationService`: one pure function per check plus `level(checks)`, unit tested. `StageService`: `itemsCovered` from finalized, non-retracted captures.

**Tests first**
- Unit `verification_service_test`: each check passing and failing at its limit (accuracy 30 / 30.1 m; inside-site with the accuracy buffer and its 30 m cap; clock skew 10 min / 10 min 1 s, both directions; commit delay 15 min / 15 min 1 s; mock flag; missing fix; hash equal / different / case-insensitive); the level rule (all pass, only non-critical failed, one critical failed).
- `evidence_endpoint_test`: the full flow on a validated site inside the radius gives `verified` with 8 passed checks; outside the radius gives `unverified` with the distance and the allowed distance in V4's details (AC-3); stored bytes different from the committed hash give `unverified` with V6 failed (AC-3, VER-04); finalize without upload gives `uploadMissing`; finalize twice gives `evidenceNotCommitted`; a 10 MB + 1 byte file gives `evidenceFileTooLarge`; owner, co-funder and viewer can't commit (`permissionDenied`), outsider `projectNotFound`; draft project `projectNotActive`; submitted stage `stageLocked`; an item of another stage `checklistItemNotFound`; the first capture starts a `not_started` stage; only the author finalizes and retracts (`notYourCapture`); retracting twice `evidenceAlreadyRetracted`; a retracted capture stops covering its item; a capture committed more than 24 h ago is listed as `uploadFailed`; `media` returns the stored bytes and the thumbnail to members only; every change writes one audit entry and one activity event.
- `permission_matrix_test` unchanged (`captureEvidence` already exists).

## Group B: app data and device (Claude, TDD)
**Files:** `data/device/camera_provider.dart` (the `camera` package: permission, back camera, `veryHigh` preset, take a picture → bytes from the app's cache), `data/device/device_info_provider.dart` (model, OS version, app version), `shared/utils/hashing.dart` (SHA-256 as lower-case hex), `data/api/evidence/evidence_api_provider.dart` (commit, upload with `FileUploader`, finalize, list, get, media, retract), `domain/repository/evidence_repository.dart` (`sendCapture`: commit → upload → finalize, reporting each step), `shared/extensions/verification_extensions.dart` (badge label and colour per level; the sentence of each check from its details, EN + FR).
**Tests first:** the hash of known bytes; the repository's send flow calls commit, upload and finalize in order, stops and reports at the failing step, and can retry from the upload; every check name has a pass and a fail sentence in EN and FR, with the numbers from its details; badge labels for every level.

## Group C: capture flow (Claude, TDD)
**Files:** `features/capture/` with `CaptureBloc` and `CapturePage`, route `stages/:stageId/capture/:itemId` (nested under the stage).
- Opens the camera (permission states like the localize screen: denied, denied for good, no camera) and the GPS stream (reusing `LocationProvider`).
- Overlay: accuracy, "Inside the site" / "Outside the site (≈ X m)" computed on the phone from the site centre and radius; it informs, the server decides.
- Shutter → review screen (the photo, optional caption, **Use photo** / **Retake**) → sending with the step shown (committing, uploading, checking) → result (badge and the checks) → back to the stage.
- On failure: the step and the message, **Retry** (re-upload if committed, finalize again if uploaded).
- The camera preview is injected as a builder so widget tests can replace it (as the map in G-8).
**Tests first:** `CaptureBloc` (permissions, GPS updates, shot taken, retake, send success, each step failing, retry from the failed step, the metadata sent: device time, position, accuracy, mock flag, device info, `capturedInApp: true`); `CapturePage` (overlay inside/outside, review, sending steps, result, retry; no camera on the web).

## Group D: evidence views (Claude, TDD)
**Files:** the stage page: each checklist item with its captures (thumbnails and badges, newest first) and, for the site manager on the phone, a **Capture** button; `features/evidence/` with `EvidenceBloc` and `EvidencePage` (the photo, the badge, the checks one by one, the details: device time, server time, position, accuracy, distance to the site, device; the notice "Verification proves where and when this photo was taken, not the quality of the work" (VER-10); **Retract** for its author with a reason), route `stages/:stageId/evidence/:evidenceId`; a small `EvidenceImage` widget that loads and caches the bytes.
**Tests first:** the stage page shows an item's captures and its coverage, the Capture button only for the site manager on mobile on an open stage; `EvidenceBloc` (load, media, retract, failures); `EvidencePage` (badge, each check's sentence, VER-10 notice, Retract only for the author and not twice, retracted capture shown as such).

## You'll need
- Android emulator: its camera shows a virtual scene and its GPS follows the virtual location (Extended controls), enough to test the flow inside and outside the site.
- For the M4 exit: **a real Android phone outdoors** (AC-3), with the debug build (`flutter run` against Cloud).

## You run
- After group A: `dart pub add crypto image` (server), `serverpod generate`, `serverpod create-migration`, `dart format .`, `dart analyze`; restart `serverpod start`. Claude runs `dart test`.
- After groups B–D: `flutter pub add camera crypto device_info_plus package_info_plus` (app), `flutter gen-l10n`, `dart run build_runner build --delete-conflicting-outputs`, `dart format .`, `dart analyze`; full rebuild of the Android app (new plugins). Claude runs `flutter test`; you check on the emulator and in Chrome.

## Exit (M4)
AC-3 on a **real Android phone outdoors**, with the funder watching on the web (refreshing until M5): a photo taken inside the radius with good GPS appears on the stage with a **Verified** badge and every check listed; a photo taken outside the radius is accepted and marked **Unverified** with "Taken X m from the site; allowed: Y m"; the hash mismatch case is covered by a server test; the gallery can't be used anywhere. All tests pass, CI green, English and French complete.

---

## Outcomes

### Group A outcome (2026-10-09)
Done as planned, with M4-15 added while writing it. `dart test` **331/331** (new: 31 verification checks at their limits and the level rule, 35 evidence endpoint cases including the three AC-3 cases). Seen red first: the new tests failed to compile until the models, the services and the endpoint existed. The app maps the 9 new error codes (EN + FR).

Notes:
- `withServerpod` registers the database storage (`public`, `private`), so the tests store the "uploaded" photo with `storeFile`. A file stored that way is already verified, and `verifyUpload` then returns false; finalize therefore accepts a file that is verified **or** already present, which also makes a repeated finalize after a failure safe.
- One run of the full suite timed out starting a test server for the email tests ("Serverpod did not start within 2 min"), while the development server was running; the file passed on its own. Watched for in the next runs.

### Groups B to D outcome (2026-10-09)
Done. `flutter test` **667/667** (new: hashing, check sentences EN + FR, evidence repository, `CaptureBloc` and `CapturePage`, `EvidenceMediaBloc`, `EvidenceBloc` and `EvidencePage`, the stage page's photos and capture button, routes, the signed-in user's ID); `dart analyze` clean. Seen red first: every new test failed to compile until the code existed.

Changes from the plan:
- The commit → upload → finalize chain lives in `CaptureBloc`, not in the repository: the repository keeps one method per step, so a retry repeats exactly the failed step and the repository stays thin (`_standards/09`). A retried upload asks for a new upload description.
- Photos are loaded by an `EvidenceMediaBloc` per page (the standards forbid repository calls from widgets); the `EvidenceImage` widget asks it.
- The evidence page knows the photo's author from the signed-in user's ID (`AuthRepository.currentUserId`, from the client session); the server still checks it.

Found by the tests and fixed: the badge overflowed in a photo tile (now 132 px wide, with the label shortened when needed); a test closed the bloc twice. Two test names had an apostrophe inside a single-quoted string (fixed after the developer's analysis).
