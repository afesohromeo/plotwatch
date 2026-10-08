import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The owner creates a stage, or edits one until it is submitted: name,
/// description, budget, planned dates and the checklist of required
/// evidence (STG-01, STG-04; doc/04c M3-4 to M3-6). The checks mirror the
/// server's `StageService.validateDraft`.
class StageFormPage extends StatefulWidget {
  const StageFormPage({super.key, required this.projectId, this.stageId});

  final int projectId;

  /// Null for a new stage.
  final int? stageId;

  static const nameFieldKey = Key('stageForm.name');
  static const descriptionFieldKey = Key('stageForm.description');
  static const budgetFieldKey = Key('stageForm.budget');
  static const startFieldKey = Key('stageForm.start');
  static const endFieldKey = Key('stageForm.end');
  static const addItemButtonKey = Key('stageForm.addItem');
  static const saveButtonKey = Key('stageForm.save');
  static Key itemFieldKey(int index) => Key('stageForm.item.$index');
  static Key itemRequiredKey(int index) => Key('stageForm.required.$index');
  static Key itemUpKey(int index) => Key('stageForm.up.$index');
  static Key itemRemoveKey(int index) => Key('stageForm.remove.$index');

  @override
  State<StageFormPage> createState() => _StageFormPageState();
}

class _StageFormPageState extends State<StageFormPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<StageFormBloc>().add(
    StageFormEvent.load(projectId: widget.projectId, stageId: widget.stageId),
  );

  void _back() {
    final stageId = widget.stageId;
    stageId == null
        ? context.goNamed(
            stagesRouteName,
            pathParameters: {'projectId': '${widget.projectId}'},
          )
        : context.goNamed(
            stageRouteName,
            pathParameters: {
              'projectId': '${widget.projectId}',
              'stageId': '$stageId',
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<StageFormBloc>();
    final isNew = widget.stageId == null;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: _back),
        title: Text(isNew ? l10n.addStageAction : l10n.editStageAction),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<StageFormBloc, StageFormState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          final saved = state.saved;
          if (state.actionStatus == GenericStatus.success && saved != null) {
            context.goNamed(
              stageRouteName,
              pathParameters: {
                'projectId': '${widget.projectId}',
                'stageId': '${saved.stage.id}',
              },
            );
          } else if (state.actionStatus == GenericStatus.failure &&
              state.actionErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.actionErrorMessage!,
              postActions: [
                () => bloc.add(const StageFormEvent.resetFlowStep()),
              ],
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.loadStatus != current.loadStatus ||
            previous.actionStatus != current.actionStatus,
        builder: (context, state) {
          final view = state.view;
          return switch (state.loadStatus) {
            GenericStatus.failure => ErrorrWidget(
              errorMessage: state.loadErrorMessage ?? l10n.errorStagesLoad,
              refreshText: l10n.refresh,
              onPressed: _load,
            ),
            GenericStatus.success
                when view != null && !view.stage.status.isEditable =>
              AuthFormLayout(
                title: view.stage.name,
                children: [
                  Text(
                    l10n.errorStageLocked,
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
            GenericStatus.success => AuthFormLayout(
              title: isNew ? l10n.addStageAction : l10n.editStageAction,
              children: [
                _StageForm(
                  view: view,
                  currencyCode: state.currencyCode,
                  isLoading: state.actionStatus == GenericStatus.loading,
                  onSubmit: (draft) =>
                      bloc.add(StageFormEvent.saveRequested(draft: draft)),
                ),
              ],
            ),
            _ => const Center(child: CircularProgressIndicator()),
          };
        },
      ),
    );
  }
}

/// One checklist item being edited; [itemId] is kept for existing items
/// (decision M3-5).
class _ItemRow {
  _ItemRow({this.itemId, String label = '', this.isRequired = true})
    : controller = TextEditingController(text: label);

  final int? itemId;
  final TextEditingController controller;
  bool isRequired;
}

/// Owns the field values, filled once from the stage being edited.
class _StageForm extends StatefulWidget {
  const _StageForm({
    required this.view,
    required this.currencyCode,
    required this.isLoading,
    required this.onSubmit,
  });

  final StageView? view;
  final String currencyCode;
  final bool isLoading;
  final ValueChanged<StageDraft> onSubmit;

  @override
  State<_StageForm> createState() => _StageFormState();
}

class _StageFormState extends State<_StageForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _budget = TextEditingController();
  final _items = <_ItemRow>[];
  DateTime? _start;
  DateTime? _end;

  @override
  void initState() {
    super.initState();
    final view = widget.view;
    if (view == null) return;
    final stage = view.stage;
    _name.text = stage.name;
    _description.text = stage.description ?? '';
    _start = stage.plannedStart?.toLocal();
    _end = stage.plannedEnd?.toLocal();
    _items.addAll([
      for (final item in view.items)
        _ItemRow(
          itemId: item.id,
          label: item.label,
          isRequired: item.isRequired,
        ),
    ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Formatting needs the app language, known once the context is ready.
    final budget = widget.view?.stage.budgetMinor ?? 0;
    if (_budget.text.isEmpty && budget > 0) {
      _budget.text = formatMoneyInput(
        budget,
        widget.currencyCode,
        locale: Localizations.localeOf(context).languageCode,
      );
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _budget.dispose();
    for (final item in _items) {
      item.controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final locale = Localizations.localeOf(context).languageCode;
    final description = _description.text.trim();
    widget.onSubmit(
      StageDraft(
        name: _name.text.trim(),
        description: description.isEmpty ? null : description,
        budgetMinor:
            parseMoney(_budget.text, widget.currencyCode, locale: locale) ?? 0,
        plannedStart: _asUtcDate(_start),
        plannedEnd: _asUtcDate(_end),
        items: [
          for (final item in _items)
            ChecklistItemDraft(
              itemId: item.itemId,
              label: item.controller.text.trim(),
              isRequired: item.isRequired,
            ),
        ],
      ),
    );
  }

  /// A calendar day, independent of the device's time zone.
  static DateTime? _asUtcDate(DateTime? date) =>
      date == null ? null : DateTime.utc(date.year, date.month, date.day);

  void _moveUp(int index) =>
      setState(() => _items.insert(index - 1, _items.removeAt(index)));

  void _remove(int index) =>
      setState(() => _items.removeAt(index).controller.dispose());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputField(
            key: StageFormPage.nameFieldKey,
            controller: _name,
            labelText: l10n.labelStageName,
            validator: (value) => Validators.stageName(value, l10n),
          ),
          const Gap.vertical(height: AppSpacing.md),
          InputField(
            key: StageFormPage.descriptionFieldKey,
            controller: _description,
            labelText: l10n.labelDescription,
            minlines: 2,
            maxlines: 4,
            keyboardType: TextInputType.multiline,
            validator: (value) => Validators.projectDescription(value, l10n),
          ),
          const Gap.vertical(height: AppSpacing.md),
          MoneyField(
            key: StageFormPage.budgetFieldKey,
            controller: _budget,
            currencyCode: widget.currencyCode,
            labelText: l10n.labelBudget,
          ),
          const Gap.vertical(height: AppSpacing.md),
          DatePickerField(
            key: StageFormPage.startFieldKey,
            labelText: l10n.labelPlannedStart,
            value: _start,
            onChanged: (date) => setState(() => _start = date),
          ),
          const Gap.vertical(height: AppSpacing.md),
          DatePickerField(
            key: StageFormPage.endFieldKey,
            labelText: l10n.labelPlannedEnd,
            value: _end,
            onChanged: (date) => setState(() => _end = date),
            validator: (_) =>
                _start != null && _end != null && _end!.isBefore(_start!)
                ? l10n.validateDatesOrder
                : null,
          ),
          const Gap.vertical(height: AppSpacing.lg),
          Text(l10n.checklistTitle, style: context.textTheme.titleMedium),
          const Gap.vertical(height: AppSpacing.xs),
          Text(l10n.checklistHint, style: context.textTheme.bodySmall),
          const Gap.vertical(height: AppSpacing.sm),
          for (final (index, item) in _items.indexed)
            Padding(
              key: ObjectKey(item),
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputField(
                    key: StageFormPage.itemFieldKey(index),
                    controller: item.controller,
                    labelText: l10n.labelChecklistItem(index + 1),
                    validator: (value) =>
                        Validators.checklistLabel(value, l10n),
                  ),
                  Row(
                    children: [
                      Switch(
                        key: StageFormPage.itemRequiredKey(index),
                        value: item.isRequired,
                        onChanged: (value) =>
                            setState(() => item.isRequired = value),
                      ),
                      Text(
                        item.isRequired
                            ? l10n.checklistRequired
                            : l10n.checklistOptional,
                        style: context.textTheme.bodySmall,
                      ),
                      const Spacer(),
                      if (index > 0)
                        IconButton(
                          key: StageFormPage.itemUpKey(index),
                          tooltip: l10n.moveUpAction,
                          color: customColors.primary,
                          icon: const Icon(Icons.arrow_upward_rounded),
                          onPressed: () => _moveUp(index),
                        ),
                      IconButton(
                        key: StageFormPage.itemRemoveKey(index),
                        tooltip: l10n.removeItemAction,
                        color: customColors.unverified,
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => _remove(index),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          PrimaryButton(
            key: StageFormPage.addItemButtonKey,
            withBg: false,
            width: double.infinity,
            onPressed: _items.length >= Validators.maxChecklistItems
                ? null
                : () => setState(() => _items.add(_ItemRow())),
            child: Text(l10n.addChecklistItemAction),
          ),
          const Gap.vertical(height: AppSpacing.lg),
          SubmitButton(
            key: StageFormPage.saveButtonKey,
            label: l10n.saveChanges,
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
