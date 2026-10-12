import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A funder records a release made outside the app (LED-01, D-5): amount,
/// day, stage, how it was sent, reference and note. The site manager is
/// notified and confirms receiving it.
class ReleaseFormPage extends StatefulWidget {
  const ReleaseFormPage({
    super.key,
    required this.projectId,
    this.initialStageId,
  });

  final int projectId;

  /// The stage chosen in advance, e.g. the next one after an approval
  /// (REV-06).
  final int? initialStageId;

  static const saveButtonKey = Key('releaseForm.save');
  static const referenceFieldKey = Key('releaseForm.reference');
  static const noteFieldKey = Key('releaseForm.note');
  static Key methodKey(ReleaseMethod method) =>
      Key('releaseForm.method.${method.name}');

  @override
  State<ReleaseFormPage> createState() => _ReleaseFormPageState();
}

class _ReleaseFormPageState extends State<ReleaseFormPage> {
  final _amount = TextEditingController();
  final _reference = TextEditingController();
  final _note = TextEditingController();
  DateTime _date = DateTime.now();
  int? _stageId;
  ReleaseMethod _method = ReleaseMethod.mobileMoney;
  String? _amountError;
  bool _stagePicked = false;

  @override
  void initState() {
    super.initState();
    context.read<LedgerFormBloc>().add(
      LedgerFormEvent.load(projectId: widget.projectId),
    );
  }

  @override
  void dispose() {
    _amount.dispose();
    _reference.dispose();
    _note.dispose();
    super.dispose();
  }

  void _save(LedgerFormState state) {
    final l10n = AppLocalizations.of(context)!;
    final code = state.overview?.project.currencyCode ?? 'XAF';
    final minor = parseMoney(
      _amount.text,
      code,
      locale: Localizations.localeOf(context).languageCode,
    );
    if (minor == null || minor <= 0) {
      setState(() => _amountError = l10n.validateAmountRequired);
      return;
    }
    setState(() => _amountError = null);
    final reference = _reference.text.trim();
    final note = _note.text.trim();
    context.read<LedgerFormBloc>().add(
      LedgerFormEvent.saveRelease(
        ReleaseDraft(
          amountMinor: minor,
          occurredOn: ledgerDay(_date),
          method: _method,
          reference: reference.isEmpty ? null : reference,
          stageId: _stageId,
          note: note.isEmpty ? null : note,
        ),
      ),
    );
  }

  /// The stage being worked on, if there is exactly one (as on the update
  /// form).
  int? _currentStage(List<Stage> stages) {
    final working = stages.where(
      (s) =>
          s.status == StageStatus.inProgress ||
          s.status == StageStatus.changesRequested ||
          s.status == StageStatus.submitted,
    );
    return working.length == 1 ? working.single.id : null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<LedgerFormBloc>();
    return LedgerFormFrame(
      projectId: widget.projectId,
      title: l10n.recordReleaseAction,
      subtitle: l10n.releaseFormSubtitle,
      savedMessage: l10n.releaseSaved,
      saveLabel: l10n.saveReleaseAction,
      saveKey: ReleaseFormPage.saveButtonKey,
      onSave: () => _save(bloc.state),
      sections: (state) {
        if (!_stagePicked) {
          _stagePicked = true;
          _stageId = widget.initialStageId ?? _currentStage(state.stages);
        }
        return [
          LedgerAmountSection(
            amount: _amount,
            amountError: _amountError,
            currencyCode: state.overview?.project.currencyCode ?? 'XAF',
            date: _date,
            onDate: (date) => setState(() => _date = date),
            stages: state.stages,
            stageId: _stageId,
            onStage: (id) => setState(() => _stageId = id),
          ),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.labelMethod,
                  style: context.textTheme.titleSmall?.copyWith(fontSize: 15),
                ),
                const Gap.vertical(height: 10),
                ChoiceTiles<ReleaseMethod>(
                  columns: 2,
                  choices: [
                    for (final method in ReleaseMethod.values)
                      FilterChoice(method, method.label(l10n)),
                  ],
                  selected: _method,
                  keyOf: ReleaseFormPage.methodKey,
                  onSelected: (method) => setState(() => _method = method),
                ),
                const Gap.vertical(height: 12),
                InputField(
                  key: ReleaseFormPage.referenceFieldKey,
                  controller: _reference,
                  labelText: l10n.labelReferenceOptional,
                  validator: null,
                ),
                const Gap.vertical(height: 12),
                InputField(
                  key: ReleaseFormPage.noteFieldKey,
                  controller: _note,
                  labelText: l10n.labelNoteOptional,
                  minlines: 2,
                  maxlines: 4,
                  keyboardType: TextInputType.multiline,
                  validator: null,
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
