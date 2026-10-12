# M8: Hardening, polish and Google sign-in (plan)

> **Status:** **approved 2026-10-12** by the developer, with Google sign-in added to M8.
> **Master plan:** [04 §4 M8](04-implementation-plan.md#m8-hardening-d9). **Acceptance:** AC-1 to AC-7 ([03 §6](03-mvp-scope.md)). Deadline: before 14 Oct.

## Order
1. **Tests green.**
   - Update the ~45 older widget tests the redesign broke: actions moved into menus and panels, texts that moved.
   - Run both full suites.
   - Add **one server test of the whole loop**: AC-1 to AC-5 in sequence (create, invite, capture, review, ledger numbers).
2. **First-run empty state** on the project list: a short welcome with **Create a project** and **Join with a code**, instead of "No projects yet" and Refresh.
3. **Review → release shortcut (REV-06):** after approving a stage, the approver is offered **Record a release** for the next stage. The release form opens with that stage chosen.
4. **Google sign-in (AUTH-04).** See below.
5. **French pass (AC-7):**
   - every screen added since M5 (Money, filters, the update page and form, skeletons, error codes) checked in French;
   - long French text that overflows (chips, buttons, the teal card) fixed;
   - the main screens rendered in French with the screenshot harness.
6. **Privacy policy (NFR-PRV-02):**
   - a short page in EN and FR, reachable from Profile and the welcome page;
   - served by the server at `/privacy`, so it can be linked from the store listing and the submission.
7. **Demo data:**
   - a seed script (`plotwatch_server/bin/seed.dart`) that creates a believable project (Maison Douala) with members, stages, verified photos, an update, releases and expenses with receipts;
   - run once by the developer against Cloud;
   - demo accounts for the judges.
8. **Screenshot check** of the new screens (Money tab, forms, entry, skeletons, first-run), and of French.
9. **Developer's checklist:** every acceptance criterion by hand on Android and web; the release APK and web build; the final Cloud deploy.
10. **Merge `dev` into `main`**, with the developer's approval, once green.
11. **Only if early:** hash chain (VER-05).

Set aside, documented in the README as the roadmap: evidence requests, fund requests, comments, the inactivity reminder, photos on updates, proof files for releases, the public verification page, the offline queue.

## Google sign-in (AUTH-04)
From Serverpod's Google provider guide (checked 2026-10-12).

**Developer, in Google Cloud console:**
1. **Google Auth Platform › Get started:**
   - Branding: the app's name, and `serverpod.space` (plus our own domain, if any) under authorized domains;
   - Data access: the `userinfo.email` and `userinfo.profile` scopes;
   - Audience: Testing, with test users.
2. **Clients:**
   - **Web application** (needed on every platform): copy its client ID and secret;
   - **Android**: the package name and SHA-1, the debug one from `./gradlew signingReport`, then the release one;
   - **iOS**: the bundle ID; download the `.plist`.
3. **Web client:**
   - authorized JavaScript origins: the web app's address;
   - redirect URIs: `https://<server>/auth/callback`, and `http://localhost:8082/auth/callback` for development.
4. **Before the judges test:** Audience › **Publish app**, or add their accounts as test users.

**Server (Claude):**
- `googleClientSecret` in `config/passwords.yaml`, as the JSON block of the guide. The developer adds it; never committed. On Cloud: `serverpod cloud password set googleClientSecret --from-file …`.
- `GoogleIdpConfigFromPasswords()` added to `identityProviderBuilders` in `server.dart`.
- `class GoogleIdpEndpoint extends GoogleIdpBaseEndpoint {}`.
- The web callback route `/auth/callback` (`FlutterWebAuth2CallbackRoute`).
- A migration if the provider adds tables.
- Tests: the endpoint exists, and a new Google user gets a profile.

**App (Claude):**
- `client.auth.initializeGoogleSignIn(…)` after `client.auth.initialize()`:
  - web: `clientId` and `redirectUri`;
  - phones: `serverClientId`, the web client ID;
  - the IDs come from `assets/config.json`, not the code.
- A **Continue with Google** button in our style, on the sign-in and sign-up pages, using the package's Google sign-in controller.
- After the first Google sign-in, the profile step asks for what Google doesn't give (country, language), as after email sign-up.
- iOS `Info.plist`: `GIDClientID`, `GIDServerClientID` and the reversed client ID URL scheme. Prepared without a Mac (as in M2 G2); untested on iOS.
- Tests: the button shows, and a sign-in error shows its message.

**Note:** in development, Google on the web only works with the app served by the server (`localhost:8082`), not with `flutter run -d chrome`.
