# Folder Structure & Naming Conventions

## Per-Feature Folder Structure

Every feature follows this exact layout:

```
features/{feature_name}/
├── bloc/
│   ├── {feature}_bloc.dart
│   ├── {feature}_event.dart
│   ├── {feature}_state.dart
│   └── {feature}_bloc.freezed.dart   (generated)
├── views/
│   ├── {feature}_page.dart           (main list/detail page)
│   └── widgets/
│       ├── {feature}_dialog.dart     (create/update modal)
│       ├── {feature}_delete_dialog.dart
│       └── {feature}_tile.dart       (DataRow builder)
└── data_sources/
    └── {feature}_data_source.dart    (AsyncDataTableSource subclass)
```

Shared data layers (one per domain group, not per feature):

```
data/api/{domain}/
└── {feature}_api_provider.dart

domain/
├── models/
│   └── {feature}.dart                (Freezed model)
└── repository/
    └── {feature}_repository.dart
```

---

## File Naming Rules

All files use **snake_case**.

| Suffix | Layer | Example |
|--------|-------|---------|
| `_bloc.dart` | BLoC | `absence_bloc.dart` |
| `_event.dart` | BLoC | `absence_event.dart` |
| `_state.dart` | BLoC | `absence_state.dart` |
| `_repository.dart` | Domain | `absence_repository.dart` |
| `_api_provider.dart` | Data | `absence_api_provider.dart` |
| `_page.dart` | UI | `absence_list_page.dart` |
| `_dialog.dart` | UI | `create_update_absence_dialog.dart` |
| `_tile.dart` | UI | `absence_tile.dart` |
| `_data_source.dart` | UI | `absence_data_source.dart` |
| `_extensions.dart` | Shared | `context_extensions.dart` |
| `_utils.dart` | Shared | `dialog_utils.dart` |
| `_constants.dart` | Shared | `app_constants.dart` |

---

## Class Naming Rules

All classes use **PascalCase**.

| Pattern | Example |
|---------|---------|
| `{Feature}Bloc` | `AbsenceBloc`, `DepartmentBloc` |
| `{Feature}Event` | `AbsenceEvent`, `DepartmentEvent` |
| `{Feature}State` | `AbsenceState`, `DepartmentState` |
| `{Feature}Repository` | `AbsenceRepository`, `DepartmentRepository` |
| `{Feature}ApiProvider` | `AbsenceApiProvider`, `DepartmentApiProvider` |
| `{Feature}Page` | `AbsenceListPage`, `DepartmentListPage` |
| `{Feature}Dialog` | `CreateUpdateAbsenceDialog`, `DeleteDepartmentDialog` |
| `{Feature}Tile` | `AbsenceTile`, `DepartmentTile` |
| `{Feature}DataSource` | `AbsenceDataSource`, `DepartmentDataSource` |
| Model name | `Absence`, `Department`, `Employe` (no suffix) |

---

## Event Factory Method Naming

| Method | Purpose |
|--------|---------|
| `.init()` | Initialize / load initial data |
| `.fetch{Items}(...)` | Fetch/paginate list |
| `.refresh{Items}()` | Trigger refresh of existing list |
| `.select{Item}(item)` | Set selected item for detail view |
| `.create{Item}(item)` | Create new record |
| `.update{Item}(item)` | Update existing record |
| `.delete{Item}(item)` | Delete record |
| `.resetFlowStep()` | Clear flowStep + action status |
| `.reset()` | Reset full state to initial |

---

## BLoC Handler Naming

```
_on{EventName}(_PrivateEventType event, Emitter<State> emit)
```

Examples:
```dart
_onInit(_Init event, Emitter<AbsenceState> emit)
_onFetchAbsences(_FetchAbsences event, Emitter<AbsenceState> emit)
_onCreateAbsence(_CreateAbsence event, Emitter<AbsenceState> emit)
_onDeleteAbsence(_DeleteAbsence event, Emitter<AbsenceState> emit)
_onResetFlowStep(_ResetFlowStep event, Emitter<AbsenceState> emit)
_onReset(_Reset event, Emitter<AbsenceState> emit)
```

---

## State Field Naming

Status fields are **feature-scoped** — never generic:

```dart
// CORRECT — scoped to operation
GenericStatus absenceStatus           // list fetching
GenericStatus absenceDetailStatus     // single item detail
GenericStatus absenceActionStatus     // create/update/delete

// WRONG — too generic
GenericStatus status
GenericStatus loadingStatus
```

Error message fields mirror status fields:

```dart
String? absenceListErrorMessage
String? absenceDetailErrorMessage
String? absenceActionErrorMessage
```

List fields:
```dart
List<Absence> absences           // Full accumulated list (infinite scroll)
List<Absence> paginatedAbsences  // Current page only (fed to DataSource)
```
