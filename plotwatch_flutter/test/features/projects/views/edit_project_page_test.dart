import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockProjectOverviewBloc
    extends MockBloc<ProjectOverviewEvent, ProjectOverviewState>
    implements ProjectOverviewBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group E (PROJ-04).
void main() {
  late MockProjectOverviewBloc bloc;

  setUpAll(() {
    setUpTestLocalization();
    registerFallbackValue(const ProjectOverviewEvent.resetFlowStep());
  });
  setUp(() => bloc = MockProjectOverviewBloc());

  Future<void> pumpPage(WidgetTester tester) {
    when(() => bloc.state).thenReturn(
      ProjectOverviewState(
        overviewStatus: GenericStatus.success,
        overview: testOverview(
          project: testProject(description: 'Four bedrooms'),
        ),
      ),
    );
    return tester.pumpApp(
      BlocProvider<ProjectOverviewBloc>.value(
        value: bloc,
        child: const EditProjectPage(projectId: 1),
      ),
    );
  }

  testWidgets('Given the edit page then the form shows the current details', (
    tester,
  ) async {
    await pumpPage(tester);

    expect(
      fieldText(tester, ProjectDetailsForm.nameFieldKey),
      'House in Bafoussam',
    );
    expect(
      fieldText(tester, ProjectDetailsForm.descriptionFieldKey),
      'Four bedrooms',
    );
  });

  testWidgets('Given a new name when saved then the new details are sent', (
    tester,
  ) async {
    await pumpPage(tester);

    await tester.enterText(
      find.byKey(ProjectDetailsForm.nameFieldKey),
      'Bigger house',
    );
    await tester.ensureVisible(find.byKey(ProjectDetailsForm.submitButtonKey));
    await tester.tap(find.byKey(ProjectDetailsForm.submitButtonKey));
    await tester.pump();

    verify(
      () => bloc.add(
        ProjectOverviewEvent.updateProject(
          details: ProjectDetails(
            name: 'Bigger house',
            description: 'Four bedrooms',
            type: ProjectType.newHouse,
            currencyCode: 'XAF',
          ),
        ),
      ),
    ).called(1);
  });
}
