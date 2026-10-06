import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Three-step password reset; the last step signs in with the new password.
class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  static const emailFieldKey = Key('passwordReset.email');
  static const codeFieldKey = Key('passwordReset.code');
  static const accountEmailFieldKey = Key('passwordReset.accountEmail');
  static const passwordFieldKey = Key('passwordReset.password');
  static const confirmPasswordFieldKey = Key('passwordReset.confirmPassword');
  static const submitButtonKey = Key('passwordReset.submit');
  static const passwordVisibilityButtonKey =
      Key('passwordReset.passwordVisibility');
  static const confirmPasswordVisibilityButtonKey =
      Key('passwordReset.confirmPasswordVisibility');

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _submit(PasswordResetStep step) {
    if (!_formKey.currentState!.validate()) return;
    final bloc = context.read<PasswordResetBloc>();
    switch (step) {
      case PasswordResetStep.email:
        bloc.add(PasswordResetEvent.emailSubmitted(email: _email.text));
      case PasswordResetStep.verifyCode:
        bloc.add(PasswordResetEvent.codeSubmitted(code: _code.text));
      case PasswordResetStep.newPassword:
        bloc.add(PasswordResetEvent.newPasswordSubmitted(
            password: _password.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: () => context.goNamed(signInRouteName)),
        title: Text(l10n.passwordResetTitle),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<PasswordResetBloc, PasswordResetState>(
        listenWhen: (previous, current) =>
            previous.passwordResetStatus != current.passwordResetStatus ||
            previous.isPasswordVisible != current.isPasswordVisible ||
            previous.isConfirmPasswordVisible !=
                current.isConfirmPasswordVisible,
        listener: (context, state) {
          if (state.passwordResetStatus == GenericStatus.failure &&
              state.passwordResetErrorMessage != null) {
            DialogUtils.handleFailure(context, state.passwordResetErrorMessage!);
          } else if (state.step == PasswordResetStep.newPassword &&
              state.passwordResetStatus == GenericStatus.success) {
            // The password is set: offer to update the saved login in the
            // browser or phone password manager.
            TextInput.finishAutofillContext();
          }
        },
        buildWhen: (previous, current) =>
            previous.step != current.step ||
            previous.passwordResetStatus != current.passwordResetStatus,
        builder: (context, state) {
          final isLoading =
              state.passwordResetStatus == GenericStatus.loading;
          return AuthFormLayout(
            title: l10n.passwordResetTitle,
            subtitle: state.step == PasswordResetStep.verifyCode
                ? l10n.passwordResetCodeSent(state.email)
                : null,
            children: [
              // Leaving before the password is set must not offer to save
              // what was typed; success saves it explicitly (listener above).
              // The key keeps the group across steps, when the subtitle and
              // the resend button appear around it.
              AutofillGroup(
                key: const ValueKey('passwordReset.autofillGroup'),
                onDisposeAction: AutofillContextAction.cancel,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ..._fields(state, l10n),
                      const Gap.vertical(height: AppSpacing.lg),
                      SubmitButton(
                        key: PasswordResetPage.submitButtonKey,
                        label: l10n.continueAction,
                        isLoading: isLoading,
                        onPressed: () => _submit(state.step),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.step == PasswordResetStep.verifyCode) ...[
                const Gap.vertical(height: AppSpacing.sm),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context
                          .read<PasswordResetBloc>()
                          .add(const PasswordResetEvent.codeResent()),
                  child: Text(l10n.resendCode),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  List<Widget> _fields(PasswordResetState state, AppLocalizations l10n) {
    void toggle(PasswordResetEvent event) => context.read<PasswordResetBloc>().add(event);

    return switch (state.step) {
      PasswordResetStep.email => [
          InputField(
            key: PasswordResetPage.emailFieldKey,
            controller: _email,
            labelText: l10n.labelEmail,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email, AutofillHints.username],
            validator: (value) => Validators.email(value, l10n),
          ),
        ],
      PasswordResetStep.verifyCode => [
          InputField(
            key: PasswordResetPage.codeFieldKey,
            controller: _code,
            labelText: l10n.labelVerificationCode,
            enableSuggestions: false,
            validator: (value) => Validators.code(value, l10n),
          ),
        ],
      PasswordResetStep.newPassword => [
          // The password manager updates the password saved under this email.
          InputField(
            key: PasswordResetPage.accountEmailFieldKey,
            initialValue: state.email,
            labelText: l10n.labelEmail,
            readOnly: true,
            autofillHints: const [AutofillHints.username],
            validator: null,
          ),
          const Gap.vertical(height: AppSpacing.md),
          InputField(
            key: PasswordResetPage.passwordFieldKey,
            controller: _password,
            labelText: l10n.labelNewPassword,
            hintText: l10n.passwordRuleHint,
            obscureText: !state.isPasswordVisible,
            suffixIcon: PasswordVisibilityButton(
              key: PasswordResetPage.passwordVisibilityButtonKey,
              isVisible: state.isPasswordVisible,
              onPressed: () =>
                  toggle(const PasswordResetEvent.passwordVisibilityToggled()),
            ),
            enableSuggestions: false,
            autofillHints: const [AutofillHints.newPassword],
            validator: (value) => Validators.password(value, l10n),
          ),
          const Gap.vertical(height: AppSpacing.md),
          InputField(
            key: PasswordResetPage.confirmPasswordFieldKey,
            controller: _confirmPassword,
            labelText: l10n.labelConfirmNewPassword,
            obscureText: !state.isConfirmPasswordVisible,
            suffixIcon: PasswordVisibilityButton(
              key: PasswordResetPage.confirmPasswordVisibilityButtonKey,
              isVisible: state.isConfirmPasswordVisible,
              onPressed: () =>
                  toggle(const PasswordResetEvent.confirmPasswordVisibilityToggled()),
            ),
            enableSuggestions: false,
            autofillHints: const [AutofillHints.newPassword],
            validator: (value) =>
                Validators.confirmPassword(value, _password.text, l10n),
          ),
        ],
    };
  }
}
