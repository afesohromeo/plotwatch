# M1 Foundation Plan (D2, Mon 2026-10-05)

> **Parent plan:** [04-implementation-plan.md](04-implementation-plan.md) §4, M1.
> **Status:** Task group A **approved and completed 2026-10-04** (see "Group A outcome" at the end). Groups B–E **drafted 2026-10-04, awaiting approval** (end of this file).
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

---

## Groups B–E: profile, auth, profile screen, Cloud deploy (draft for approval)

> **Status:** draft 2026-10-04, **awaiting approval**. Facts below were checked in the installed Serverpod 4.0.3 sources (auth module, `serverpod_test`, generated client).

### Decisions in this draft
| # | Decision | Proposal |
|---|----------|----------|
| M1-1 | **User data naming.** The auth module already has a `UserProfile` table (name, email, image), which clashes with our planned `UserProfile` (`02` §7.2). | **Keep name and email in the module's profile** (updated through `AuthServices.instance.userProfiles`). Our own table is **`UserSettings`** (country, language). The endpoint returns one DTO, **`MyProfile`**. **All our models reference users by the auth user ID (`UuidValue`)**; `02` §7.2's "ref UserProfile" is read that way from M2 on. |
| M1-2 | Profile validation | Name: trimmed, 1–100 characters. Country: ISO 3166-1 alpha-2 upper case, or none. Language: `en` or `fr`. New codes: `invalidFullName`, `invalidCountryCode`, `invalidLocale`. |
| M1-3 | Auth BLoCs | One global **`AuthenticationBloc`** (session status, sign-out) drives the router guard (`_standards/07`). One BLoC per form: **`SignInBloc`**, **`SignUpBloc`** (3 steps), **`PasswordResetBloc`** (3 steps). |
| M1-4 | Sign-up flow | Step 1 name + email (`startRegistration`), step 2 the 8-character code (`verifyRegistrationCode`), step 3 password (`finishRegistration`, signs in), then the name and app language are saved with `profile.updateMe`. The module's password rule is mirrored in the form: ≥ 8 characters, no leading or trailing spaces. |
| M1-5 | Session restore | `ApiProvider` awaits `client.auth.restore()` (secure storage, fast) before the first frame, then validates with the server in the background. This avoids a flash of the Welcome screen for signed-in users. A small change to group A's `ApiProvider`. |
| M1-6 | App language | `MaterialApp.locale` follows `MyProfile.locale` once signed in; before that, the device language (EN/FR, else EN). |
| M1-7 | Country picker | The kit's `intl_phone_field` country list: 243 countries with French names (`nameTranslations['fr']`), shown in the app language. |
| M1-8 | Kit demo code | The kit's counter `HomeBloc` is deleted; `HomePage` becomes the signed-in placeholder (project list in M2), using `ResponsiveScaffoldWrapper`. |
| M1-9 | TDD with the work split | **Batched per group:** Claude writes the group's tests and sees them fail (missing classes), writes the code, then you run the generators once (`serverpod generate` / `create-migration`, `build_runner`, `flutter gen-l10n`), and Claude runs the tests until they pass. This keeps test-first while limiting round trips. |
| M1-10 | Test dependencies | You run `flutter pub add dev:bloc_test dev:mocktail` in `plotwatch_flutter` (`mocktail` approved 2026-10-04). |
| M1-11 | Branches | **Decided by the developer 2026-10-04:** all work happens on the **`dev`** branch (created from `main`); other branches only when needed later. |

### Group B: server profile (Claude, TDD)
**Files**
- Create `plotwatch_server/lib/src/models/user_settings.spy.yaml`, `my_profile.spy.yaml`
- Modify `plotwatch_server/lib/src/models/app_error_code.spy.yaml` (+ `invalidFullName`, `invalidCountryCode`, `invalidLocale`)
- Create `plotwatch_server/lib/src/services/profile_service.dart`, `plotwatch_server/lib/src/endpoints/profile_endpoint.dart`
- Test `plotwatch_server/test/integration/profile_endpoint_test.dart`

