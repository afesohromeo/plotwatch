import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The site manager posts news from the site (UPD-01; doc/04e M5-9 b):
/// what was done, optionally for which stage, how many workers, the
/// weather and any issues. The checks mirror the server's
/// `UpdateService.validateDraft`. Drawn as on the canvas (doc/05 §9.6): a
/// focused page, closed with ✕, its button fixed at the bottom; the
/// project shell hides its bottom bar here.
class UpdateFormPage extends StatefulWidget {
  const UpdateFormPage({super.key, required this.projectId});

  final int projectId;

  static const textFieldKey = Key('updateForm.text');
  static const stageFieldKey = Key('updateForm.stage');
  static const workersFieldKey = Key('updateForm.workers');
  static const fewerWorkersKey = Key('updateForm.workers.fewer');
  static const moreWorkersKey = Key('updateForm.workers.more');
  static const issuesFieldKey = Key('updateForm.issues');
  static const saveButtonKey = Key('updateForm.save');
  static const closeButtonKey = Key('updateForm.close');
  static Key weatherKey(Weather weather) =>
      Key('updateForm.weather.${weather.name}');

  /// The longest text the server takes (UPD-01).
  static const maxTextLength = 2000;

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
    final projectName = projectNameOf(context);

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: IconButton(
          key: UpdateFormPage.closeButtonKey,
          tooltip: l10n.closeWithoutPosting,
          icon: const Icon(Icons.close_rounded),
          onPressed: _back,
        ),
        title: Text(l10n.postUpdateAction),
        subtitle: projectName == null
            ? null
            : l10n.updateFormSubtitle(projectName),
        showBell: false,
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
          GenericStatus.success => _UpdateForm(
            stages: state.stages,
            isLoading: state.actionStatus == GenericStatus.loading,
            onSubmit: (draft) => bloc.add(UpdateFormEvent.saveRequested(draft)),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

/// Owns the field values; its button sits under the scrolling sections.
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

  /// Post was tapped once: from then on the workers' error shows.
  bool _submitted = false;

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
    setState(() => _submitted = true);
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

  /// − and + on the workers count, kept within 0–999 (UPD-01).
  void _stepWorkers(int by) {
    final current = int.tryParse(_workers.text.trim());
    final next = ((current ?? 0) + by).clamp(0, 999);
    if (current == null && by < 0) return;
    _workers.text = '$next';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final max = NumberFormat.decimalPattern(
      l10n.localeName,
    ).format(UpdateFormPage.maxTextLength);
    Widget heading(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: context.textTheme.titleSmall?.copyWith(fontSize: 15),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // What was done, with the room left.
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            heading(l10n.labelUpdateText),
                            InputField(
                              key: UpdateFormPage.textFieldKey,
                              controller: _text,
                              hintText: l10n.updateTextHint,
                              minlines: 4,
                              maxlines: 8,
                              keyboardType: TextInputType.multiline,
                              validator: (value) =>
                                  Validators.updateText(value, l10n),
                            ),
                            const Gap.vertical(height: 6),
                            ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _text,
                              builder: (context, value, _) => Text(
                                '${value.text.trim().length} / $max',
                                textAlign: TextAlign.end,
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap.vertical(height: 12),
                      // The stage and the workers.
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DropdownButtonFormField<int?>(
                              key: UpdateFormPage.stageFieldKey,
                              initialValue: _stageId,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: l10n.labelUpdateStage,
                                prefixIcon: Icon(
                                  Icons.layers_outlined,
                                  color: customColors.primary,
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: null,
                                  child: Text(l10n.noStage),
                                ),
                                for (final stage in widget.stages)
                                  DropdownMenuItem(
                                    value: stage.id,
                                    child: Text(
                                      '${stage.name} · '
                                      '${stage.status.label(l10n)}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                              onChanged: (value) =>
                                  setState(() => _stageId = value),
                            ),
                            const Gap.vertical(height: 14),
                            Row(
                              children: [
                                IconTile(
                                  icon: Icons.groups_outlined,
                                  size: 32,
                                  color: customColors.primary,
                                  background: customColors.primarySoft,
                                ),
                                const Gap.horizontal(width: 12),
                                Expanded(
                                  child: Text(
                                    l10n.labelWorkersCount,
                                    style: context.textTheme.titleSmall,
                                  ),
                                ),
                                const Gap.horizontal(width: AppSpacing.sm),
                                _StepButton(
                                  key: UpdateFormPage.fewerWorkersKey,
                                  icon: Icons.remove_rounded,
                                  label: l10n.fewerWorkers,
                                  onPressed: () => _stepWorkers(-1),
                                ),
                                // Room for 999 (UPD-01), without the
                                // field's own padding.
                                SizedBox(
                                  width: 48,
                                  child: TextFormField(
                                    key: UpdateFormPage.workersFieldKey,
                                    controller: _workers,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    style: context.textTheme.titleMedium,
                                    decoration: const InputDecoration(
                                      hintText: '–',
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorStyle: TextStyle(height: 0),
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                    ),
                                    // Marks the field; the message goes under
                                    // the whole row.
                                    validator: (value) =>
                                        Validators.workersCount(value, l10n) ==
                                            null
                                        ? null
                                        : '',
                                  ),
                                ),
                                _StepButton(
                                  key: UpdateFormPage.moreWorkersKey,
                                  icon: Icons.add_rounded,
                                  label: l10n.moreWorkers,
                                  onPressed: () => _stepWorkers(1),
                                ),
                              ],
                            ),
                            // The workers' error, under the whole row.
                            ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _workers,
                              builder: (context, value, _) =>
                                  !_submitted ||
                                      Validators.workersCount(value.text, l10n) ==
                                          null
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        l10n.validateWorkersCount,
                                        textAlign: TextAlign.end,
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                              color: customColors.unverified,
                                            ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const Gap.vertical(height: 12),
                      // The weather: four tiles, the chosen one framed
                      // (doc/04e D-1: the icon stays, no tick).
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            heading(l10n.labelWeather),
                            Row(
                              children: [
                                for (final weather in Weather.values) ...[
                                  if (weather != Weather.values.first)
                                    const Gap.horizontal(width: AppSpacing.sm),
                                  Expanded(
                                    child: _WeatherTile(
                                      key: UpdateFormPage.weatherKey(weather),
                                      weather: weather,
                                      selected: _weather == weather,
                                      // Tapping the chosen one again clears
                                      // it (optional).
                                      onTap: () => setState(
                                        () => _weather = _weather == weather
                                            ? null
                                            : weather,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap.vertical(height: 12),
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            heading(l10n.labelUpdateIssuesOptional),
                            InputField(
                              key: UpdateFormPage.issuesFieldKey,
                              controller: _issues,
                              hintText: l10n.updateIssuesHint,
                              minlines: 2,
                              maxlines: 4,
                              keyboardType: TextInputType.multiline,
                              validator: (value) =>
                                  Validators.updateIssues(value, l10n),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Always in reach, above the keyboard (doc/05 §9.6).
          DecoratedBox(
            decoration: BoxDecoration(
              color: customColors.surfaceWhite,
              border: Border(top: BorderSide(color: customColors.line)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: SubmitButton(
                      key: UpdateFormPage.saveButtonKey,
                      label: l10n.postUpdateSave,
                      isLoading: widget.isLoading,
                      onPressed: _submit,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// − or + beside the workers count.
class _StepButton extends StatelessWidget {
  const _StepButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      tooltip: label,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        minimumSize: const Size(44, 44),
        side: BorderSide(color: customColors.line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, color: customColors.ink),
    );
  }
}

/// One weather choice: its icon and name, framed in the primary colour when
/// chosen.
class _WeatherTile extends StatelessWidget {
  const _WeatherTile({
    super.key,
    required this.weather,
    required this.selected,
    required this.onTap,
  });

  final Weather weather;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = selected ? customColors.primary : customColors.ink;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? customColors.primarySoft : customColors.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: selected ? customColors.primary : customColors.line,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: SizedBox(
            height: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(weather.icon, size: 20, color: color),
                const Gap.vertical(height: 4),
                Text(
                  weather.label(l10n),
                  style: context.textTheme.labelMedium?.copyWith(
                    color: color,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
