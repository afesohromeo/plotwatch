import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.emptyText,
    required this.onPressed,
    this.parentContext,
  });
  final String emptyText;
  final VoidCallback onPressed;
  final BuildContext? parentContext;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emptyText,
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium!
                  .copyWith(fontSize: 14, height: 2, wordSpacing: 2),
            ),
            const Gap.vertical(
              height: 15,
            ),
            TextButton(
                onPressed: onPressed,
                child: Text(
                  AppLocalizations.of(parentContext ?? context)!.refresh,
                  style: context.textTheme.displayLarge!.copyWith(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
