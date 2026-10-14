# Submission text (BuilderBase)

The project description as submitted, for the record. The demo password is
not repeated here: it is in the submission form only.

---

## Plotwatch: oversee your construction project from anywhere

**The problem.** Whoever pays for a build (a house, a family building, a
community project) can't be on site every day. They depend on what the site
tells them: photos sent by phone, verbal updates, receipts that may or may not
exist. They can't tell what has really been done, stage by stage, or where the
money went.

**What Plotwatch does.** It lets the owner oversee the project from anywhere,
with evidence they can trust:
- **Verified site photos.** The site manager takes every photo in the app's
  camera, on the plot (never from the gallery). The server checks where and
  when it was taken (inside the site's boundary, GPS accuracy, its own clock)
  and that the file wasn't changed (a hash). Each photo is marked **Verified**,
  **Partly verified** or **Unverified**, with every check explained.
- **Stage-by-stage approvals.** Each stage has a checklist of the photos it
  needs. The site manager submits it when it's covered; the owner (or a
  co-funder allowed to approve) is notified at once and approves it or sends
  it back with a comment. Progress follows the approved budget.
- **A shared ledger.** Every payment sent to the site and every expense paid
  from it is recorded, expenses with their receipt photos. Nothing is ever
  edited: a mistake is reversed. Everyone sees what was released, what was
  spent, and what is left.
- **Live and in two languages.** Photos, submissions, approvals and payments
  appear on every member's device without refreshing, with in-app
  notifications. English and French, with amounts in FCFA.

**How it's built.** Flutter (Android and web, Clean Architecture with BLoC)
and **Serverpod 4** on **Serverpod Cloud**:
- typed endpoints and generated models, with permissions checked on the
  server for every role (owner, co-funder, site manager, viewer);
- **streaming endpoints with server events** for the live feed and
  notifications, catching up after a reconnection;
- **file uploads** to private cloud storage, verified by hash before a photo
  is accepted; photo resizing on a separate isolate;
- **authentication** by email (with a verification code) and Google, one
  account per email, and in-app account deletion;
- **future calls** to seed the judges' demo project once, safely, after a
  rollout;
- the **web server** serving the Flutter web app, its config, the privacy
  policy and Android App Links;
- **over 430 server tests** with `withServerpod` on an embedded PostgreSQL,
  including one test of the whole loop, and over 950 app tests.

**Try it.**
- Web app: https://plotwatch.serverpod.space
- Demo project "Afesoh Residence", a 5-storey building in Yaoundé six weeks
  into the build. Accounts (password in the submission form):
  - `funder@demo.plotwatch.app`: the owner, who has a stage waiting for review;
  - `manager@demo.plotwatch.app`: the site manager;
  - `cofunder@demo.plotwatch.app`: a co-funder who approves.
- Or create your own account and project. A photo is only verified on the
  site's plot, so captures from elsewhere come out Unverified, by design.
- Privacy policy: https://plotwatch.serverpod.space/privacy

**Build and run.** See the README: `serverpod start` in `plotwatch_server`
runs the server, the database and the app; `dart test` and `flutter test`
run the tests.

**AI tools used.** Claude Code (Anthropic) wrote code, tests and
documentation with me; I decided the product, the design and every change,
and reviewed and tested the app. Google Gemini generated the demo project's
site photos and the demo video's voice-over. The demo receipts were drawn
with Flutter; the demo people and shops are fictional.