**Models**
```yaml
# user_settings.spy.yaml
### App settings of a signed-in user. Name and email live in the auth
### module's own profile (decision M1-1).
class: UserSettings
table: user_settings
fields:
  ### The auth module's user ID (`session.authenticated!.authUserId`).
  authUserId: UuidValue
  ### ISO 3166-1 alpha-2, upper case (e.g. CM); null when not set.
  countryCode: String?
  ### `en` or `fr`.
  locale: String
  createdAt: DateTime
  updatedAt: DateTime
indexes:
  user_settings_auth_user_idx:
    fields: authUserId
    unique: true
```
```yaml
# my_profile.spy.yaml
### What the app shows on the profile screen (no table).
class: MyProfile
fields:
  fullName: String?
  email: String?
  countryCode: String?
  locale: String
```

**Tests first** (`withServerpod`). Setup:
- Before each test, `AuthServices.set(tokenManagerBuilders: [ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper')])`, the pattern used by the auth module's own tests.
- Create an auth user with `AuthServices.instance.authUsers.create(session)` and its profile with `userProfiles.createUserProfile(session, id, UserProfileData(fullName: 'Ada Lovelace', email: 'ada@example.com'))`.
- Sign in with `sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(id.uuid, {}))`.

| Test | Expected |
|------|----------|
| `getMe` not signed in | throws `ServerpodUnauthenticatedException` |
| `getMe` first call | `fullName` 'Ada Lovelace', `email` 'ada@example.com', `locale` 'en', `countryCode` null |
| `getMe` twice | exactly one `UserSettings` row |
| `updateMe(fullName: '  Ada King ', countryCode: 'CM', locale: 'fr')` | returns 'Ada King' / 'CM' / 'fr'; a later `getMe` returns the same |
| `updateMe` with `countryCode: null` | allowed, clears the country |
| `updateMe` with name '   ' or 101 characters | `AppException(invalidFullName)` |
| `updateMe` with country 'cm' or 'CMR' | `AppException(invalidCountryCode)` |
| `updateMe` with locale 'de' | `AppException(invalidLocale)` |

**Code**
```dart
// services/profile_service.dart
/// Profile and settings of the signed-in user (PROF-01–03).
class ProfileService {
  const ProfileService();

  static const supportedLocales = {'en', 'fr'};
  static const defaultLocale = 'en';
  static const maxFullNameLength = 100;
  static final _countryCode = RegExp(r'^[A-Z]{2}$');

  /// Throws [AppException] when an update value is invalid (decision M1-2).
  static void validateUpdate({
    required String fullName,
    required String? countryCode,
    required String locale,
  }) {
    final name = fullName.trim();
    if (name.isEmpty || name.length > maxFullNameLength) {
      throw AppException(code: AppErrorCode.invalidFullName);
    }
    if (countryCode != null && !_countryCode.hasMatch(countryCode)) {
      throw AppException(code: AppErrorCode.invalidCountryCode);
    }
    if (!supportedLocales.contains(locale)) {
      throw AppException(code: AppErrorCode.invalidLocale);
    }
  }

  Future<MyProfile> getMe(Session session, UuidValue authUserId) async {
    final settings = await _findOrCreateSettings(session, authUserId);
    return _toMyProfile(session, authUserId, settings);
  }

  /// Saves validated values: name in the auth profile, the rest in
  /// [UserSettings], in one transaction (`_standards/14` §4.2.4).
  Future<MyProfile> updateMe(
    Session session,
    UuidValue authUserId, {
    required String fullName,
    required String? countryCode,
    required String locale,
  }) {
    return session.db.transaction((transaction) async {
      final settings = await _findOrCreateSettings(
          session, authUserId, transaction: transaction);
      final saved = await UserSettings.db.updateRow(
        session,
        settings.copyWith(
          countryCode: countryCode,
          locale: locale,
          updatedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await AuthServices.instance.userProfiles.changeFullName(
          session, authUserId, fullName.trim(), transaction: transaction);
      return _toMyProfile(session, authUserId, saved, transaction: transaction);
    });
  }

  Future<UserSettings> _findOrCreateSettings(
    Session session,
    UuidValue authUserId, {
    Transaction? transaction,
  }) async {
    final existing = await UserSettings.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      transaction: transaction,
    );
    if (existing != null) return existing;
    final now = DateTime.now().toUtc();
    return UserSettings.db.insertRow(
      session,
      UserSettings(
        authUserId: authUserId,
        locale: defaultLocale,
        createdAt: now,
        updatedAt: now,
      ),
      transaction: transaction,
    );
  }

  Future<MyProfile> _toMyProfile(
    Session session,
    UuidValue authUserId,
    UserSettings settings, {
    Transaction? transaction,
  }) async {
    final profile = await AuthServices.instance.userProfiles
        .maybeFindUserProfileByUserId(session, authUserId,
            transaction: transaction);
    return MyProfile(
      fullName: profile?.fullName,
      email: profile?.email,
      countryCode: settings.countryCode,
      locale: settings.locale,
    );
  }
}
```
```dart
// endpoints/profile_endpoint.dart
/// The signed-in user's own profile. Thin: sign-in → validate → service.
class ProfileEndpoint extends Endpoint {
  static const _service = ProfileService();

  @override
  bool get requireLogin => true;

  Future<MyProfile> getMe(Session session) =>
      _service.getMe(session, session.authenticated!.authUserId);

  Future<MyProfile> updateMe(
    Session session, {
    required String fullName,
    String? countryCode,
    required String locale,
  }) {
    ProfileService.validateUpdate(
        fullName: fullName, countryCode: countryCode, locale: locale);
    return _service.updateMe(session, session.authenticated!.authUserId,
        fullName: fullName, countryCode: countryCode, locale: locale);
  }
}
```
*(Exact signatures, e.g. the `transaction` parameter of `maybeFindUserProfileByUserId`, are confirmed when the code compiles; the tests decide.)*

