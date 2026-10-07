import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockCreateProjectBloc
    extends MockBloc<CreateProjectEvent, CreateProjectState>
    implements CreateProjectBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group E (PROJ-01, PROJ-08).
void main() {
  late AppLocalizations l10n;
  late MockCreateProjectBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const CreateProjectEvent.backToDetails());
  });
  setUp(() => bloc = MockCreateProjectBloc());

  Future<void> pumpAt(WidgetTester tester, CreateProjectState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<CreateProjectBloc>.value(
        value: bloc,
        child: const CreateProjectPage(),
      ),
    );
  }

  Future<void> choose(WidgetTester tester, Key field, String item) async {
    await tester.ensureVisible(find.byKey(field));
    await tester.tap(find.byKey(field));
    await tester.pumpAndSettle();
    await tester.tap(find.text(item).last);
    await tester.pumpAndSettle();
  }

  group('Given the details step', () {
    testWidgets(
      'when continued empty then it asks for the name, type and currency '
      'and sends nothing',
      (tester) async {
        await pumpAt(tester, const CreateProjectState());

        await tester.ensureVisible(
          find.byKey(ProjectDetailsForm.submitButtonKey),
        );
        await tester.tap(find.byKey(ProjectDetailsForm.submitButtonKey));
        await tester.pump();

        expect(find.text(l10n.validateProjectNameRequired), findsOneWidget);
        expect(find.text(l10n.validateProjectTypeRequired), findsOneWidget);
        expect(find.text(l10n.validateCurrencyRequired), findsOneWidget);
        verifyNever(() => bloc.add(any()));
      },
    );

    testWidgets('when filled and continued then the details go to the review', (
      tester,
    ) async {
      await pumpAt(tester, const CreateProjectState());

      await tester.enterText(
        find.byKey(ProjectDetailsForm.nameFieldKey),
        '  House in Bafoussam ',
      );
      await tester.enterText(
        find.byKey(ProjectDetailsForm.descriptionFieldKey),
        'Four bedrooms',
      );
      await choose(
        tester,
        ProjectDetailsForm.typeFieldKey,
        l10n.projectTypeNewHouse,
      );
      await choose(tester, ProjectDetailsForm.currencyFieldKey, 'XAF');
      await tester.ensureVisible(
        find.byKey(ProjectDetailsForm.submitButtonKey),
      );
      await tester.tap(find.byKey(ProjectDetailsForm.submitButtonKey));
      await tester.pump();

      verify(
        () => bloc.add(
          CreateProjectEvent.detailsSubmitted(
            details: ProjectDetails(
              name: 'House in Bafoussam',
              description: 'Four bedrooms',
              type: ProjectType.newHouse,
              currencyCode: 'XAF',
            ),
          ),
        ),
      ).called(1);
    });
  });

  group('Given the review step', () {
    final review = CreateProjectState(
      step: CreateProjectStep.review,
      details: testDetails,
    );

    testWidgets('then it shows what will be created', (tester) async {
      await pumpAt(tester, review);

      expect(find.text('House in Bafoussam'), findsOneWidget);
      expect(find.text(l10n.projectTypeNewHouse), findsOneWidget);
      expect(find.text('XAF'), findsOneWidget);
    });

    testWidgets('when Create is tapped then the project is created', (
      tester,
    ) async {
      await pumpAt(tester, review);

      await tester.ensureVisible(find.byKey(CreateProjectPage.createButtonKey));
      await tester.tap(find.byKey(CreateProjectPage.createButtonKey));
      await tester.pump();

      verify(
        () => bloc.add(const CreateProjectEvent.createSubmitted()),
      ).called(1);
    });

    testWidgets('when Back is tapped then it returns to the details', (
      tester,
    ) async {
      await pumpAt(tester, review);

      await tester.ensureVisible(find.byKey(CreateProjectPage.backButtonKey));
      await tester.tap(find.byKey(CreateProjectPage.backButtonKey));
      await tester.pump();

      verify(
        () => bloc.add(const CreateProjectEvent.backToDetails()),
      ).called(1);
    });
  });
}
