# Plotwatch

**Fund a building you can't watch being built.**

Many people pay for a house, a family building or a community project far
from where they live: a nurse in Montreal building in Yaoundé, a family
abroad funding a village school. They send money in stages and have to trust
whatever the site tells them. Plotwatch replaces trust with evidence.

- **Verified site photos:**
  - taken only with the in-app camera (never the gallery);
  - each carries its GPS position, accuracy and time;
  - the server checks them against the site boundary, its own clock and the photo's SHA-256 hash, then shows a badge: **Verified**, **Partially verified** or **Unverified**, with every check explained.
- **Stage-by-stage approvals:**
  - the site manager submits a stage when its checklist is covered;
  - the funders approve it or request changes;
  - progress follows the approved budget.
- **A shared ledger:**
  - every release from the funders and every expense on site, with receipt photos;
  - entries are never edited (a mistake is reversed);
  - an alert shows money not yet backed by receipts.
- **Live:** captures, submissions, approvals and ledger entries appear on every member's device without refreshing, with in-app notifications.
- **Two languages:** English and French, including amounts in FCFA and dates.

Built with Flutter and [Serverpod 4](https://serverpod.dev) for *Build
Something Real: The Serverpod Hackathon* (2026).

---

## Try it
- **Web app:** <https://plotwatch.serverpod.space>
- **Android:** the APK attached to the submission.
- **Demo project:** "Afesoh Residence", a 5-storey building in Yaoundé, six weeks into the build. Sign in with one of these accounts; the password is in the submission notes.

  | Account | Role | What to try |
  |---|---|---|
  | `funder@demo.plotwatch.app` | Owner, abroad | Review the submitted ground floor; the Money tab and its unaccounted alert |
  | `manager@demo.plotwatch.app` | Site manager | Confirm the waiting release; post an update; capture a photo (on site only) |
  | `cofunder@demo.plotwatch.app` | Co-funder who approves | Approvals, the feed, notifications |

  Captures from a judge's own location come out **Unverified** (outside the Yaoundé site), which is the point.
- Or create your own account, with email or Google, and start a project.

## How Serverpod is used
- **Endpoints and generated models:**
  - every call goes through typed endpoints and `.spy.yaml` models: projects, membership, site, stages, evidence, ledger, updates, notifications, account;
  - errors are `AppException` codes the app translates;
  - permissions are checked on the server, per project role.
- **Streaming endpoints and server events:** the activity feed and notifications stream changes live (`session.messages` channels per project and per user), and they catch up after a reconnect.
- **File uploads:** photos and receipts upload straight to private cloud storage through upload descriptions, then the server verifies the file's hash before accepting it.
- **Authentication:**
  - email sign-up with a verification code, and Google sign-in (Android and web), from `serverpod_auth_idp`;
  - one account per email: a first Google sign-in with the email of an existing account is linked to it;
  - in-app account deletion.
- **Web server:**
  - it serves the Flutter web app, its `config.json` (API URL, public keys), the privacy policy at `/privacy` and Android App Links;
  - the web Google sign-in returns to the app's `auth.html`.
- **Serverpod Cloud** hosts the server, database and storage.
- **Tests:** over 400 server tests with `withServerpod` and an embedded PostgreSQL (no Docker). They include one test of the whole loop, from project creation to the ledger numbers, plus permission tests for every role.

## Run it locally
Requirements: Flutter 3.44+, Dart 3.12+ and the Serverpod CLI 4.0.3.

```powershell
cd plotwatch_server
serverpod start        # generates code, starts the server, the database and the Flutter app
```

- `config/passwords.yaml` (not in the repository) holds the local secrets.
- Google sign-in and maps need your own keys; see [`doc/04g`](doc/04g-m8-hardening.md) and [`doc/04b`](doc/04b-m2-projects-site-members.md).
- **Demo data:** set `demoSeed: 'true'` and `demoPassword: '...'` under `development:`.

**Tests:**
```powershell
cd plotwatch_server;  dart test       # server: endpoints, services, permissions
cd plotwatch_flutter; flutter test    # app: blocs, pages, over 950 tests
```

## Project structure
| Folder | What |
|---|---|
| `plotwatch_server/` | Serverpod server: endpoints, services, models, web routes, demo seed |
| `plotwatch_client/` | Generated client (never edited by hand) |
| `plotwatch_flutter/` | Flutter app: Clean Architecture with flutter_bloc, Android and web |
| `doc/` | Decisions, requirements, plans and their outcome; start with [`doc/00-project-context.md`](doc/00-project-context.md) |

## Roadmap
Planned after the hackathon:
- **Evidence requests:** a funder asks for a photo with a deadline.
- **Fund requests** from the site.
- **Comments** on stages and photos.
- **An inactivity reminder** when a site goes quiet.
- **Photos on progress updates.**
- **Proof files for releases.**
- **A public verification page** for a single photo.
- **An offline queue** for captures without a connection.
- **Ownership transfer**, so an owner can leave an open shared project.

## Privacy
The [privacy policy](https://plotwatch.serverpod.space/privacy) (English and
French) explains what is collected and how to delete an account. Source:
[`plotwatch_flutter/web/privacy.html`](plotwatch_flutter/web/privacy.html).

## Credits
- **Demo site photos:** generated with Google Gemini from [`plotwatch_server/seed/PROMPTS.md`](plotwatch_server/seed/PROMPTS.md).
- **Demo receipts:** drawn with Flutter.
- **Demo people:** fictional.
- **Details:** [`plotwatch_server/seed/CREDITS.md`](plotwatch_server/seed/CREDITS.md).

## Licence
Copyright © 2026 Afesoh Romeo. All rights reserved. No licence is granted to
copy, modify or distribute this code, except the licence granted to Serverpod
AB and BuilderBase Labs AB under §7 of the hackathon's Official Rules (use for
judging, testing, administering, and promoting and reporting on the
hackathon).
