# Mobile Pagination — Infinite Scroll (PagingController)

> **This document supersedes `02_bloc_patterns.md` / `06_ui_patterns.md` for paginated lists in this project.**
>
> Those two documents were forensically generated from a **web project** (Extension Sage Paie) that displays paginated data in a fixed-bottom-widget `DataTable2`/`AsyncPaginatedDataTable2`, where the user can pick a page size (10/20/50) and jump between page numbers — hence `pageSize`/`totalCount`/`AsyncDataTableSource` exist in that pattern.
>
> **SmartDrive Terminal is a mobile app.** Paginated lists are displayed as **infinite-scroll feeds** via the `infinite_scroll_pagination` package (`PagingController` + `CustomPaginatedList`). There is no adjustable page size, no page-number widget, no `DataTableSource`. Follow **this** document for any paginated list in this app.
>
> **Canonical reference implementation:** `VoyageBloc` (`features/voyage/bloc/`) + `PassagersTab`/`ColisTab` (`features/voyage/views/tabs/`). Reference UI source: `doc/article_list_page.md`.

---

## When to use this pattern

Any list of items fetched page-by-page from a paginated backend endpoint (`PaginatedList` / `{pagination, content}` shape) and displayed as a scrollable feed on mobile. Examples in this app: passengers and parcels of a voyage.

If you are building a **web-only** admin/back-office screen with a `DataTable2`, use `02_bloc_patterns.md`/`06_ui_patterns.md` instead — but note that *this* project is mobile-first, so that scenario should be rare here.

---

## Event Pattern

```dart
// {feature}_event.dart
part of '{feature}_bloc.dart';

@freezed
class MyFeatureEvent with _$MyFeatureEvent {
  /// Fetches a page of items for the currently selected parent entity
  /// (read internally from `state.selectedParent`/`.id` — do NOT pass it
  /// as a parameter; the bloc already has it).
  const factory MyFeatureEvent.fetchMyItems({
    @Default(0) int pageKey,
    String? searchTerm,
    MyItemStatut? statutFilter,   // only if the UI exposes status filter chips
    int? size,
  }) = _FetchMyItems;

  const factory MyFeatureEvent.refreshMyItems() = _RefreshMyItems;
}
```

**Rules:**
- Named parameters only; `@Default(0) int pageKey` always present
- `String? searchTerm` for free-text search (sent as `keyword` to the backend)
- A typed `XxxStatut? statutFilter` ONLY if the tab has status filter chips — see "Filter chips" below for why this must be sent to the server, not applied locally
- **No `idVoyage`/parent-id parameter** — read it from `state.selectedXxx?.id` inside the handler (mirrors `_onFetchPassagers`/`_onFetchColis` reading `state.selectedVoyage?.idVoyage`)
- Always pair a `fetchXxx` event with a `refreshXxx` event

---

## State Pattern

```dart
// {feature}_state.dart
part of '{feature}_bloc.dart';

@freezed
sealed class MyFeatureState with _$MyFeatureState {
  const factory MyFeatureState({
    // ... other feature fields ...

    // --- MyItems (infinite-scroll pagination) ---
    @Default([]) List<MyItem> myItems,
    @Default([]) List<MyItem> paginatedMyItems,
    @Default(false) bool maxMyItems,
    @Default(false) bool myItemsRefreshController,
    @Default(0) int myItemsPageKey,
    @Default(GenericStatus.initial) GenericStatus myItemsListStatus,
    String? myItemsListError,
  }) = _MyFeatureState;
}
```

**Rules — what's DIFFERENT from `02_bloc_patterns.md`'s datatable template:**
- ❌ **NO `pageSize` field** — page size isn't user-adjustable in an infinite-scroll feed. If the repository call needs a `size`, pass it through the event (`event.size ?? _kFeaturePageSize` constant in the bloc) — never store it in state.
- ❌ **NO `totalCount`/`totalElement` field** — nothing in the infinite-scroll UI displays a total count or page-number widget. Don't add it "just in case" (YAGNI).
- ✅ **`bool xxxRefreshController`** — required. Flipping it to `true` signals the UI to call `_pagingController.refresh()` (see UI section). This is the infinite-scroll equivalent of the datatable's `refreshController` from `02_bloc_patterns.md`, but is per-list (e.g. `passagerRefreshController`, `colisRefreshController`) since a screen may host multiple independent paginated lists (tabs).
- ✅ Keep `paginatedXxx` (the latest page only — handed to `appendPage`/`appendLastPage`), `maxXxx` (whether the latest page was short, i.e. last page), `xxxPageKey` (current page index), `xxxListStatus`/`xxxListError` (per-list `GenericStatus`/error, independent of other operations on the same bloc)

---

## BLoC Handler Pattern (5-step — same backbone as `02_bloc_patterns.md`, adapted)

