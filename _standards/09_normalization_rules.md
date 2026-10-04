# Normalization Rules

Machine-readable enforcement rules derived from dominant codebase patterns.
All rules apply to every feature unless explicitly noted otherwise.

---

## Events

**RULE-001**
All BLoC event parameters MUST use typed named parameters.
NEVER pass `Map<String, dynamic>` as an event parameter.
Build payload maps inside the BLoC (via model static methods) or inside the Repository.

```dart
// CORRECT
const factory MyEvent.createItem(MyModel item) = _CreateItem;

// WRONG
const factory MyEvent.createItem(Map<String, dynamic> data) = _CreateItem;
```

**RULE-002**
All event classes MUST use `@freezed` with private generated constructors (`= _Name`).

**RULE-003**
Every CRUD BLoC MUST include these standard events:
`.init()`, `.reset()`, `.resetFlowStep()`, `.refresh{Items}()`.

---

## State

**RULE-004**
Every BLoC state MUST include `GenericFlowStep flowStep` when the feature performs any CRUD operation.

**RULE-005**
Every BLoC state MUST include `bool refreshController` to signal the DataSource to refresh.
Toggle it with `!state.refreshController` — never set it to a hardcoded `true`.

**RULE-006**
Status fields MUST be feature-scoped. Use one `GenericStatus` field per independent operation group.

```dart
// CORRECT
GenericStatus absenceStatus           // list
GenericStatus absenceActionStatus     // create/update/delete

// WRONG
GenericStatus status
GenericStatus isLoading
```

**RULE-007**
Error message fields MUST mirror their corresponding status field and be `String?`.

```dart
String? absenceListErrorMessage    // paired with absenceStatus
String? absenceActionErrorMessage  // paired with absenceActionStatus
```

---

## BLoC Handlers

**RULE-008**
Every BLoC handler MUST follow the 5-step pattern:
1. `emit(state.copyWith(xyzStatus: GenericStatus.loading))`
2. `await _repository.method(...)`
3. `emit(state.copyWith(xyzStatus: GenericStatus.success, ...))`
4. `emit failure if result is null`
5. `on HttpException400` catch, then generic `catch (e)` with `log()`

**RULE-009**
Handlers MUST catch `HttpException400` explicitly before the generic `catch (e)`.

```dart
} on HttpException400 catch (e) {
  emit(state.copyWith(xyzStatus: GenericStatus.failure, errorMessage: e.toString()));
} catch (e) {
  log('Error: $e');
  emit(state.copyWith(xyzStatus: GenericStatus.failure, ...));
}
```

**RULE-010**
Use `GenericStatus.filtering` (not `loading`) when a search term is active and data is already displayed.

**RULE-011**
After a successful CRUD action, flip `refreshController` to trigger DataSource refresh.
```dart
emit(state.copyWith(
  myFeatureActionStatus: GenericStatus.success,
  refreshController: !state.refreshController,
));
```

---

## Repository

**RULE-012**
Repository methods MUST always `log('Error: $e')` then `rethrow`. Never swallow exceptions.

**RULE-013**
Return types:
- List endpoint → `PaginatedList?` (null signals failure to BLoC)
- Create/Update endpoint → `Model?`
- Delete endpoint → `bool`

**RULE-014**
Error messages thrown from repository MUST use `LocalizationService.localization.*`.
NEVER throw with hardcoded strings.

---

## API Provider

**RULE-015**
All API provider methods MUST catch only `DioException` and re-throw via `ApiErrorHandler.handle(e)`.

```dart
} on DioException catch (e) {
  throw ApiErrorHandler.handle(e);
}
```

**RULE-016**
Optional query parameters MUST strip nulls before sending:
```dart
queryParameters: {
  'keyword': keyword,
  'size': size,
}..removeWhere((key, value) => value == null)
```

**RULE-017**
POST/PUT request bodies MUST be encoded with `jsonEncode(data)`.
File uploads MUST use `FormData.fromMap({...data, 'field': MultipartFile.fromBytes(...)})`.

