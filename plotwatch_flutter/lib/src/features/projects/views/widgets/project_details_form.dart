import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Name, description, type of work, currency and planned dates of a project
/// (PROJ-01). Used by the create wizard's first step and by the edit page.
/// The rules mirror the server's `ProjectService.validateDetails`.
class ProjectDetailsForm extends StatefulWidget {
  const ProjectDetailsForm({
    super.key,
    this.initial,
    required this.submitLabel,
    required this.onSubmit,
    this.isLoading = false,
  });

  static const nameFieldKey = Key('projectForm.name');
  static const descriptionFieldKey = Key('projectForm.description');
  static const typeFieldKey = Key('projectForm.type');
  static const currencyFieldKey = Key('projectForm.currency');
  static const startFieldKey = Key('projectForm.start');
  static const endFieldKey = Key('projectForm.end');
  static const submitButtonKey = Key('projectForm.submit');

  /// Values to start from (edit page, or back from the review step).
  final ProjectDetails? initial;
  final String submitLabel;
  final ValueChanged<ProjectDetails> onSubmit;
  final bool isLoading;

  @override
  State<ProjectDetailsForm> createState() => _ProjectDetailsFormState();
}

class _ProjectDetailsFormState extends State<ProjectDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  ProjectType? _type;
  String? _currency;
  DateTime? _start;
  DateTime? _end;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    if (initial != null) {
      _name.text = initial.name;
      _description.text = initial.description ?? '';
      _type = initial.type;
      _currency = initial.currencyCode;
      _start = initial.plannedStart?.toLocal();
      _end = initial.plannedEnd?.toLocal();
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final description = _description.text.trim();
    widget.onSubmit(
      ProjectDetails(
        name: _name.text.trim(),
        description: description.isEmpty ? null : description,
        type: _type!,
        currencyCode: _currency!,
        plannedStart: _asUtcDate(_start),
        plannedEnd: _asUtcDate(_end),
      ),
    );
  }

  /// A calendar day, independent of the device's time zone.
  static DateTime? _asUtcDate(DateTime? date) =>
      date == null ? null : DateTime.utc(date.year, date.month, date.day);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputField(
            key: ProjectDetailsForm.nameFieldKey,
            controller: _name,
            labelText: l10n.labelProjectName,
            validator: (value) => Validators.projectName(value, l10n),
          ),
          const Gap.vertical(height: AppSpacing.md),
          InputField(
            key: ProjectDetailsForm.descriptionFieldKey,
            controller: _description,
            labelText: l10n.labelDescription,
            minlines: 2,
            maxlines: 4,
            keyboardType: TextInputType.multiline,
            validator: (value) => Validators.projectDescription(value, l10n),
          ),
          const Gap.vertical(height: AppSpacing.md),
          SearchableDropdownField<ProjectType>(
            key: ProjectDetailsForm.typeFieldKey,
            items: ProjectType.values,
            selectedValue: _type,
            itemToString: (type) => type.label(l10n),
            onChanged: (type) => setState(() => _type = type),
            labelText: l10n.labelProjectType,
            hintText: l10n.selectProjectType,
            validator: (type) =>
                type == null ? l10n.validateProjectTypeRequired : null,
          ),
          const Gap.vertical(height: AppSpacing.md),
          SearchableDropdownField<String>(
            key: ProjectDetailsForm.currencyFieldKey,
            items: supportedCurrencyCodes,
            selectedValue: _currency,
            itemToString: (code) => code,
            onChanged: (code) => setState(() => _currency = code),
            labelText: l10n.labelCurrency,
            hintText: l10n.selectCurrency,
            validator: (code) =>
                code == null ? l10n.validateCurrencyRequired : null,
          ),
          const Gap.vertical(height: AppSpacing.md),
          DatePickerField(
            key: ProjectDetailsForm.startFieldKey,
            labelText: l10n.labelPlannedStart,
            value: _start,
            onChanged: (date) => setState(() => _start = date),
          ),
          const Gap.vertical(height: AppSpacing.md),
          DatePickerField(
            key: ProjectDetailsForm.endFieldKey,
            labelText: l10n.labelPlannedEnd,
            value: _end,
            onChanged: (date) => setState(() => _end = date),
            validator: (_) =>
                _start != null && _end != null && _end!.isBefore(_start!)
                ? l10n.validateDatesOrder
                : null,
          ),
          const Gap.vertical(height: AppSpacing.lg),
          SubmitButton(
            key: ProjectDetailsForm.submitButtonKey,
            label: widget.submitLabel,
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
