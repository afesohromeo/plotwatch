import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late AppLocalizations l10n;
  late MockProfileBloc profileBloc;
  late MockAuthenticationBloc authBloc;

  final profile = MyProfile(
    fullName: 'Ada Lovelace',
    email: 'ada@example.com',
    countryCode: 'CM',
    locale: 'fr',
  );

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const ProfileEvent.reset());
  });

  setUp(() {
    profileBloc = MockProfileBloc();
    authBloc = MockAuthenticationBloc();
    when(() => authBloc.state).thenReturn(
        const AuthenticationState(status: AuthenticationStatus.authenticated));
  });

  Future<void> pumpPage(WidgetTester tester, ProfileState state) {
    when(() => profileBloc.state).thenReturn(state);
    return tester.pumpApp(MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(value: profileBloc),
        BlocProvider<AuthenticationBloc>.value(value: authBloc),
      ],
      child: const ProfilePage(),
    ));
  }

  final loaded =
      ProfileState(profileStatus: GenericStatus.success, profile: profile);

  testWidgets('Given the profile is loading then it shows a progress indicator',
      (tester) async {
    await pumpPage(tester, const ProfileState(profileStatus: GenericStatus.loading));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'Given a loaded profile then it shows the name, email, country and '
      'language', (tester) async {
    await pumpPage(tester, loaded);

    expect(fieldText(tester, ProfilePage.nameFieldKey), 'Ada Lovelace');
    expect(find.text('ada@example.com'), findsOneWidget);
    expect(fieldText(tester, ProfilePage.countryFieldKey), contains('Cameroon'));
    final languages = tester.widget<SegmentedButton<String>>(
        find.byKey(ProfilePage.languageSelectorKey));
    expect(languages.selected, {'fr'});
  });

  testWidgets(
      'Given a loaded profile when the name and language change and it is '
      'saved then the new values are sent', (tester) async {
    await pumpPage(tester, loaded);

    await tester.enterText(find.byKey(ProfilePage.nameFieldKey), 'Ada King');
    await tester.tap(find.text(l10n.languageEnglish));
    await tester.pump();
    await tester.ensureVisible(find.byKey(ProfilePage.saveButtonKey));
    await tester.tap(find.byKey(ProfilePage.saveButtonKey));
    await tester.pump();

    verify(() => profileBloc.add(const ProfileEvent.updateMe(
          fullName: 'Ada King',
          countryCode: 'CM',
          locale: 'en',
        ))).called(1);
  });

  testWidgets('Given a loaded profile when the name is cleared then it is not saved',
      (tester) async {
    await pumpPage(tester, loaded);

    await tester.enterText(find.byKey(ProfilePage.nameFieldKey), '   ');
    await tester.ensureVisible(find.byKey(ProfilePage.saveButtonKey));
    await tester.tap(find.byKey(ProfilePage.saveButtonKey));
    await tester.pump();

    expect(find.text(l10n.validateNameRequired), findsOneWidget);
    verifyNever(() => profileBloc.add(any()));
  });
}
