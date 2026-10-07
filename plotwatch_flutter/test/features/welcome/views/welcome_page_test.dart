import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group E2 (E2-6).
void main() {
  late AppLocalizations l10n;

  setUpAll(() => l10n = setUpTestLocalization());

  testWidgets(
    'Given the welcome page then it shows the Plotwatch logo, labelled for '
    'screen readers',
    (tester) async {
      await tester.pumpApp(const WelcomePage());

      final logo = tester.widget<SvgPicture>(find.byKey(WelcomePage.logoKey));
      expect(logo.semanticsLabel, l10n.logoLabel);
      expect(find.text(l10n.appTitle), findsOneWidget);
    },
  );
}
