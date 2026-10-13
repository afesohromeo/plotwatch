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
   - **Outcome (2026-10-12):**
     - The ARB check found every key translated, no placeholder mismatch and no English left.
     - The screenshot harness takes `--dart-define=LOCALE=fr` and writes `out/*_fr.png`. It now also covers Money, both money forms, a ledger entry, first-run, sign-in and sign-up's code step: 28 screens, none overflowing.
     - **Layout fixes:**
       - "Request changes" wraps to two lines instead of shrinking;
       - the badge under a narrow photo says "Partiel";
       - label colons come from `labelColon` ("Dates prévues : …").
     - **French fixes:**
       - a real plural for approved stages ("1 étape approuvée");
       - "À valider";
       - "Catégorie";
       - "Réception";
       - "Content de vous revoir";
       - "Aucun versement";
       - "Tél.";
       - "Saisi par" separated by "·".
6. **Privacy policy (NFR-PRV-02):**
   - a short page in EN and FR, reachable from Profile and the welcome page;
   - served by the server at `/privacy`, so it can be linked from the store listing and the submission.
   - **Detailed plan (approved 2026-10-12), with account deletion:**
     - **The page:**
       - `plotwatch_flutter/web/privacy.html`, a static page of the web app (like `auth.html`), so it works on :8083, :8082 and Cloud;
       - the server also answers `/privacy` with it;
       - English, then French (`#fr`);
       - it covers what is collected and why, who sees it (only the project's members), where it is stored (Serverpod Cloud), how long it is kept, Google sign-in, deletion, and a contact email.
       - Laid out like PlusLocate's `PRIVACY.md`: a developer line, "In short", what the app does not do, Google's policy link, and the under-13 wording.
       - Contact: **`afesoh.apps@gmail.com`**, the developer's existing apps address, also used for PlusLocate and on Play (decided 2026-10-13).
     - **Links:**
       - Profile › Privacy policy, and a "Privacy" link on the welcome page;
       - opened in the browser with `url_launcher`;
       - the French app opens `#fr`.
     - **Account deletion.** Google Play (and Apple) require an in-app way, plus a web route for people without the app; the web route is the privacy page's contact. The rule is to delete the person, not the shared history:

       | Data | On deletion |
       |---|---|
       | Sign-in (email/password, Google), profile, name, email, settings, notifications | Deleted. Deleting the auth user cascades to Serverpod's tables |
       | Memberships | Marked removed in every project, as when a member is removed |
       | Projects where they are the only active member | Deleted with everything in them, including their stored files (photos, thumbnails, receipts) |
       | Projects they own with other active members, not completed or archived | **Blocked:** "Complete or archive these projects first", with their names. There is no ownership transfer |
       | Photos, ledger entries, updates and reviews in shared projects | Kept. With no profile left, they show as "A former member" (the `someone` text) |

     - **Server:** an `AccountEndpoint` (login required) with:
       - `deletionBlockers()`, the names of the blocking projects;
       - `deleteMe()`, which checks the blockers again and deletes in one transaction. Files are deleted after the commit.
     - **App:** Profile › Delete account:
       - a dialog lists the blockers, or explains what is deleted and kept;
       - the person types their email to confirm;
       - on success the app signs out locally.
     - **Tests:**
       - server: a solo project is deleted; a shared active project blocks; an archived shared project is kept and the membership marked removed; the sign-in rows are gone; shared records stay;
       - app: the dialog, the blockers, the typed confirmation.
7. **Demo data:**
   - a seed script (`plotwatch_server/bin/seed.dart`) that creates a believable project (Maison Douala) with members, stages, verified photos, an update, releases and expenses with receipts;
   - run once by the developer against Cloud;
   - demo accounts for the judges.
   - **Detailed plan (approved 2026-10-13), which replaces the bullets above:**
     - **How it runs:** the server seeds at startup when the password `demoSeed` is set. A standalone script can't reach the Cloud database. The seed is idempotent: it skips if the demo project exists. The developer sets the Cloud password, deploys once, then removes it; locally the same works through `passwords.yaml`.
     - **Accounts**, email and password so the judges need no Google account:
       - `funder@demo.plotwatch.app`, the owner abroad;
       - `manager@demo.plotwatch.app`, the site manager;
       - `cofunder@demo.plotwatch.app`, a co-funder allowed to approve.
       - One password, the Cloud password `demoPassword` (never committed), given in the submission notes.
     - **The project: "Afesoh Residence"**, a 5-storey residential building on a 500 m² plot in Odza, Yaoundé, Cameroon. The plot sits between two 2-storey houses, with a palm tree, a mango tree and banana plants. Stage 4 was renamed for 5 storeys (2026-10-13). Type New house, the closest one. The site is near 3.792° N, 11.544° E, 50 m radius. Currency XAF.
       - **Stages:**
         1. Site preparation (approved)
         2. Foundation (approved)
         3. Ground floor: columns and slab (submitted, waiting for review)
         4. Upper floors: structure, floors 1 to 4 (not started)
         5. Roof (not started)
         6. Finishing (not started)
       - **Photos:** verified photos on the done stages and one partly verified photo.
       - **Updates:** two, with weather, workers and an issue.
       - **Ledger:** releases (one confirmed, one waiting) and expenses with and without receipts, so the unaccounted alert shows.
       - **Invitations:** a pending one.
       - The feed and notifications come from calling the real services.
     - **Photos:**
       - construction photos generated by the developer with an AI image tool from `plotwatch_server/seed/PROMPTS.md`: the same plot from different camera positions, for the stages that have photos (1 to 3). Decided 2026-10-13: the Commons photos weren't clean enough, and the developer's downloads included watermarked stock photos;
       - credits in `plotwatch_server/seed/CREDITS.md`;
       - kept in the seed folder only;
       - the README says the demo uses credited third-party photos.
     - **Receipts:** rendered by us with the screenshot harness, never real receipts from the web.
     - **Verification:** the badges come from the recorded GPS and time, not from the image files.
     - **Tests:**
       - the seed runs, and a second run changes nothing;
       - stage statuses, ledger numbers and verified photos are as planned;
       - the three accounts can sign in.
     - **As built (2026-10-13):**
       - `lib/src/seed/demo_seed.dart` signs a server session in as each person and calls the real endpoints, like `core_loop_test`.
       - After each step, the timestamps that step wrote are moved back to its day (`_backdate`, demo project only).
       - The people:
         - Brice Afesoh, owner, in Canada, English;
         - Joseph Mvondo, site manager, French;
         - Mary Aelys, co-funder who approves, French.
       - The ledger: released 47.5 M FCFA (one release of 15 M waiting for confirmation), spent 20.65 M, 14.1 M of it with a receipt. The unaccounted alert shows.
       - Files: the photos are in `seed/photos/`; `seed/receipts/` holds three receipts drawn with `tool/screenshots/receipts_test.dart` (made-up shops).
       - The seed runs after `pod.start()` when `demoSeed` is `true`. A failure is logged, never fatal.
8. **Screenshot check** of the new screens (Money tab, forms, entry, skeletons, first-run), and of French.
   - **Outcome (2026-10-13):** done with the French pass and the later renders (delete dialog, badges on photos). On photos, the verification badge is now a white pill (`onPhoto`): a light tint was unreadable.
9. **Developer's checklist** (written 2026-10-13: [`06-developer-checklist.md`](06-developer-checklist.md); README rewritten for the judges): every acceptance criterion by hand on Android and web; the release APK and web build; the final Cloud deploy.
10. **Merge `dev` into `main`**, with the developer's approval, once green.
11. **Only if early:** hash chain (VER-05).

Set aside, documented in the README as the roadmap: evidence requests, fund requests, comments, the inactivity reminder, photos on updates, proof files for releases, the public verification page, the offline queue, ownership transfer (so an owner can leave an open shared project; decided 2026-10-13).

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

**Note:** on the web, Google works on `flutter run` (:8083), the server-served build (:8082) and Cloud, through `web/auth.html` (see "As built").

### One account per email (AUTH-04b, approved 2026-10-12)
**Found by the developer on the emulator:** a first Google sign-in with the email of an existing password account created a **second user**. Serverpod's Google provider finds users by Google's account ID only, never by email, and leaves linking to the app.

**Decision: attach.** The developer chose this over refusing, after comparing the two.
- **Google sign-in with a verified email that a password account already has:** the Google login is linked to that user. The same person gets the same projects, and the password keeps working.
  - Done in `GoogleIdpEndpoint`, before the module's login, with the module's own `linkGoogleAuthentication`.
  - The web code is exchanged for tokens first, with the module's `exchangeCodeForToken`.
  - **Never** when Google says the email is not verified: that person then gets their own user, as before.
- **Email sign-up with an email a Google user already has:** refused at the first step with `AppErrorCode.emailUsesGoogle`, shown as "This email is used with Google. Use Continue with Google." Adding a password to a Google account is on the roadmap.
- **Code page:** "No code? If you already have an account with this email, sign in or reset your password." Serverpod sends no code to an email that is already registered, so nobody can find out which emails have accounts. That protection is kept.
- **Server tests:**
  - a Google email that a password account has gives that same user;
  - a new Google email gives a new user;
  - an unverified Google email is never linked;
  - a returning Google user gets the same user;
  - email sign-up with a Google user's email is refused.
- **App tests:** the refusal and the code-page text.
- **The developer's duplicate in the dev database:** deleted with a one-off SQL script, run by the developer (not in the repository).

**As built (2026-10-12):**
- **The web callback is `web/auth.html`, not the server route.** `flutter run` (:8083) doesn't serve server routes, so the callback is a static page of the app. It works the same on :8083, :8082 and Cloud. Redirect URIs to register: `http://localhost:8083/auth.html`, `http://localhost:8082/auth.html` and `https://<web app>/auth.html`.
- **No migration:** the Google account table has been in our first migration (20261004170947501) since the auth module was set up.
- **Google is on only where `googleClientSecret` is set.** The test server and a fresh deploy start without it, and the app hides the button when `config.json` has no `googleClientId`.
- **`config.json`:**
  - the server reads the public web client ID from the secret JSON (`web.client_id`) and serves it to the web app;
  - the bundled copy carries it for phones.
- **Not the package's controller.** `GoogleAuthController` is a ChangeNotifier tied to a widget, which `_standards` doesn't allow in views. The same flow goes through the package's services instead:
  - `AuthApiProvider.signInWithGoogle`: the web PKCE redirect, or the Google account sheet on phones;
  - `AuthRepository` saves the session;
  - `GoogleSignInBloc` and `GoogleSignInButton` are shared by the sign-in page and the first step of sign-up.
  - Closing Google's window is not an error.
- **The language of a new Google user:** `profile.adoptLocale` saves the app's language unless settings already exist. That matches the email sign-up. Google gives the name; the country stays optional, as for email users.
- **iOS `Info.plist`:** contains `GIDClientID` (the iOS client), `GIDServerClientID` (the web client) and the reversed iOS client ID as a URL scheme. Prepared without a Mac; untested on iOS.
