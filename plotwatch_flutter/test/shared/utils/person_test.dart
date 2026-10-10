import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, fix C-2d.
void main() {
  final l10n = setUpTestLocalization();

  test('Given a current member then only the name is shown', () {
    expect(personLabel(l10n, 'Bob', former: false), 'Bob');
    expect(personLabel(l10n, 'Bob'), 'Bob');
  });

  test('Given someone who has left then they are marked former', () {
    expect(personLabel(l10n, 'Bob', former: true), l10n.formerMemberName('Bob'));
  });
}
