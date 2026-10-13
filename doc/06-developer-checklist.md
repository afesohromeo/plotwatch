# Developer's checklist before submission (doc/04g step 9)

Everything the developer does by hand before the deadline (**before
2026-10-14**). Tick each box. Commands are PowerShell.

---

## 1. Final Cloud configuration (once)
Passwords on Serverpod Cloud (never in the repository):

- [ ] `googleClientSecret`: the Web client's JSON from Google Cloud.
  ```powershell
  cd C:\New_folder\plotwatch\plotwatch_server
  scloud password set googleClientSecret --from-file <path to the client secret JSON>
  ```
- [ ] `googleMapsWebKey` is still set (web maps).
- [ ] `demoPassword`: the judges' demo password, 8 characters or more. Write it in the submission notes.
- [ ] `demoSeed` set to `true` for the deploy that creates the demo. Remove it after the first start (it never runs twice anyway).

**Google Cloud console** (Clients › Web client):
- [ ] The authorized JavaScript origins include `https://plotwatch.serverpod.space`.
- [ ] The redirect URIs include `https://plotwatch.serverpod.space/auth.html`.
- [ ] **Audience › Publish app**, so judges can use Google sign-in (otherwise only test users can).
- [ ] Android client: add the **release** SHA-1 (from the upload key), next to the debug one.

## 2. Builds
- [ ] Format and analyze:
  ```powershell
  cd C:\New_folder\plotwatch\plotwatch_server; dart format .; dart analyze
  cd ..\plotwatch_flutter; dart format lib test tool; flutter analyze
  ```
- [ ] Deploy. `scloud.yaml` runs `serverpod generate` and `serverpod run flutter_build` first, which builds the web app into `web/app`. On Windows, `flutter build web --output` does not work, which is why the script copies with `xcopy`.
  ```powershell
  cd C:\New_folder\plotwatch\plotwatch_server; scloud deploy
  ```
  To refresh the local :8082 web app without deploying: `serverpod run flutter_build`.
- [ ] Server log after the deploy: `Demo project "Afesoh Residence" created.`
- [ ] Release APK pointing at Cloud:
  ```powershell
  cd C:\New_folder\plotwatch\plotwatch_flutter
  flutter build apk --release --dart-define=SERVER_URL=https://plotwatch.api.serverpod.space/
  ```
  The APK is in `build\app\outputs\flutter-apk\app-release.apk`. Attach it to the submission.
- [ ] Android App Links: the release key's SHA-256 is in `plotwatch_server/web/app_links/assetlinks.json`.

## 3. The acceptance criteria by hand (doc/03 §6)
On **Android** (the release APK) and on the **web** (https://plotwatch.serverpod.space), with two accounts:

- [ ] **AC-1 Project setup:**
  - create a project with a template: it is a draft with the template's stages;
  - the site manager localizes the site on the plot; the owner sees it on the map, sets the radius and validates it;
  - the project becomes active.
- [ ] **AC-2 Invitation:**
  - a site-manager invitation shows a code and a link, and the other account joins with the code;
  - the same code again shows a clear message.
- [ ] **AC-3 Verified capture:**
  - inside the radius, a capture appears on the funder's device without refreshing, **Verified**, with the breakdown;
  - outside the radius, it is **Unverified**, with the distance;
  - no gallery anywhere.
- [ ] **AC-4 Stage review:**
  - when the site manager submits, the approver is notified at once;
  - Request changes sends a comment back; after the resubmit, Approve, progress goes up;
  - after Approve, the "Record a release" offer appears.
- [ ] **AC-5 Ledger:**
  - a release of 500,000 and expenses of 300,000 (with a receipt) and 50,000 (without one) give released 500,000, spent 350,000, with a receipt 300,000 and unaccounted 200,000, on both devices, live;
  - a reversal corrects a mistake.
- [ ] **AC-6 Resilience:** with the site manager's phone in airplane mode, capture, reconnect; the feed catches up without duplicates.
- [ ] **AC-7 French:**
  - Profile › language French: the whole core loop is in French, including errors, dates and FCFA amounts;
  - the web as well.
- [ ] **Google sign-in** on Android and the web, including with the email of an existing password account (same account).
- [ ] **Account deletion** with a throwaway account (blocked by a shared active project, then deleted).
- [ ] **Privacy policy** opens from Profile and the welcome page; `https://plotwatch.serverpod.space/privacy` answers.
- [ ] **The demo:** sign in as `funder@demo.plotwatch.app` and walk through Afesoh Residence:
  - review the submitted ground floor;
  - check the Money tab: the unaccounted alert, and a release waiting for confirmation.

## 4. Submission
- [ ] Both full test suites green (Claude runs them before the merge).
- [ ] `dev` merged into `main` (with Claude, after your approval).
- [ ] Submission text: the live web URL, the APK, the demo accounts and password, the privacy URL, the repository.
- [ ] Video or screenshots, if the hackathon asks for them.
