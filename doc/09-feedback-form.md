# Most Valuable Feedback: form answers

Plain text for the hackathon's feedback form, drawn from
[`serverpod-feedback.md`](serverpod-feedback.md) (findings F-1 to F-20).
Environment: Windows 11, Serverpod CLI 4.0.3, Flutter 3.47, Dart 3.13,
Serverpod Cloud.

---

```
Feedback from building Plotwatch (Flutter + Serverpod 4 + Serverpod Cloud) over 10 days on Windows 11, Serverpod 4.0.3. Ordered by impact. Each item: what happened, how to reproduce, a suggestion.

1. CODE GENERATION CAN WRITE A PARTIAL CLIENT (high impact)
While serverpod start is watching, saving an endpoint that calls a not-yet-written service method logs "Endpoint analysis skipped due to invalid Dart syntax" and "Code generation failed", yet the client IS rewritten, without the endpoints that failed analysis, so the running Flutter app stops compiling. Fixing the error doesn't regenerate; only a manual serverpod generate does. We also saw new endpoint methods missing from the client after valid saves until a manual generate.
Reproduce: with serverpod start running, add a call to a missing method in an endpoint and save; then add the method and save; inspect client.dart.
Suggestion: never write a client from a failed analysis (keep the last good one), regenerate on the next good save, and log whether the client was written and which endpoints were skipped.

2. SERVERPOD CLOUD SILENTLY DROPS FOLDERS FROM THE SERVER IMAGE (high impact)
The deployed image keeps only config/, web/, migrations/ and protocol.yaml. A seed/ folder next to them is uploaded but absent at run time: PathNotFoundException in production only.
Reproduce: read a file from <server>/seed/ at startup; deploy.
Suggestion: document which folders reach the image, and warn at deploy time when an uploaded folder will be dropped.

3. ROLLOUTS STOP THE FIRST SERVER SECONDS AFTER IT STARTS
During a rollout a first instance starts and is stopped about 25 s later while the primary starts; startup work on it (a 30 s data seed) was cut off mid-way ("Database stopped").
Suggestion: document the rollout sequence and recommend future calls for one-off startup work (that's what fixed it for us).

4. CPU-HEAVY WORK IN AN ENDPOINT BLOCKS THE WHOLE SERVER
Resizing a 1 MB JPEG with package:image inside an endpoint blocked the isolate: on Cloud every other call took 11-16 s and one returned 504. Isolate.run fixed it.
Suggestion: a short note in the endpoints/performance docs about running CPU-heavy work with Isolate.run.

5. AN EXPIRED SESSION DOESN'T SIGN OUT (serverpod_auth_core_client)
When the refresh token is no longer valid during a session, calls fail with ServerpodClientUnauthorized but the session manager keeps the user signed in; only validateAuthentication at startup signs out. The web app stays on its page. onFailedCall can't be used to fix it, because it fires on the first 401, before the client's own refresh-and-retry.
Suggestion: sign out locally when a refresh fails with failedUnauthorized, or expose a callback for that case.

6. GOOGLE SIGN-IN CREATES A SECOND USER FOR AN EXISTING EMAIL
A first Google sign-in with the email of an existing email/password account creates a second user (Google accounts are matched by Google ID only). Users end up with two accounts and the same email. The docs don't mention linking.
Suggestion: an opt-in setting in GoogleIdpConfig to link verified emails to existing accounts, or document the pattern (we call utils.linkGoogleAuthentication before login).

7. GoogleIdpConfigFromPasswords THROWS WHEN THE SECRET IS MISSING
A server whose test or staging config has no googleClientSecret can't start once Google is added.
Suggestion: skip the provider with a warning, or document the guard.

8. THE WEB OAUTH CALLBACK ROUTE DOESN'T WORK WITH flutter run
FlutterWebAuth2CallbackRoute only works when the web app is served by the Serverpod web server; under flutter run -d chrome the redirect is a 404 and Google shows "Access blocked: request is invalid".
Suggestion: say so in the guide and suggest a static auth.html in the app's web/ folder, which works everywhere.

9. FileUploader CAN HANG FOREVER (serverpod_client)
upload/uploadByteData waits for both the body pipe and send(); when send() fails nothing reads the body, so the pipe never completes, and there is no timeout. Seen when the development upload URL pointed at localhost from the Android emulator.
Suggestion: fail fast (listen to the sink when send() throws), add a timeout, and build development upload URLs from the request's Host header (or document that publicHost must be reachable from devices).

10. ENDPOINT PARAMETER DEFAULTS ARE DROPPED
A named parameter with a default ({int page = 0}) becomes required in the generated client and test tools; only nullable named parameters stay optional.
Suggestion: carry the default over, or reject it at generation time with a clear message.

11. flutter_web_auth_2 WILL BREAK EVERY ANDROID BUILD WITH AUTH
Every Android build of an app using serverpod_auth_idp_flutter 4.0.3 warns that flutter_web_auth_2 applies the Kotlin Gradle Plugin and that future Flutter versions will fail to build. It comes in transitively; app developers can't fix it.
Suggestion: move to a compatible version, or make it optional for apps that don't use web-based sign-in.

12. MIGRATIONS: UNCLEAR ERROR FOR A NEW REQUIRED COLUMN
create-migration says the table "will be deleted and recreated" without saying why (a non-null column without a default) or what to do.
Suggestion: name the column and the reason, and suggest a nullable field or default=.

13. EMBEDDED POSTGRES: NO STOP COMMAND, ORPHANS, SOCKET ONLY
After dart test, the test database keeps running; after serverpod start ends uncleanly, the dev database is orphaned and "serverpod database start" fails with "Another process is using the local database". There is no serverpod database stop. The embedded database also listens on a Unix socket only (listen_addresses = ''), so psql -p 8090 fails and the socket folder must be found by hand.
Suggestion: add serverpod database stop, detect stale owners, name the PID and data directory in the error, and print how to connect with psql (the socket folder).

14. WINDOWS: flutter build web --output DOESN'T WORK; INSTALL PATH
The template's flutter_build script works around it with xcopy, but the docs show --output. dart install serverpod_cli installs to %LOCALAPPDATA%\Dart\install\bin, not on PATH, and the installation page doesn't say so.
Suggestion: Windows notes on both pages.

15. TEMPLATE AND DOCS DETAILS
- The quickstart page uses serverpod quickstart, the upgrade guide says serverpod create replaces it; say how they relate.
- serverpod create on Windows prints "Updating Flutter app MacOS entitlements. failed." in an otherwise successful setup.
- The template's widget_test.dart has no test (flutter test exits 79) and still says PROJECTNAME.
- The root .gitignore ignores the whole .claude/ folder, hiding files teams commit (settings.json).

What worked very well: generated models and the typed client, withServerpod tests on an embedded PostgreSQL (no Docker), streaming endpoints with server events, future calls, and scloud deploys with passwords. Thank you.
```
