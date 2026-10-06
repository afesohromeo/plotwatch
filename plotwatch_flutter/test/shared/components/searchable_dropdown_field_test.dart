import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() => setUpTestLocalization());

  Future<List<String?>> pumpField(WidgetTester tester, {String? selected}) async {
    final changes = <String?>[];
    await tester.pumpApp(Scaffold(
      body: SearchableDropdownField<String>(
        key: const Key('field'),
        items: const ['XAF', 'EUR'],
        selectedValue: selected,
        itemToString: (item) => item,
        onChanged: changes.add,
        labelText: 'Currency',
      ),
    ));
    return changes;
  }

  testWidgets(
      'Given the dropdown when an item is chosen then it is passed on',
      (tester) async {
    final changes = await pumpField(tester);

    await tester.tap(find.byKey(const Key('field')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('EUR').last);
    await tester.pumpAndSettle();

    expect(changes, ['EUR']);
  });

  testWidgets(
      'Given a chosen item when the sheet is dismissed without choosing then '
      'the selection stays', (tester) async {
    final changes = await pumpField(tester, selected: 'XAF');

    await tester.tap(find.byKey(const Key('field')));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(changes, isEmpty);
  });
}
