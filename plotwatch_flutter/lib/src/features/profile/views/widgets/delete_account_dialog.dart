import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Profile › Delete account (doc/04g step 6): the projects that block it, or
/// what is deleted and what stays, confirmed by typing the account email.
Future<void> showDeleteAccountDialog(BuildContext context, String email) {
  final bloc = context.read<AccountDeletionBloc>()
    ..add(const AccountDeletionEvent.checkRequested());
  return showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: bloc,
      child: DeleteAccountDialog(email: email),
    ),
  );
}

/// Material 3's widest dialog; the developer preferred it to 440 px on the
/// web (2026-10-13).
const _dialogWidth = BoxConstraints(minWidth: 280, maxWidth: 560);

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key, required this.email});

  final String email;

  static const emailFieldKey = Key('deleteAccount.email');
  static const confirmButtonKey = Key('deleteAccount.confirm');

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final _typed = TextEditingController();

  @override
  void dispose() {
    _typed.dispose();
    super.dispose();
  }

  bool get _matches =>
      _typed.text.trim().toLowerCase() == widget.email.trim().toLowerCase();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<AccountDeletionBloc, AccountDeletionState>(
      listenWhen: (previous, current) =>
          previous.deleteStatus != current.deleteStatus,
      listener: (context, state) {
        // The session is gone: the router leaves for the welcome page.
        if (state.deleteStatus == GenericStatus.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final close = TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        );
        if (state.checkStatus == GenericStatus.initial ||
            state.checkStatus == GenericStatus.loading) {
          return const AlertDialog(
            constraints: _dialogWidth,
            content: SizedBox(
              height: 80,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (state.checkStatus == GenericStatus.failure) {
          return AlertDialog(
            constraints: _dialogWidth,
            title: Text(l10n.deleteAccountTitle),
            content: Text(state.errorMessage ?? l10n.errorDeleteAccount),
            actions: [close],
          );
        }
        if (state.blockers.isNotEmpty) {
          return AlertDialog(
            constraints: _dialogWidth,
            title: Text(l10n.deleteAccountBlockedTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.deleteAccountBlockedText),
                const Gap.vertical(height: AppSpacing.sm),
                for (final name in state.blockers)
                  Text('• $name', style: context.textTheme.titleSmall),
              ],
            ),
            // Nothing to cancel here: the person just reads and closes.
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.ok),
              ),
            ],
          );
        }
        final deleting = state.deleteStatus == GenericStatus.loading;
        return AlertDialog(
          constraints: _dialogWidth,
          title: Text(l10n.deleteAccountTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.deleteAccountExplain),
                const Gap.vertical(height: AppSpacing.md),
                InputField(
                  key: DeleteAccountDialog.emailFieldKey,
                  controller: _typed,
                  labelText: l10n.deleteAccountTypeEmail(widget.email),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => setState(() {}),
                  validator: null,
                ),
                if (state.deleteStatus == GenericStatus.failure &&
                    state.errorMessage != null) ...[
                  const Gap.vertical(height: AppSpacing.sm),
                  Text(
                    state.errorMessage!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: customColors.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            close,
            FilledButton(
              key: DeleteAccountDialog.confirmButtonKey,
              style: FilledButton.styleFrom(
                backgroundColor: customColors.error,
              ),
              onPressed: _matches && !deleting
                  ? () => context.read<AccountDeletionBloc>().add(
                      const AccountDeletionEvent.deleteRequested(),
                    )
                  : null,
              child: Text(l10n.deleteAccountConfirm),
            ),
          ],
        );
      },
    );
  }
}
