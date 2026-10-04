# Architecture — Extension Sage Paie

## Overview

This project uses **Clean Architecture + flutter_bloc** with a strict 4-layer separation.
The pattern is consistent across all 93 feature directories.

---

## Layer Flow

```
UI Layer        (lib/src/features/{feature}/views/)
      |  add(Event)  ^  State updates
      v              |
BLoC Layer      (lib/src/features/{feature}/bloc/)
      |  call repo   ^  return model / throw
      v              |
Repository      (lib/src/domain/repository/)
      |  call API    ^  AppApiResponse
      v              |
API Provider    (lib/src/data/api/{domain}/)
                     ^  Dio HTTP
```

**Rules:**
- UI NEVER calls repositories directly
- Repositories NEVER call other repositories
- BLoCs NEVER call other BLoCs
- API providers NEVER contain business logic

---

## Root Folder Structure

```
lib/src/
├── core/                        # App bootstrap, routing, layout
│   ├── routing/                 # GoRouter config + route names
│   │   ├── route_manager.dart
│   │   ├── route_names.dart
│   │   └── app_drawer.dart
│   ├── layout/                  # Responsive layout helpers
│   │   └── responsive_layout.dart
│   ├── application.dart         # Root MaterialApp widget
│   └── app_initializer.dart     # Startup initialization
│
├── data/                        # HTTP layer only
│   └── api/
│       ├── config/              # Dio instance, interceptor, error handler
│       │   ├── api_provider.dart
│       │   ├── dio_interceptor.dart
│       │   └── api_error_handler.dart
│       ├── absences/
│       ├── dashboard/
│       ├── gestion_des_temps/
│       ├── parametrage/
│       └── others/
│
├── domain/                      # Models + Repository classes
│   ├── models/
│   │   ├── shared models/       # AppApiResponse, PaginatedList, Data, Pagination
│   │   └── {feature}.dart       # One file per domain model
│   └── repository/              # 16 concrete repository classes
│       └── {feature}_repository.dart
│
├── features/                    # Feature modules (UI + BLoC)
│   ├── authentication/
│   ├── dashboard/
│   ├── gestion des absences/
│   ├── gestion des ouvriers/
│   ├── gestion des temps/
│   └── parametrage/
│
└── shared/                      # Cross-feature utilities
    ├── bloc/                    # FileUploadBloc (shared)
    ├── components/              # 30+ reusable widgets
    ├── extensions/              # Dart extensions (context, iterable, router)
    └── utils/                   # DialogUtils, constants, helpers
```

---

## Key Infrastructure Files

| File | Purpose |
|------|---------|
| `data/api/config/api_provider.dart` | Holds the Dio instance (`dioExtSagePaie`) |
| `data/api/config/dio_interceptor.dart` | Attaches auth token, tenant ID, synchro header |
| `data/api/config/api_error_handler.dart` | Converts `DioException` → typed exceptions |
| `domain/models/shared models/app_api_response.dart` | Universal HTTP response wrapper |
| `shared/utils/constant.dart` | `customColors`, `formatDateForApi()`, `convertJsonDate()` |
| `shared/utils/dialog_utils.dart` | `DialogUtils.handleSuccess/handleFailure` |
| `core/routing/route_manager.dart` | GoRouter with auth guard |
| `core/routing/route_names.dart` | All route name constants |

---

## Exception Types

| Exception | When thrown |
|-----------|-------------|
| `HttpException400` | HTTP 4xx responses from API |
| `SpecialCase410Exception` | HTTP 410 — special business case |
| `DioException` (re-wrapped) | All other network failures via `ApiErrorHandler.handle(e)` |

BLoC handlers MUST catch `HttpException400` explicitly before the generic `catch (e)`.
