import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04c-m3-stages.md, decision M3-9: the budget is typed in the
// project currency and checked like the server checks it.
void main() {
  late AppLocalizations l10n;
  final formKey = GlobalKey<FormState>();
  const fieldKey = Key('test.money');

  setUpAll(() => l10n = setUpTestLocalization());

  Future<void> pump(WidgetTester tester, TextEditingController controller) =>
      tester.pumpApp(
        // A text field needs a Material ancestor; pages get it from their
        // scaffold.
        Material(
          child: Form(
            key: formKey,
            child: MoneyField(
              key: fieldKey,
              controller: controller,
              currencyCode: 'XAF',
              labelText: l10n.labelBudget,
            ),
          ),
        ),
      );

  testWidgets('Given the field then it shows the currency', (tester) async {
    await pump(tester, TextEditingController());

    expect(find.text('XAF'), findsOneWidget);
  });

  testWidgets('Given an amount when the form is checked then it passes', (
    tester,
  ) async {
    final controller = TextEditingController();
    await pump(tester, controller);

    await tester.enterText(find.byKey(fieldKey), '1,500,000');

    expect(formKey.currentState!.validate(), isTrue);
  });

  testWidgets('Given an empty field when the form is checked then it passes '
      '(no budget yet)', (tester) async {
    await pump(tester, TextEditingController());

    expect(formKey.currentState!.validate(), isTrue);
  });

  testWidgets('Given text that is not an amount when the form is checked '
      'then it says so', (tester) async {
    await pump(tester, TextEditingController());

    await tester.enterText(find.byKey(fieldKey), '12.5');
    final valid = formKey.currentState!.validate();
    await tester.pump();

    expect(valid, isFalse);
    expect(find.text(l10n.validateBudgetInvalid), findsOneWidget);
  });
}