```dart
const _kFeaturePageSize = 20;

Future<void> _onFetchMyItems(
    _FetchMyItems event, Emitter<MyFeatureState> emit) async {
  final l10n = LocalizationService.localization;
  final parentId = state.selectedParent?.id;
  if (parentId == null) return;

  // STEP 1: Emit loading/filtering — ALWAYS reset the refresh controller to
  // false here (it gets flipped back to true only by _onRefreshMyItems).
  emit(state.copyWith(
    myItemsListStatus: event.searchTerm != null
        ? GenericStatus.filtering
        : GenericStatus.loading,
    myItemsListError: null,
    myItems: event.pageKey == 0 ? [] : state.myItems,
    myItemsRefreshController: false,
  ));

  try {
    // STEP 2: Call repository — pass through searchTerm/statutFilter/size
    final result = await _repository.fetchMyItems(
      parentId,
      event.pageKey,
      keyword: event.searchTerm,
      statut: event.statutFilter?.toStringValue(),
      size: event.size ?? _kFeaturePageSize,
    );

    if (result == null) {
      emit(state.copyWith(
        myItemsListStatus: GenericStatus.failure,
        myItemsListError: l10n.myItemsListError,
      ));
      return;
    }

    // STEP 3: Emit success — `max` is derived from the ACTUAL page size the
    // backend echoes back (`result.pagination.size`), not the requested size,
    // since the backend may clamp/ignore it.
    final newItems = List<MyItem>.from(result.content);
    emit(state.copyWith(
      myItemsListStatus: GenericStatus.success,
      paginatedMyItems: newItems,
      maxMyItems: newItems.length < result.pagination.size!,
      myItemsPageKey: event.pageKey,
      myItems: event.pageKey == 0 ? newItems : [...state.myItems, ...newItems],
    ));
  } on HttpException400 catch (e) {
    emit(state.copyWith(myItemsListStatus: GenericStatus.failure, myItemsListError: e.toString()));
  } on HttpException401 catch (_) {
    emit(state.copyWith(myItemsListStatus: GenericStatus.failure, myItemsListError: l10n.errorUnauthorized));
  } on NetworkException catch (_) {
    emit(state.copyWith(myItemsListStatus: GenericStatus.failure, myItemsListError: l10n.networkError));
  } catch (e) {
    log('MyFeatureBloc._onFetchMyItems error: $e');
    emit(state.copyWith(myItemsListStatus: GenericStatus.failure, myItemsListError: l10n.myItemsListError));
  }
}

// STEP 5: Refresh — reset list/page state to zero AND flip the controller to
// `true`. The UI's BlocConsumer.listener sees the flip and calls
// `_pagingController.refresh()`, which re-triggers `addPageRequestListener`
// with pageKey == 0, which dispatches `fetchMyItems` again (and that handler
// flips the controller back to `false` on its loading emit — see STEP 1).
void _onRefreshMyItems(_RefreshMyItems event, Emitter<MyFeatureState> emit) {
  emit(state.copyWith(
    myItemsListStatus: GenericStatus.initial,
    myItems: [],
    paginatedMyItems: [],
    myItemsPageKey: 0,
    maxMyItems: false,
    myItemsRefreshController: true,
  ));
}
```

