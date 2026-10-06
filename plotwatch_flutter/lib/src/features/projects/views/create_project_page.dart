import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The create-project wizard (PROJ-01, PROJ-08): Details → Review. The
/// Stages step is added in M3; the site comes later from the site manager
/// (decision M2-15).
class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({super.key});

  static const createButtonKey = Key('createProject.create');
  static const backButtonKey = Key('createProject.back');

  static const _stepCount = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<CreateProjectBloc>();

    return BlocConsumer<CreateProjectBloc, CreateProjectState>(
      listenWhen: (previous, current) =>
          previous.createStatus != current.createStatus,
      listener: (context, state) {
        if (state.createStatus == GenericStatus.success &&
            state.created != null) {
          context.goNamed(
            projectRouteName,
            pathParameters: {'projectId': '${state.created!.project.id}'},
          );
        } else if (state.createStatus == GenericStatus.failure &&
            state.createErrorMessage != null) {
          DialogUtils.handleFailure(
            context,
            state.createErrorMessage!,
            postActions: [
              () => bloc.add(const CreateProjectEvent.resetFlowStep()),
            ],
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.step != current.step ||
          previous.createStatus != current.createStatus ||
          previous.details != current.details,
      builder: (context, state) {
        final isReview = state.step == CreateProjectStep.review;
        return ResponsiveScaffoldWrapper(
          props: ScaffoldWrapperProps(
            leading: BackButton(
              onPressed: () => isReview
                  ? bloc.add(const CreateProjectEvent.backToDetails())
                  : context.goNamed(homeRouteName),
            ),
            title: Text(l10n.newProject),
            resizeToAvoidBottomInset: true,
          ),
          mobileBody: AuthFormLayout(
            title: isReview ? l10n.stepReviewTitle : l10n.stepDetailsTitle,
            subtitle: l10n.stepOf(isReview ? 2 : 1, _stepCount),
            children: isReview
                ? _review(context, state, l10n)
                : [
                    ProjectDetailsForm(
                      initial: state.details,
                      submitLabel: l10n.continueAction,
                      onSubmit: (details) => bloc.add(
                        CreateProjectEvent.detailsSubmitted(details: details),
                      ),
                    ),
                  ],
          ),
        );
      },
    );
  }

  List<Widget> _review(
    BuildContext context,
    CreateProjectState state,
    AppLocalizations l10n,
  ) {
    final details = state.details!;
    final bloc = context.read<CreateProjectBloc>();
    String date(DateTime? value) =>
        value == null ? l10n.notSet : formatDate(value.toLocal());

    return [
      DetailRow(label: l10n.labelProjectName, value: details.name),
      if (details.description != null)
        DetailRow(label: l10n.labelDescription, value: details.description!),
      DetailRow(label: l10n.labelProjectType, value: details.type.label(l10n)),
      DetailRow(label: l10n.labelCurrency, value: details.currencyCode),
      DetailRow(
        label: l10n.labelPlannedDates,
        value: '${date(details.plannedStart)} – ${date(details.plannedEnd)}',
      ),
      const Gap.vertical(height: AppSpacing.md),
      Text(l10n.reviewDraftNote, style: context.textTheme.bodyMedium),
      const Gap.vertical(height: AppSpacing.lg),
      SubmitButton(
        key: createButtonKey,
        label: l10n.createProjectAction,
        isLoading: state.createStatus == GenericStatus.loading,
        onPressed: () => bloc.add(const CreateProjectEvent.createSubmitted()),
      ),
      const Gap.vertical(height: AppSpacing.sm),
      PrimaryButton(
        key: backButtonKey,
        withBg: false,
        width: double.infinity,
        onPressed: () => bloc.add(const CreateProjectEvent.backToDetails()),
        child: Text(l10n.backAction),
      ),
    ];
  }
}
