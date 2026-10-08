import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The create-project wizard (PROJ-01, PROJ-08): Details → Stages (a
/// template, doc/04c M3-3) → Review. The site comes later from the site
/// manager (decision M2-15).
class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({super.key});

  static const createButtonKey = Key('createProject.create');
  static const backButtonKey = Key('createProject.back');
  static const continueStagesKey = Key('createProject.continueStages');
  static Key templateCardKey(StageTemplate template) =>
      Key('createProject.template.${template.name}');

  static const _stepCount = 3;

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
          previous.details != current.details ||
          previous.template != current.template,
      builder: (context, state) {
        final (title, number) = switch (state.step) {
          CreateProjectStep.details => (l10n.stepDetailsTitle, 1),
          CreateProjectStep.stages => (l10n.stepStagesTitle, 2),
          CreateProjectStep.review => (l10n.stepReviewTitle, 3),
        };
        return ResponsiveScaffoldWrapper(
          props: ScaffoldWrapperProps(
            leading: BackButton(
              onPressed: () => state.step == CreateProjectStep.details
                  ? context.goNamed(homeRouteName)
                  : bloc.add(const CreateProjectEvent.stepBack()),
            ),
            title: Text(l10n.newProject),
            resizeToAvoidBottomInset: true,
          ),
          mobileBody: AuthFormLayout(
            title: title,
            subtitle: l10n.stepOf(number, _stepCount),
            children: switch (state.step) {
              CreateProjectStep.details => [
                ProjectDetailsForm(
                  initial: state.details,
                  submitLabel: l10n.continueAction,
                  onSubmit: (details) => bloc.add(
                    CreateProjectEvent.detailsSubmitted(details: details),
                  ),
                ),
              ],
              CreateProjectStep.stages => _stages(context, state, l10n),
              CreateProjectStep.review => _review(context, state, l10n),
            },
          ),
        );
      },
    );
  }

  /// The template cards and the chosen template's stages (M3-2, M3-3).
  List<Widget> _stages(
    BuildContext context,
    CreateProjectState state,
    AppLocalizations l10n,
  ) {
    final bloc = context.read<CreateProjectBloc>();
    final stages = state.template.stages(l10n);

    return [
      for (final template in StageTemplate.values) ...[
        _TemplateCard(
          key: templateCardKey(template),
          template: template,
          isSelected: template == state.template,
          onTap: () =>
              bloc.add(CreateProjectEvent.templateChosen(template: template)),
        ),
        const Gap.vertical(height: AppSpacing.sm),
      ],
      const Gap.vertical(height: AppSpacing.sm),
      if (stages.isEmpty)
        Text(l10n.templateCustomEmpty, style: context.textTheme.bodyMedium)
      else
        for (final (index, stage) in stages.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text(
              '${index + 1}. ${stage.name}',
              style: context.textTheme.bodyMedium,
            ),
          ),
      const Gap.vertical(height: AppSpacing.sm),
      Text(l10n.templateEditableNote, style: context.textTheme.bodySmall),
      const Gap.vertical(height: AppSpacing.lg),
      SubmitButton(
        key: continueStagesKey,
        label: l10n.continueAction,
        onPressed: () => bloc.add(const CreateProjectEvent.stagesSubmitted()),
      ),
      const Gap.vertical(height: AppSpacing.sm),
      PrimaryButton(
        withBg: false,
        width: double.infinity,
        onPressed: () => bloc.add(const CreateProjectEvent.stepBack()),
        child: Text(l10n.backAction),
      ),
    ];
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
      DetailRow(
        label: l10n.labelStages,
        value: state.template == StageTemplate.custom
            ? l10n.templateCustom
            : l10n.templateWithCount(
                state.template.label(l10n),
                state.template.stages(l10n).length,
              ),
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
        onPressed: () => bloc.add(const CreateProjectEvent.stepBack()),
        child: Text(l10n.backAction),
      ),
    ];
  }
}

/// One template to start the plan from, highlighted when chosen.
class _TemplateCard extends StatelessWidget {
  const _TemplateCard({
    super.key,
    required this.template,
    required this.isSelected,
    required this.onTap,
  });

  final StageTemplate template;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tone = isSelected ? customColors.primary : customColors.muted;

    return Semantics(
      selected: isSelected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(color: tone, width: isSelected ? 2 : 1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.label(l10n),
                      style: context.textTheme.titleSmall,
                    ),
                    const Gap.vertical(height: AppSpacing.xs),
                    Text(
                      template.description(l10n),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: tone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