**Key differences from the datatable 5-step handler:**
- `max*` is computed from `result.pagination.size` (what the backend actually returned), not from `state.pageSize` (doesn't exist here)
- The loading emit always sets `*RefreshController: false`; the refresh handler always sets it `true` — this ping-pong is what drives `_pagingController.refresh()` exactly once per refresh request without infinite loops

---

## UI Consumption Pattern (`PagingController` + `CustomPaginatedList`)

**Location:** `lib/src/features/{feature}/views/{tab_or_screen}.dart` — must be a `StatefulWidget` (the `PagingController` and debounce `Timer` need lifecycle management).

```dart
class MyItemsTab extends StatefulWidget {
  const MyItemsTab({super.key, required this.l10n});
  final AppLocalizations l10n;
  @override
  State<MyItemsTab> createState() => _MyItemsTabState();
}

class _MyItemsTabState extends State<MyItemsTab> {
  final PagingController<int, MyItem> _pagingController =
      PagingController(firstPageKey: 0);
  Timer? _debounce;
  String? _searchTerm;
  MyItemStatut? _filter;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<MyFeatureBloc>().add(MyFeatureEvent.fetchMyItems(
          pageKey: pageKey,
          searchTerm: _searchTerm,
          statutFilter: _filter,
        ));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _pagingController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() => _searchTerm = value.isEmpty ? null : value);
      context.read<MyFeatureBloc>().add(const MyFeatureEvent.refreshMyItems());
    });
  }

  void _onFilterChanged(MyItemStatut? statut) {
    setState(() => _filter = statut);
    context.read<MyFeatureBloc>().add(const MyFeatureEvent.refreshMyItems());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return BlocConsumer<MyFeatureBloc, MyFeatureState>(
      listenWhen: (prev, curr) =>
          prev.myItemsListStatus != curr.myItemsListStatus ||
          prev.myItemsRefreshController != curr.myItemsRefreshController,
      listener: (context, state) {
        if (state.myItemsRefreshController) {
          _pagingController.refresh();
          return;
        }
        if (state.myItemsListStatus == GenericStatus.success) {
          if (state.maxMyItems) {
            _pagingController.appendLastPage(state.paginatedMyItems);
          } else {
            _pagingController.appendPage(state.paginatedMyItems, state.myItemsPageKey + 1);
          }
        } else if (state.myItemsListStatus == GenericStatus.failure) {
          _pagingController.error = state.myItemsListError ?? l10n.myItemsListError;
        }
      },
      builder: (context, state) => RefreshIndicator(
        onRefresh: () async =>
            context.read<MyFeatureBloc>().add(const MyFeatureEvent.refreshMyItems()),
        child: Column(
          children: [
            SearchInputField(onChanged: _onSearchChanged, labelText: l10n.myItemsSearchHint),
            _FilterChips(selected: _filter, onChanged: _onFilterChanged, l10n: l10n),
            Expanded(
              child: CustomPaginatedList<MyItem>(
                pagingController: _pagingController,
                seperator: const Gap.vertical(height: 12),
                pagedChildBuilderDelegate: PagedChildBuilderDelegate<MyItem>(
                  itemBuilder: (context, item, index) => MyItemCard(item: item),
                  firstPageProgressIndicatorBuilder: (context) => LoadingWidget(loadingText: l10n.loading),
                  newPageProgressIndicatorBuilder: (context) =>
                      const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator.adaptive())),
                  firstPageErrorIndicatorBuilder: (context) => ErrorrWidget(
                    errorMessage: _pagingController.error?.toString() ?? l10n.myItemsListError,
                    refreshText: l10n.refresh,
                    onPressed: () => _pagingController.refresh(),
                  ),
                  newPageErrorIndicatorBuilder: (context) => ErrorrWidget(
                    errorMessage: _pagingController.error?.toString() ?? l10n.myItemsListError,
                    refreshText: l10n.refresh,
                    onPressed: () => _pagingController.retryLastFailedRequest(),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => EmptyWidget(
                    emptyText: (_searchTerm != null || _filter != null)
                        ? l10n.myItemsSearchEmptyState
                        : l10n.myItemsEmptyState,
                    onPressed: () => _pagingController.refresh(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Rules:**
- `listenWhen` compares **both** `xxxListStatus` and `xxxRefreshController` — missing the latter means refresh-triggered reloads silently no-op
- The listener checks `xxxRefreshController` FIRST and returns early — don't fall through to the success/failure branches on a refresh tick
- `appendLastPage` vs `appendPage(..., pageKey + 1)` is decided by `state.maxXxx`, exactly like `article_list_page.md`
- Search uses a debounced `Timer` (no `CancelableOperation`/`package:async` needed for these simpler tabs — only add it if a feature genuinely needs to cancel in-flight requests)
- `RefreshIndicator.onRefresh` and pull actions just dispatch `refreshXxx()` — they do NOT call `_pagingController.refresh()` directly; that happens via the `xxxRefreshController` flip in the listener (single source of truth, avoids double-fetches)

---

## Filter chips — MUST be server-side, not local

`VoyagesDuJourScreen`'s `_FilterChips` filters an already **fully-loaded** `state.voyages` list client-side — that's fine there because that list isn't paginated.

**For an infinite-scroll list, do NOT filter `state.myItems` locally in the UI.** The visible list is only a partial window of the backend's full result set; local filtering produces wrong empty/end states, broken "load more" triggers, and partial/missing pages.

Instead, send the selected filter to the backend as a query parameter and let pagination work on the *filtered* server-side result set:

1. Add `XxxStatut? statutFilter` to the fetch event (see Event Pattern above)
2. Add a matching `String? statut` param to the `ApiProvider`/`Repository` methods, sent as a query param via `.toStringValue()`
3. Selecting a chip calls `setState` (to remember the selection for subsequent page requests) **and** dispatches `refreshXxx()` — exactly like a search-term change — so the list resets and re-fetches page 0 with the new filter applied server-side

See `PassagersTab`/`ColisTab` + `VoyageEvent.fetchPassagers`/`fetchColis` (`statutFilter` param) + `VoyageApiProvider.fetchPassagers`/`fetchColis` (`statut` query param) for the working reference.

---

## Setup checklist for a new paginated mobile list

1. Confirm `infinite_scroll_pagination` is in `pubspec.yaml` (it is, as of the Module 2/3 work) and `CustomPaginatedList` is uncommented in `shared/components/custom_paginated_list.dart`
2. Repository/ApiProvider method returns `Future<PaginatedList?>` wrapping `{pagination, content}`
3. Add the `fetchXxx`/`refreshXxx` event pair (Event Pattern)
4. Add the seven `xxx*` state fields — no `pageSize`/`totalCount` (State Pattern)
5. Add the `_onFetchXxx`/`_onRefreshXxx` handlers, register both in the bloc constructor (Handler Pattern)
6. Build the tab/screen as a `StatefulWidget` with `PagingController` + `CustomPaginatedList` (UI Pattern)
7. If there are status filter chips, wire them server-side from day one (Filter chips section) — retrofitting it later means touching the event, state read-paths, repository, and API provider all at once