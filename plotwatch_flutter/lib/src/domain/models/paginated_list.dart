import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_list.freezed.dart';

/// One page of a list, as the infinite-scroll BLoCs of `_standards/13` use
/// it. Repositories build it from a generated page model (`_standards/14`
/// §3.2).
@freezed
abstract class PaginatedList<T> with _$PaginatedList<T> {
  const factory PaginatedList({
    required List<T> content,
    required Pagination pagination,
  }) = _PaginatedList<T>;
}

@freezed
abstract class Pagination with _$Pagination {
  /// [size] is the page size the server actually used.
  const factory Pagination({int? size}) = _Pagination;
}
