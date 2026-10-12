import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPaginatedGridList<T> extends StatelessWidget {
  const CustomPaginatedGridList({
    super.key,
    required this.pagingController,
    required this.pagedChildBuilderDelegate,
    required this.gridDelegate,
    this.pageKey,
    this.wrap = false,
    this.physics,
    this.showNoMoreItemsIndicatorAsGridChild = false,
    this.padding,
  });
  final PagingController<int, T> pagingController;
  final PagedChildBuilderDelegate<T> pagedChildBuilderDelegate;
  final SliverGridDelegate gridDelegate;
  final PageStorageKey? pageKey;
  final bool wrap;
  final ScrollPhysics? physics;
  final bool showNoMoreItemsIndicatorAsGridChild;

  /// Room around the items, e.g. below the last one for a floating button.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, T>(
      padding: padding,
      physics: physics,
      shrinkWrap: wrap,
      pagingController: pagingController,
      gridDelegate: gridDelegate,
      builderDelegate: pagedChildBuilderDelegate,
      showNoMoreItemsIndicatorAsGridChild: showNoMoreItemsIndicatorAsGridChild,
      // key: pageKey,
    );
  }
}

// typedef FetchPageCallback<T> = Future<List<T>> Function(int pageKey);
