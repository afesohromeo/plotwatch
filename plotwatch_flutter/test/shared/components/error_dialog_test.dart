import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Spec: doc/05-design-system.md §5, error dialog.
void main() {
  late AppLocalizations l10n;

  setUpAll(() => l10n = setUpTestLocalization());

  Future<void> openDialog(WidgetTester tester) async {
    await tester.pumpApp(
      Builder(
        builder: (context) => TextButton(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (_) => ErrorDialog(
              message: 'Wrong email or password.',
              parentContext: context,
            ),
          ),
          child: const Text('open'),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'Given an error dialog when shown then it has the error icon, the '
    'message and an OK button',
    (tester) async {
      await openDialog(tester);

      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
      expect(find.text('Wrong email or password.'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, l10n.ok), findsOneWidget);
    },
  );

  testWidgets(
    'Given an error dialog when shown then the cross is centred in its '
    'circle and the circle is centred in the dialog',
    (tester) async {
      await openDialog(tester);

      final cross = tester.getCenter(find.byIcon(Icons.close_rounded));
      final circle = tester.getCenter(find.byKey(StatusDialog.iconCircleKey));
      final button = tester.getCenter(
        find.widgetWithText(FilledButton, l10n.ok),
      );

      expect(cross.dx, moreOrLessEquals(circle.dx, epsilon: 0.5));
      expect(cross.dy, moreOrLessEquals(circle.dy, epsilon: 0.5));
      // The button spans the dialog's width, so its centre is the dialog's.
      expect(circle.dx, moreOrLessEquals(button.dx, epsilon: 0.5));
    },
  );

  testWidgets('Given an error dialog when OK is tapped then it closes', (
    tester,
  ) async {
    await openDialog(tester);

    await tester.tap(find.widgetWithText(FilledButton, l10n.ok));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorDialog), findsNothing);
  });
}
