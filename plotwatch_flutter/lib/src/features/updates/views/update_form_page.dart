import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The site manager posts news from the site (UPD-01; doc/04e M5-9 b):
/// what was done, optionally for which stage, how many workers, the
/// weather and any issues. The checks mirror the server's
/// `UpdateService.validateDraft`.
class UpdateFormPage extends StatefulWidget {
  const UpdateFormPage({super.key, required this.projectId});

  final int projectId;

  static const textFieldKey = Key('updateForm.text');
  static const stageFieldKey = Key('updateForm.stage');
  static const workersFieldKey = Key('updateForm.workers');
  static const issuesFieldKey = Key('updateForm.issues');
  static const saveButtonKey = Key('updateForm.save');
  static Key weatherKey(Weather weather) =>
      Key('updateForm.weather.${weather.name}');

  @override
  State<UpdateFormPage> createState() => _UpdateFormPageState();
}

class _UpdateFormPageState extends State<UpdateFormPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<UpdateFormBloc>().add(
    UpdateFormEvent.load(projectId: widget.projectId),
  );

  void _back() => context.goNamed(
    projectRouteName,
    pathParameters: {'projectId': '${widget.projectId}'},
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<UpdateFormBloc>();

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: _back),
        title: Text(l10n.postUpdateAction),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<UpdateFormBloc, UpdateFormState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          void reset() => bloc.add(const UpdateFormEvent.resetFlowStep());
          if (state.actionStatus == GenericStatus.success) {
            DialogUtils.handleSuccess(
              context,
              l10n.updatePosted,
              postActions: [reset, _back],
            );
          } else if (state.actionStatus == GenericStatus.failure &&
              state.actionErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.actionErrorMessage!,
              postActions: [reset],
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.loadStatus != current.loadStatus ||
            previous.actionStatus != current.actionStatus,
        builder: (context, state) => switch (state.loadStatus) {
          GenericStatus.failure => ErrorrWidget(
            errorMessage: state.loadErrorMessage ?? l10n.errorStagesLoad,
            refreshText: l10n.refresh,
            onPressed: _load,
          ),
          GenericStatus.success => AuthFormLayout(
            title: l10n.postUpdateAction,
            children: [
              _UpdateForm(
                stages: state.stages,
                isLoading: state.actionStatus == GenericStatus.loading,
                onSubmit: (draft) =>
                    bloc.add(UpdateFormEvent.saveRequested(draft)),
              ),
            ],
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

/// Owns the field values.
class _UpdateForm extends StatefulWidget {
  const _UpdateForm({
    required this.stages,
    required this.isLoading,
    required this.onSubmit,
  });

  final List<Stage> stages;
  final bool isLoading;
  final ValueChanged<ProgressUpdateDraft> onSubmit;

  @override
  State<_UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<_UpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _text = TextEditingController();
  final _workers = TextEditingController();
  final _issues = TextEditingController();
  int? _stageId;
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    // The stage being worked on, if there is exactly one.
    final inProgress = widget.stages.where(
      (s) =>
          s.status == StageStatus.inProgress ||
          s.status == StageStatus.changesRequested,
    );
    if (inProgress.length == 1) _stageId = inProgress.single.id;
  }

  @override
  void dispose() {
    _text.dispose();
    _workers.dispose();
    _issues.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final issues = _issues.text.trim();
    widget.onSubmit(
      ProgressUpdateDraft(
        text: _text.text.trim(),
        stageId: _stageId,
        workersCount: int.tryParse(_workers.text.trim()),
        weather: _weather,
        issues: issues.isEmpty ? null : issues,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputField(
            key: UpdateFormPage.textFieldKey,
            controller: _text,
            labelText: l10n.labelUpdateText,
            minlines: 3,
            maxlines: 8,
            keyboardType: TextInputType.multiline,
            validator: (value) => Validators.updateText(value, l10n),
          ),
          const Gap.vertical(height: AppSpacing.md),
          DropdownButtonFormField<int?>(
            key: UpdateFormPage.stageFieldKey,
            initialValue: _stageId,
            isExpanded: true,
            decoration: InputDecoration(labelText: l10n.labelUpdateStage),
            items: [
              DropdownMenuItem(value: null, child: Text(l10n.noStage)),
              for (final stage in widget.stages)
                DropdownMenuItem(
                  value: stage.id,
                  child: Text(stage.name, overflow: TextOverflow.ellipsis),
                ),
            ],
            onChanged: (value) => setState(() => _stageId = value),
          ),
          const Gap.vertical(height: AppSpacing.md),
          InputField(
            key: UpdateFormPage.workersFieldKey,
            controller: _workers,
            labelText: l10n.labelWorkersCount,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) => Validators.workersCount(value, l10n),
          ),
          const Gap.vertical(height: AppSpacing.md),
          Text(l10n.labelWeather, style: context.textTheme.bodyMedium),
          const Gap.vertical(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              for (final weather in Weather.values)
                ChoiceChip(
                  key: UpdateFormPage.weatherKey(weather),
                  avatar: Icon(weather.icon, size: 18),
                  label: Text(weather.label(l10n)),
                  selected: _weather == weather,
                  // Tapping the chosen one again clears it (optional).
                  onSelected: (selected) =>
                      setState(() => _weather = selected ? weather : null),
                ),
            ],
          ),
          const Gap.vertical(height: AppSpacing.md),
          InputField(
            key: UpdateFormPage.issuesFieldKey,
            controller: _issues,
            labelText: l10n.labelUpdateIssues,
            minlines: 2,
            maxlines: 4,
            keyboardType: TextInputType.multiline,
            validator: (value) => Validators.updateIssues(value, l10n),
          ),
          const Gap.vertical(height: AppSpacing.lg),
          SubmitButton(
            key: UpdateFormPage.saveButtonKey,
            label: l10n.postUpdateAction,
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
