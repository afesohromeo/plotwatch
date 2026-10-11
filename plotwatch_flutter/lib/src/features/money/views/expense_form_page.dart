import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The site manager records an expense (LED-03; canvas M-Expense): amount,
/// day, stage, what for, description, who was paid, and the receipt photo
/// taken with the app's camera (doc/04f M6-5 a). The funders are notified.
class ExpenseFormPage extends StatefulWidget {
  const ExpenseFormPage({
    super.key,
    required this.projectId,
    this.isWeb = kIsWeb,
    this.takeReceipt,
  });

  final int projectId;

  /// The web has no camera: receipts are taken on the phone (for tests).
  final bool isWeb;

  /// Opens the camera; [ReceiptCameraPage.open] by default (for tests).
  final Future<Uint8List?> Function(BuildContext context)? takeReceipt;

  static const saveButtonKey = Key('expenseForm.save');
  static const descriptionFieldKey = Key('expenseForm.description');
  static const vendorFieldKey = Key('expenseForm.vendor');
  static const takeReceiptKey = Key('expenseForm.takeReceipt');
  static const removeReceiptKey = Key('expenseForm.removeReceipt');
  static Key categoryKey(ExpenseCategory category) =>
      Key('expenseForm.category.${category.name}');

  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _description = TextEditingController();
  final _vendor = TextEditingController();
  DateTime _date = DateTime.now();
  int? _stageId;
  ExpenseCategory _category = ExpenseCategory.materials;
  Uint8List? _receipt;
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
    _description.dispose();
    _vendor.dispose();
    super.dispose();
  }

  Future<void> _take() async {
    final take = widget.takeReceipt ?? ReceiptCameraPage.open;
    final bytes = await take(context);
    if (bytes != null && mounted) setState(() => _receipt = bytes);
  }

  void _save(LedgerFormState state) {
    final l10n = AppLocalizations.of(context)!;
    final code = state.overview?.project.currencyCode ?? 'XAF';
    final minor = parseMoney(
      _amount.text,
      code,
      locale: Localizations.localeOf(context).languageCode,
    );
    final amountOk = minor != null && minor > 0;
    setState(
      () => _amountError = amountOk ? null : l10n.validateAmountRequired,
    );
    final fieldsOk = _formKey.currentState?.validate() ?? false;
    if (!amountOk || !fieldsOk) return;
    final vendor = _vendor.text.trim();
    context.read<LedgerFormBloc>().add(
      LedgerFormEvent.saveExpense(
        ExpenseDraft(
          amountMinor: minor,
          occurredOn: ledgerDay(_date),
          category: _category,
          description: _description.text.trim(),
          vendor: vendor.isEmpty ? null : vendor,
          stageId: _stageId,
        ),
        receipt: _receipt,
      ),
    );
  }

  int? _currentStage(List<Stage> stages) {
    final working = stages.where(
      (s) =>
          s.status == StageStatus.inProgress ||
          s.status == StageStatus.changesRequested,
    );
    return working.length == 1 ? working.single.id : null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<LedgerFormBloc>();
    return LedgerFormFrame(
      projectId: widget.projectId,
      title: l10n.recordExpenseAction,
      subtitle: l10n.expenseFormSubtitle,
      savedMessage: l10n.expenseSaved,
      saveLabel: l10n.saveExpenseAction,
      saveKey: ExpenseFormPage.saveButtonKey,
      onSave: () => _save(bloc.state),
      sections: (state) {
        if (!_stagePicked) {
          _stagePicked = true;
          _stageId = _currentStage(state.stages);
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.labelWhatFor,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  const Gap.vertical(height: 10),
                  ChoiceTiles<ExpenseCategory>(
                    choices: [
                      for (final category in ExpenseCategory.values)
                        FilterChoice(category, category.label(l10n)),
                    ],
                    selected: _category,
                    keyOf: ExpenseFormPage.categoryKey,
                    onSelected: (category) =>
                        setState(() => _category = category),
                  ),
                  const Gap.vertical(height: 12),
                  InputField(
                    key: ExpenseFormPage.descriptionFieldKey,
                    controller: _description,
                    labelText: l10n.labelExpenseDescription,
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return l10n.validateDescriptionRequired;
                      return text.length > 300 ? l10n.errorTextTooLong : null;
                    },
                  ),
                  const Gap.vertical(height: 12),
                  InputField(
                    key: ExpenseFormPage.vendorFieldKey,
                    controller: _vendor,
                    labelText: l10n.labelVendorOptional,
                    validator: (value) =>
                        (value?.trim().length ?? 0) > 100
                        ? l10n.errorTextTooLong
                        : null,
                  ),
                ],
              ),
            ),
          ),
          _ReceiptSection(
            isWeb: widget.isWeb,
            receipt: _receipt,
            onTake: _take,
            onRemove: () => setState(() => _receipt = null),
          ),
        ];
      },
    );
  }
}

/// The receipt photo: take it, retake it or remove it; on the web, where
/// there is no camera, a line saying receipts are taken on the phone.
class _ReceiptSection extends StatelessWidget {
  const _ReceiptSection({
    required this.isWeb,
    required this.receipt,
    required this.onTake,
    required this.onRemove,
  });

  final bool isWeb;
  final Uint8List? receipt;
  final VoidCallback onTake;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final photo = receipt;
    if (isWeb) {
      return AppCard(
        child: Row(
          children: [
            Icon(Icons.phone_android_rounded, color: customColors.muted),
            const Gap.horizontal(width: 12),
            Expanded(
              child: Text(
                l10n.receiptPhoneOnly,
                style: context.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }
    if (photo == null) {
      return OutlinedButton.icon(
        key: ExpenseFormPage.takeReceiptKey,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
          ),
        ),
        onPressed: onTake,
        icon: const Icon(Icons.receipt_long_outlined),
        label: Text(l10n.receiptTake),
      );
    }
    // The buttons under the text: a phone is narrow (doc/04f).
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              photo,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                width: 72,
                height: 72,
                color: customColors.lineSoft,
                child: Icon(
                  Icons.receipt_long_outlined,
                  color: customColors.muted,
                ),
              ),
            ),
          ),
          const Gap.horizontal(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.receiptTitle, style: context.textTheme.titleSmall),
                Text(l10n.receiptHint, style: context.textTheme.bodySmall),
                const Gap.vertical(height: 6),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [
                    OutlinedButton(
                      onPressed: onTake,
                      child: Text(l10n.receiptRetake),
                    ),
                    TextButton(
                      key: ExpenseFormPage.removeReceiptKey,
                      onPressed: onRemove,
                      child: Text(l10n.receiptRemove),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
