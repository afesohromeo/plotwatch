import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Success dialog of the design system (doc/05-design-system.md §5), shown
/// through `DialogUtils.handleSuccess`. Same layout as [ErrorDialog].
class Congratulations extends StatelessWidget {
  const Congratulations({
    super.key,
    required this.message,
    this.onPressed,
    this.refreshText,
    required this.parentContext,
  });

  final VoidCallback? onPressed;
  final String? refreshText;
  final String message;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return StatusDialog(
      icon: Icons.check_rounded,
      iconColor: customColors.verified,
      iconBackground: customColors.verifiedSoft,
      message: message,
      buttonLabel: refreshText,
      onPressed: onPressed,
    );
  }
}