**Steps**
1. Claude writes the test file.
2. You run `serverpod generate` (in `plotwatch_server`).
3. Claude runs `dart test`: **fails** (no `profile` endpoint).
4. Claude writes the models, service and endpoint.
5. You run `serverpod generate`, then `serverpod create-migration` (new `user_settings` table).
6. Claude runs `dart test` until **all pass**; this also turns the CI Tests workflow green.

### Group C: auth in the app (Claude, TDD)
**Files** (all under `plotwatch_flutter/lib/src/`, tests mirrored under `test/`)

| Layer | Files |
|-------|-------|
| API provider | `data/api/auth/auth_api_provider.dart`: `login`, `startRegistration`, `verifyRegistrationCode`, `finishRegistration`, `startPasswordReset`, `verifyPasswordResetCode`, `finishPasswordReset` (on `client.emailIdp`); `saveSession` (`client.auth.updateSignedInUser`), `signOut` (`client.auth.signOutDevice`), `isSignedIn`, `signedInChanges` (stream from `client.auth.authInfoListenable`). Each call: `try { … } catch (e) { throw ApiErrorHandler.handle(e); }`. |
| Repository | `domain/repository/auth_repository.dart`: the same operations; `signIn` and `finishRegistration` also save the session. Log + rethrow (RULE-012). |
| BLoCs | `features/authentication/bloc/`: `AuthenticationBloc` (events `started`, `statusChanged`, `signOutRequested`; state `AuthenticationStatus status` = unknown / authenticated / unauthenticated, `signOutStatus`, `signOutErrorMessage`)<br>`features/sign_in/bloc/`: `SignInBloc` (`signInSubmitted({email, password})`, `resetFlowStep`, `reset`)<br>`features/sign_up/bloc/`: `SignUpBloc` (`detailsSubmitted({fullName, email})`, `codeSubmitted({code})`, `passwordSubmitted({password})`, `codeResent`, `reset`; state `SignUpStep step`, `email`, `fullName`, `accountRequestId`, `registrationToken`, status + error per action)<br>`features/password_reset/bloc/`: `PasswordResetBloc` (same 3 steps; signs in with the new password at the end) |
| Pages | `features/welcome/views/welcome_page.dart`, `features/sign_in/views/sign_in_page.dart`, `features/sign_up/views/sign_up_page.dart`, `features/password_reset/views/password_reset_page.dart`, `features/home/views/home_page.dart` (placeholder, decision M1-8). Every page: `ResponsiveScaffoldWrapper`, `l10n.*` only, `BlocConsumer` with `listenWhen`/`buildWhen`, `context.mounted` after async gaps. |
| Routing | `core/routing/route_names.dart` / `route_paths.dart` (welcome, sign-in, sign-up, forgot-password, home, profile), `core/routing/go_router_refresh_stream.dart`, `route_manager.dart` with the `_standards/07` redirect on `AuthenticationBloc` (public routes when signed out; home when signed in). |
| Errors | `shared/extensions/app_error_code_extensions.dart`: `AppErrorCode.message(AppLocalizations)`, exhaustive switch, one ARB key per code (`errorPermissionDenied`, `errorAuthInvalidCredentials`, …). Plus action keys (`errorSignIn`, `errorSignUp`, `errorPasswordReset`, `errorSignOut`, `errorUnauthorized`, `networkError`). |
| Validators | Extend the kit's `shared/utils/validators.dart`: email, password (mirrors the server rule), code, name. |
| Startup | `ApiProvider.initialize` per decision M1-5; `Application` provides `AuthRepository`, `AuthenticationBloc..add(started)`, and `RouteManager(authBloc)`. |