---

## Models

**RULE-018**
ALL domain models MUST use `@freezed`.

**RULE-019**
Models that require computed getters or instance methods MUST declare a private constructor:
```dart
const MyModel._();
```

**RULE-020**
Payload creation MUST use static methods on the model class.
```dart
// CORRECT — build in BLoC using model's static method
final payload = MyModel.createPayload(event.item);
await _repository.createMyModel(payload);

// WRONG — build in UI layer
final payload = {'name': _nameController.text, 'code': _codeController.text};
bloc.add(MyEvent.createMyModel(payload));
```

**RULE-021**
`fromJson` must use `int.tryParse(json['field'].toString())` for integer fields.
API responses may return numbers as strings.

**RULE-022**
Use `convertJsonDate(json['field'])` for ALL DateTime fields. Never use `DateTime.parse()` directly.

**RULE-023**
Enums that map to/from API strings MUST implement:
- `fromString(String? value)` — for deserialization
- `toStringValue()` — for serialization
- `label(AppLocalizations l10n)` — for display

---

## UI

**RULE-024**
Before calling `showDialog()`, ALWAYS capture the root context:
```dart
final rootContext = Navigator.of(context, rootNavigator: true).context;
showDialog(context: rootContext, ...);
```

**RULE-025**
ALWAYS check `context.mounted` after any `async` gap before accessing context.

**RULE-026**
ALL `DropdownButtonFormField` widgets MUST include `isExpanded: true`.

**RULE-027**
Search input MUST be debounced at exactly `500ms` using `Timer`.
On search change: cancel previous timer, start new 500ms timer, then trigger BLoC event.

**RULE-028**
DataTable2 refresh MUST use `UniqueKey()` replacement on the `key` parameter:
```dart
setState(() {
  _tableKey = UniqueKey();
  _initDataSource();
});
```

**RULE-029**
`BlocConsumer` MUST use `listenWhen` and `buildWhen` selectors. Never listen/build on full state changes.

**RULE-030**
Dialog loading state MUST use `ModalProgressHUD` wrapping the `AlertDialog`.
`inAsyncCall` MUST be driven by `flowStep`, not by a status field.
```dart
ModalProgressHUD(
  inAsyncCall: state.flowStep == GenericFlowStep.creatingItem,
  child: AlertDialog(...),
)
```

**RULE-031**
After success/failure in a dialog listener, ALWAYS use `DialogUtils.handleSuccess` or `DialogUtils.handleFailure`.
Include `postActions` to reset flowStep and trigger refresh.

**RULE-032**
Dialog content layout:
- `contentPadding: EdgeInsets.zero` on `AlertDialog`
- Top divider: `Divider(thickness: 2, height: 2)`
- Bottom divider: `Divider(thickness: 1.5, height: 1.5)`
- Inner content in `Padding(padding: EdgeInsets.all(16))`

---

## Localization

**RULE-033** — See [12_internationalization.md](12_internationalization.md)

ALL user-facing strings MUST come from `LocalizationService.localization.*` or `AppLocalizations.of(context)!`.
NEVER use hardcoded French or English strings anywhere (pages, BLoCs, repositories, utils).

Workflow:
1. Add key & English translation to `app_en.arb`
2. Add French translation to `app_fr.arb`
3. Run `make i18n`
4. Use `l10n.*` in widgets or `LocalizationService.localization.*` in non-UI code

---

## Routing

**RULE-034**
Every new page MUST have:
- A route name constant in `route_names.dart`
- A path constant in `route_names.dart`
- A `GoRoute` entry using `NoTransitionPage` in `route_manager.dart`

---

## DataSource

**RULE-035**
DataSources MUST extend `AsyncDataTableSource`.
Page index MUST be calculated as: `final pageKey = startIndex ~/ count`.
MUST use `Completer` + BLoC stream subscription pattern (never `await` BLoC directly).
MUST cancel `_subscription` in `dispose()`.
