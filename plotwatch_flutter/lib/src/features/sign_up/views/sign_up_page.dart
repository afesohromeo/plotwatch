import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Three-step sign-up (decision M1-4). The page shows the step the
/// [SignUpBloc] is at; finishing signs in and the router moves to home.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static const nameFieldKey = Key('signUp.name');
  static const emailFieldKey = Key('signUp.email');
  static const codeFieldKey = Key('signUp.code');
  static const accountEmailFieldKey = Key('signUp.accountEmail');
  static const passwordFieldKey = Key('signUp.password');
  static const confirmPasswordFieldKey = Key('signUp.confirmPassword');
  static const noCodeHintKey = Key('signUp.noCodeHint');
  static const submitButtonKey = Key('signUp.submit');
  static const passwordVisibilityButtonKey = Key('signUp.passwordVisibility');
  static const confirmPasswordVisibilityButtonKey = Key(
    'signUp.confirmPasswordVisibility',
  );

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _code.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _submit(SignUpStep step) {
    if (!_formKey.currentState!.validate()) return;
    final bloc = context.read<SignUpBloc>();
    switch (step) {
      case SignUpStep.details:
        bloc.add(
          SignUpEvent.detailsSubmitted(
            fullName: _name.text,
            email: _email.text,
          ),
        );
      case SignUpStep.verifyCode:
        bloc.add(SignUpEvent.codeSubmitted(code: _code.text));
      case SignUpStep.password:
        bloc.add(
          SignUpEvent.passwordSubmitted(
            password: _password.text,
            locale: Localizations.localeOf(context).languageCode,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: () => context.goNamed(welcomeRouteName)),
        title: Text(l10n.createAccount),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<SignUpBloc, SignUpState>(
        listenWhen: (previous, current) =>
            previous.signUpStatus != current.signUpStatus ||
            previous.isPasswordVisible != current.isPasswordVisible ||
            previous.isConfirmPasswordVisible !=
                current.isConfirmPasswordVisible,
        listener: (context, state) {
          if (state.signUpStatus == GenericStatus.failure &&
              state.signUpErrorMessage != null) {
            DialogUtils.handleFailure(context, state.signUpErrorMessage!);
          } else if (state.step == SignUpStep.password &&
              state.signUpStatus == GenericStatus.success) {
            // The account exists: offer to save the login in the browser or
            // phone password manager.
            TextInput.finishAutofillContext();
          }
        },
        buildWhen: (previous, current) =>
            previous.step != current.step ||
            previous.signUpStatus != current.signUpStatus,
        builder: (context, state) {
          final isLoading = state.signUpStatus == GenericStatus.loading;
          return AuthFormLayout(
            title: switch (state.step) {
              SignUpStep.details => l10n.signUpTitle,
              SignUpStep.verifyCode => l10n.labelVerificationCode,
              SignUpStep.password => l10n.choosePasswordTitle,
            },
            subtitle: state.step == SignUpStep.verifyCode
                ? l10n.signUpCodeSent(state.email)
                : null,
            children: [
              // Leaving before the account exists must not offer to save
              // what was typed; success saves it explicitly (listener above).
              // The key keeps the group across steps, when the subtitle and
              // the resend button appear around it.
              AutofillGroup(
                key: const ValueKey('signUp.autofillGroup'),
                onDisposeAction: AutofillContextAction.cancel,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ..._fields(state, l10n),
                      const Gap.vertical(height: AppSpacing.lg),
                      SubmitButton(
                        key: SignUpPage.submitButtonKey,
                        label: state.step == SignUpStep.password
                            ? l10n.createAccount
                            : l10n.continueAction,
                        isLoading: isLoading,
                        onPressed: () => _submit(state.step),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap.vertical(height: AppSpacing.sm),
              if (state.step == SignUpStep.verifyCode)
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.read<SignUpBloc>().add(
                          const SignUpEvent.codeResent(),
                        ),
                  child: Text(l10n.resendCode),
                ),
              // Serverpod sends no code to an email already registered, and
              // says nothing, so nobody can find out which emails have
              // accounts (doc/04g, AUTH-04b).
              if (state.step == SignUpStep.verifyCode) ...[
                Text(
                  l10n.signUpNoCodeHint,
                  key: SignUpPage.noCodeHintKey,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: customColors.muted,
                  ),
                ),
                TextButton(
                  onPressed: () => context.goNamed(signInRouteName),
                  child: Text(l10n.alreadyHaveAccount),
                ),
              ],
              if (state.step == SignUpStep.details) ...[
                const GoogleSignInButton(),
                const Gap.vertical(height: AppSpacing.sm),
              ],
              if (state.step == SignUpStep.details)
                TextButton(
                  onPressed: () => context.goNamed(signInRouteName),
                  child: Text(l10n.alreadyHaveAccount),
                ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _fields(SignUpState state, AppLocalizations l10n) {
    void toggle(SignUpEvent event) => context.read<SignUpBloc>().add(event);

    return switch (state.step) {
      SignUpStep.details => [
        InputField(
          key: SignUpPage.nameFieldKey,
          controller: _name,
          labelText: l10n.labelFullName,
          autofillHints: const [AutofillHints.name],
          validator: (value) => Validators.fullName(value, l10n),
        ),
        const Gap.vertical(height: AppSpacing.md),
        InputField(
          key: SignUpPage.emailFieldKey,
          controller: _email,
          labelText: l10n.labelEmail,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email, AutofillHints.username],
          validator: (value) => Validators.email(value, l10n),
        ),
      ],
      SignUpStep.verifyCode => [
        InputField(
          key: SignUpPage.codeFieldKey,
          controller: _code,
          labelText: l10n.labelVerificationCode,
          enableSuggestions: false,
          validator: (value) => Validators.code(value, l10n),
        ),
      ],
      SignUpStep.password => [
        // The password manager saves the new password under this email.
        InputField(
          key: SignUpPage.accountEmailFieldKey,
          initialValue: state.email,
          labelText: l10n.labelEmail,
          readOnly: true,
          autofillHints: const [AutofillHints.username],
          validator: null,
        ),
        const Gap.vertical(height: AppSpacing.md),
        InputField(
          key: SignUpPage.passwordFieldKey,
          controller: _password,
          labelText: l10n.labelPassword,
          hintText: l10n.passwordRuleHint,
          obscureText: !state.isPasswordVisible,
          suffixIcon: PasswordVisibilityButton(
            key: SignUpPage.passwordVisibilityButtonKey,
            isVisible: state.isPasswordVisible,
            onPressed: () =>
                toggle(const SignUpEvent.passwordVisibilityToggled()),
          ),
          enableSuggestions: false,
          autofillHints: const [AutofillHints.newPassword],
          validator: (value) => Validators.password(value, l10n),
        ),
        const Gap.vertical(height: AppSpacing.md),
        InputField(
          key: SignUpPage.confirmPasswordFieldKey,
          controller: _confirmPassword,
          labelText: l10n.labelConfirmPassword,
          obscureText: !state.isConfirmPasswordVisible,
          suffixIcon: PasswordVisibilityButton(
            key: SignUpPage.confirmPasswordVisibilityButtonKey,
            isVisible: state.isConfirmPasswordVisible,
            onPressed: () =>
                toggle(const SignUpEvent.confirmPasswordVisibilityToggled()),
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