**Tests first**
- `AuthRepository`, with a mocked `AuthApiProvider`: sign-in saves the session; errors are rethrown.
- `bloc_test` for each BLoC, with every outcome:
  - success;
  - `HttpException400` (message from the code);
  - `HttpException401`;
  - `NetworkException`;
  - unknown error (generic action message);
  - step transitions for sign-up and password reset.
- `AppErrorCode.message`: every code returns a non-empty text in EN and FR.
- Widget tests: Sign in (invalid fields show validator messages, valid fields dispatch `signInSubmitted`); Sign up (shows the step matching the state).

**Steps**
1. You run `flutter pub add dev:bloc_test dev:mocktail`.
2. Claude writes the tests and runs `flutter test`: **fails** (missing classes).
3. Claude writes the code and ARB keys (EN + FR).
4. You run `dart run build_runner build --delete-conflicting-outputs` and `flutter gen-l10n`.
5. Claude runs `flutter test` until **all pass**.
6. You run `serverpod start` and try it: sign up (the verification code is printed in the server log in development), sign out, sign in, forgot password.

### Group D: profile screen and language (Claude, TDD)
- **Data:** `data/api/profile/profile_api_provider.dart` (`getMe`, `updateMe`), `domain/repository/profile_repository.dart`.
- **BLoC:** `features/profile/bloc/`: `ProfileBloc`.
  - Events `fetchMe`, `updateMe({fullName, countryCode, locale})`, `resetFlowStep`, `reset`.
  - State `MyProfile? profile`, `profileStatus`, `profileActionStatus`, `flowStep`, error messages.
- **Page:** `features/profile/views/profile_page.dart`: name, country picker (decision M1-7), language EN / FR, save, sign out.
- **App language:** `ApplicationView` sets `MaterialApp.locale` from `ProfileBloc` (decision M1-6). A `BlocListener` on `AuthenticationBloc` adds `fetchMe` after sign-in and `reset` after sign-out. This coordination happens in the UI, so no BLoC calls another BLoC.
- **Tests first:**
  - `ProfileRepository`;
  - `ProfileBloc` (`bloc_test`: fetch, update, each failure type);
  - widget test: Profile shows the loaded values, and saving dispatches `updateMe`.

  Then the same steps as group C (generators once, tests until green). Manual check: switching to French translates every screen of groups C–D.

### Group E: first Serverpod Cloud deploy (you, with Claude)
1. Claude loads the `serverpod-deployment` skill and confirms the steps against it, in particular whether the Flutter web build (`flutter_build` script) runs automatically on deploy.
2. **You run** `serverpod cloud launch` from `plotwatch_server` and sign in through the browser (Starter trial):
   - Project ID: `plotwatch` (or `plotwatch-app` if taken).
   - Passwords: the custom ones from `config/passwords.yaml`.
3. **Check on the Cloud URL:**
   - sign up with your real email (the code arrives by email through Serverpod Cloud);
   - sign in, switch to French, sign out.
4. **Android against Cloud:** `flutter run --dart-define=SERVER_URL=https://<cloud-api-url>/`.
5. Claude adds a `flutter test` step to `.github/workflows/tests.yml`.
6. Updates: `00` §8 (M1 done), and `serverpod-feedback.md` (any new findings).

**M1 exit criterion** ([04 §4](04-implementation-plan.md#m1-foundation-d2)): on the Cloud URL, a new user can sign up, verify their email, sign in, set French and sign out. The Android debug build does the same against Cloud. All tests pass, and CI is green.
