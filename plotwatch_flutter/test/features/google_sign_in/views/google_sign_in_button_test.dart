import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04g-m8-hardening.md, step 4 (AUTH-04).
void main() {
  late AppLocalizations l10n;
  late MockGoogleSignInBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const GoogleSignInEvent.reset());
  });
  setUp(() => bloc = MockGoogleSignInBloc());

  Future<void> pump(WidgetTester tester, GoogleSignInState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<GoogleSignInBloc>.value(
        value: bloc,
        child: const Scaffold(body: GoogleSignInButton()),
      ),
    );
  }

  testWidgets('Given Google is configured when the button is tapped then it '
      'starts the sign-in with the app language', (tester) async {
    await pump(tester, const GoogleSignInState(isAvailable: true));

    expect(find.text(l10n.continueWithGoogle), findsOneWidget);
    await tester.tap(find.byKey(GoogleSignInButton.buttonKey));
    await tester.pump();

    verify(
      () => bloc.add(GoogleSignInEvent.started(locale: l10n.localeName)),
    ).called(1);
  });

  testWidgets('Given Google is not configured then no button shows', (
    tester,
  ) async {
    await pump(tester, const GoogleSignInState());

    expect(find.byKey(GoogleSignInButton.buttonKey), findsNothing);
  });

  testWidgets('Given a sign-in error then its message shows', (tester) async {
    whenListen(
      bloc,
      Stream.value(
        GoogleSignInState(
          isAvailable: true,
          status: GenericStatus.failure,
          errorMessage: l10n.errorGoogleSignIn,
        ),
      ),
      initialState: const GoogleSignInState(isAvailable: true),
    );
    await tester.pumpApp(
      BlocProvider<GoogleSignInBloc>.value(
        value: bloc,
        child: const Scaffold(body: GoogleSignInButton()),
      ),
    );
    // The error dialog opens after 200 ms, then closes by itself.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(l10n.errorGoogleSignIn), findsOneWidget);
    // Let the dialog close itself (10 s).
    await tester.pumpAndSettle(const Duration(seconds: 11));
  });
}
