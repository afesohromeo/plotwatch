import 'package:flutter/widgets.dart';

/// Calls [onReturn] when its page becomes the top page again, after the page
/// above it was closed (Back, or going to this page's address). With nested
/// routes the page below stays alive, so without this it would show what it
/// loaded before (doc/04b H-1a). Not called when the page is first shown.
/// A dialog or menu opened on the page counts as a page above it, so closing
/// one also reloads: one extra request, accepted to keep this simple.
class ReloadOnReturn extends StatefulWidget {
  const ReloadOnReturn({
    super.key,
    required this.onReturn,
    required this.child,
  });

  final VoidCallback onReturn;
  final Widget child;

  @override
  State<ReloadOnReturn> createState() => _ReloadOnReturnState();
}

class _ReloadOnReturnState extends State<ReloadOnReturn> {
  bool? _wasCurrent;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Rebuilds this widget whenever the route's "is on top" status changes.
    final isCurrent = ModalRoute.isCurrentOf(context) ?? true;
    if (_wasCurrent == false && isCurrent) widget.onReturn();
    _wasCurrent = isCurrent;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
