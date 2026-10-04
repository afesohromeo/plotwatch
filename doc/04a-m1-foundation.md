# M1 Foundation Plan (D2, Mon 2026-10-05)

> **Parent plan:** [04-implementation-plan.md](04-implementation-plan.md) §4, M1.
> **Status:** Task group A **approved and completed 2026-10-04** (see "Group A outcome" at the end). Task groups B–E (server profile, auth, profile, delivery) will be added to this file and approved before they start.
> **Work split** ([04 §1.2](04-implementation-plan.md#12-who-runs-what-decided-2026-10-04)): **You run** the tool commands; Claude moves, copies and edits files, writes the code and tests, and runs `dart test` / `flutter test`.

---

## Task group A: create the project and integrate flutter_bloc_kit

**Goal:** a Serverpod 4 workspace at the repo root whose Flutter app is the developer's [flutter_bloc_kit](https://github.com/afesohromeo/flutter_bloc_kit), wired to the generated Serverpod client per [`_standards/14`](../_standards/14_serverpod_adaptation.md), running locally on web and Android.

**Decisions (2026-10-04):**
- Serverpod's standard layout at the repo root.
- The GitHub repo isn't created from the kit template.
- The Flutter app is replaced with the kit (`C:\New_folder\Flutter_Bloc_Kit\flutter_bloc_kit`, commit `4b2f18d`).
- `dio` and the unused dependencies (`http`, `equatable`, `json_annotation`, `json_serializable`, `collection`, `google_fonts`) are dropped.
- Version bumps to PlusLocate's working set (`freezed` 4.0.1 — 4.0.2 conflicts with the server's `test` package in the workspace —, `freezed_annotation` 3.1.0, `build_runner` ^2.16.1) plus `flutter_secure_storage` ^10 (Serverpod 4 requirement).
- `fakeToken`, `SecureStorageHelper` and `AuthCheckHelper` are removed.
- `Makefile` copied unchanged.
- `l10n.yaml` as in PlusLocate. Translations are regenerated automatically by Flutter (`generate: true`), as in PlusLocate.

### A1. Create the project (you)
You run, in PowerShell:
```powershell
mkdir C:\New_folder\_sp_tmp
cd C:\New_folder\_sp_tmp
serverpod create plotwatch --database --auth --webapp --no-redis --no-website --ide claude
```
Expected: `✓ Serverpod project created.` The line "Updating Flutter app MacOS entitlements. failed." is known (feedback F-2) and can be ignored. Tell Claude when it's done.

### A2. Move into the repo (Claude)
1. List everything under `C:\New_folder\_sp_tmp\plotwatch`, including what `--ide claude` generated (skills, MCP config).
2. Compare its root files with ours (`README.md`, `.gitignore`, `CLAUDE.md`, `.claude/settings.json`); nothing of ours is overwritten.
3. Move into `C:\New_folder\plotwatch`: `plotwatch_server/`, `plotwatch_client/`, `plotwatch_flutter/`, root `pubspec.yaml` and `pubspec.lock`, `.github/workflows/`, `.vscode/`.
4. Merge the root `.gitignore`:
   - add the template's entries (`.dart_tool/`, `pubspec_overrides.yaml`, agent folders, `.mcp.json`, `.scloud/`);
   - replace its blanket `.claude/` entry with the generated paths only, so `.claude/settings.json` stays committed.
5. Serverpod's skills and MCP config stay local (gitignored), like the other skills. Their location is added to the "Agent tooling" section of `CLAUDE.md`.
6. Merge the useful parts of `AGENTS.md` into `CLAUDE.md`:
   - using the `serverpod` MCP server;
   - the checklist after changes;
   - generated code is never edited;
   - "tests need no Docker".

   Its "never start the server yourself" rule matches our work split. Then delete `AGENTS.md` and `C:\New_folder\_sp_tmp`.

### A3. Server cleanup (Claude)
- Delete `lib/src/greetings/` and `test/integration/greeting_endpoint_test.dart`.
- Move `lib/src/auth/email_idp_endpoint.dart` and `jwt_refresh_endpoint.dart` to `lib/src/endpoints/` (14 §1.1).
- `lib/server.dart`: `appDisplayName: 'Plotwatch'`.
- Add `lib/src/models/app_error_code.spy.yaml` and `app_exception.spy.yaml` ([14 §2.1](../_standards/14_serverpod_adaptation.md#21-the-server-sends-codes-never-text)). The first values: `permissionDenied` plus the auth codes of 14 §2.3.1 (`authInvalidCredentials`, `authTooManyAttempts`, `authRequestExpired`, `authRequestInvalid`, `authPasswordPolicy`, `authUserBlocked`, `authUnknown`).

### A4. Replace the Flutter app with the kit (Claude)
1. In `plotwatch_flutter/`, **keep**:
   - the platform folders (`android/`, `ios/`, `web/`, `macos/`, `linux/`, `windows/`);
   - `lib/driver.dart` (used by `serverpod start` and the Serverpod MCP);
   - the server-URL logic of `lib/client.dart`, moved to `api_provider.dart` in A5;
   - the workspace parts of `pubspec.yaml`: `resolution: workspace`, the `environment` constraints, `plotwatch_client` path dependency, `serverpod_flutter` and `serverpod_auth_idp_flutter` (pinned `4.0.3`), the `flutter_driver` dev dependency.

   Delete the rest of the generated `lib/` and `test/`.
2. **Copy from the kit:** `lib/` (without `*.freezed.dart` / `*.g.dart`), `Makefile`, `l10n.yaml` (plus PlusLocate's `untranslated-messages-file: toFrench.txt`), `analysis_options.yaml`.
3. **Rename** every `package:flutter_bloc_kit/` import to `package:plotwatch_flutter/` (36 files), and `lib/flutter_bloc_kit.dart` to `lib/plotwatch_flutter.dart`.
4. **Dependencies** in `plotwatch_flutter/pubspec.yaml`:
   - from the kit: `flutter_localizations`, `cupertino_icons`, `provider`, `flutter_bloc`, `freezed_annotation ^3.1.0`, `intl`, `go_router`, `infinite_scroll_pagination`, `flutter_native_splash`, `intl_phone_field`, `flutter_secure_storage ^10.0.0`, `app_theme_kit`, `web`;
   - dev: `flutter_test`, `flutter_lints`, `build_runner ^2.16.1`, `freezed ^4.0.1`, `flutter_gen_runner`;
   - plus the Serverpod packages kept in step 1;
   - `flutter: generate: true` and the kit's `fluttergen` section.
5. Remove `fakeToken` from `shared/utils/constant.dart`. Delete `shared/utils/secure_storage_helper.dart` and `auth_check_helper.dart`, and their exports from `utils.dart`.
6. Android: `applicationId` and `namespace` set to `com.afesohromeo.plotwatch`, `MainActivity` moved to the matching package folder, app label "Plotwatch". Web: title and manifest name "Plotwatch".
7. If Freezed 4 rejects a kit class during A6, mark it `sealed`, as PlusLocate does for its states.

### A5. API config per `_standards/14` (Claude, TDD)
Files in `plotwatch_flutter/lib/src/data/api/config/`:

| File | Contents |
|------|----------|
| `api_provider.dart` | Singleton holding the one Serverpod `Client`: `Client(serverUrl)..connectivityMonitor = FlutterConnectivityMonitor()..authSessionManager = FlutterAuthSessionManager()`, `client.auth.initialize()`. Server URL: `--dart-define=SERVER_URL`, else `assets/config.json` (served by the server for web), else `http://localhost:8080/` (template logic). |
| `api_exceptions.dart` | `HttpException400(code: AppErrorCode)`, `HttpException401`, `NetworkException`, `UnknownApiException` (14 §2.2) |
| `api_error_handler.dart` | `ApiErrorHandler.handle(Object e)` per 14 §2.3 and §2.3.1 |

1. Write `test/data/api/config/api_error_handler_test.dart` first. There's one test per mapping row:
   - `AppException` → `HttpException400` with the same code;
   - each `EmailAccountLoginException` / `EmailAccountRequestException` / `EmailAccountPasswordResetException` reason and `AuthUserBlockedException` → `HttpException400` with its auth code;
   - `ServerpodClientUnauthorized` → `HttpException401`;
   - `ServerpodClientForbidden` → `HttpException400(permissionDenied)`;
   - `ServerpodClientNetworkException` and a `MethodStreamException` → `NetworkException`;
   - anything else → `UnknownApiException`.
2. Claude runs `flutter test test/data/api/config/` → it must **fail** (classes missing).
3. Write the three files.
4. Claude runs the same tests → they **pass**.

### A6. Generate, analyze, run (you, then Claude)
You run, from `C:\New_folder\plotwatch`:
```powershell
cd plotwatch_server; serverpod generate; cd ..
flutter pub get
cd plotwatch_flutter; dart run build_runner build --delete-conflicting-outputs; cd ..
dart analyze
```
Expected:
- generation completes;
- `pub get` regenerates the l10n files;
- `dart analyze` reports no errors.

Send Claude the output of any step that fails.

Claude runs `dart test` (in `plotwatch_server`) and `flutter test` (in `plotwatch_flutter`). Both must pass.

Then you run `serverpod start` in `plotwatch_server`. Expected:
- the server starts;
- the kit's Home page opens in the browser;
- `flutter run` on the Android phone shows the same page.

### A7. Commit and document (Claude)
- Commit and push: `chore: create Serverpod project and integrate flutter_bloc_kit`.
- Update the layout in [04 §2](04-implementation-plan.md#2-target-repository-layout) (Flutter app from the kit).
- Update `00` §8.

**Exit criterion for group A:** the workspace at the repo root builds, tests pass, the kit app runs on web and Android against the local server, and the commit is pushed.

### Group A outcome (2026-10-04)
Done and verified:
- `flutter test`: 21/21 passing (`ApiErrorHandler`, written test-first: failed on the missing classes, then passed).
- `dart analyze`: clean after the two fixes below.
- `serverpod start` serves the kit's Home page in the browser, and `flutter run` shows it on the Android phone.

Differences from the plan, and why:
| Item | Plan | Actual | Reason |
|------|------|--------|--------|
| Freezed | 4.0.2 | **^4.0.1** (resolves 4.0.1) | In the workspace, the server's `test` package caps `analyzer` below 14; freezed 4.0.2 needs analyzer 14 |
| Extra dependency | — | `serverpod_auth_idp_client: 4.0.3` | The email sign-in exceptions mapped by `ApiErrorHandler` aren't re-exported by any other package |
| `HomeState` | — | `sealed class` (fixed by the developer) | Freezed 4 needs state classes to be `sealed` or `abstract` (A4 step 7) |
| `dialog_helper.dart` | — | `return await completer.future;` (fixed by the developer) | Lint `unawaited_return_in_try_block`: an error in the future would escape the `try` |
| CI workflows | — | No hardcoded passwords: `tests.yml` generates a throwaway test-database password per run; unused Redis password removed; Flutter 3.47.5 in all three workflows | NFR-SEC-05 (approved 2026-10-04) |
| `plotwatch_server/docker-compose.yaml` | — | Deleted | Not used (embedded Postgres) and held copies of the database passwords (approved 2026-10-04) |
| `.vscode/tasks.json` | — | Kept local (gitignored) | Holds the development database password |
| Agent tooling | — | 21 `serverpod-*` + 7 `relic-*` skills kept locally in `.claude/skills/` (auto-discovered); local `.mcp.json` calls `serverpod.bat` by full path | VS Code keeps the PATH it started with, so `serverpod` wasn't found by the MCP launcher |
| Server tests | — | None yet (the greeting example was removed), so `dart test` reports "No tests were found" and the CI **Tests** workflow fails until group B adds the first server test | Expected |

**For the kit itself (optional):** the `sealed` and `return await` fixes above, the Freezed/build_runner versions, and removing `fakeToken` (it contains a JWT with a personal email address, also in the kit's Git history) would benefit `afesohromeo/flutter_bloc_kit`.
