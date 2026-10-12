import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Email + password sign-in. On success the router moves to the home page.
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const emailFieldKey = Key('signIn.email');
  static const passwordFieldKey = Key('signIn.password');
  static const submitButtonKey = Key('signIn.submit');
  static const passwordVisibilityButtonKey = Key('signIn.passwordVisibility');

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<SignInBloc>().add(
      SignInEvent.signInSubmitted(email: _email.text, password: _password.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: () => context.goNamed(welcomeRouteName)),
        title: Text(l10n.signIn),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<SignInBloc, SignInState>(
        listenWhen: (previous, current) =>
            previous.signInStatus != current.signInStatus,
        listener: (context, state) {
          if (state.signInStatus == GenericStatus.failure &&
              state.signInErrorMessage != null) {
            DialogUtils.handleFailure(context, state.signInErrorMessage!);
          } else if (state.signInStatus == GenericStatus.success) {
            // Offers to save the login in the browser or phone password
            // manager.
            TextInput.finishAutofillContext();
          }
        },
        buildWhen: (previous, current) =>
            previous.signInStatus != current.signInStatus ||
            previous.isPasswordVisible != current.isPasswordVisible,
        builder: (context, state) {
          return AuthFormLayout(
            title: l10n.signInHeading,
            children: [
              // Leaving without signing in must not offer to save what was
              // typed; success saves it explicitly (listener above).
              AutofillGroup(
                onDisposeAction: AutofillContextAction.cancel,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InputField(
                        key: SignInPage.emailFieldKey,
                        controller: _email,
                        labelText: l10n.labelEmail,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [
                          AutofillHints.email,
                          AutofillHints.username,
                        ],
                        validator: (value) => Validators.email(value, l10n),
                      ),
                      const Gap.vertical(height: AppSpacing.md),
                      InputField(
                        key: SignInPage.passwordFieldKey,
                        controller: _password,
                        labelText: l10n.labelPassword,
                        obscureText: !state.isPasswordVisible,
                        enableSuggestions: false,
                        autofillHints: const [AutofillHints.password],
                        suffixIcon: PasswordVisibilityButton(
                          key: SignInPage.passwordVisibilityButtonKey,
                          isVisible: state.isPasswordVisible,
                          onPressed: () => context.read<SignInBloc>().add(
                            const SignInEvent.passwordVisibilityToggled(),
                          ),
                        ),
                        validator: (value) => (value ?? '').isEmpty
                            ? l10n.validatePasswordRequired
                            : null,
                      ),
                      const Gap.vertical(height: AppSpacing.lg),
                      SubmitButton(
                        key: SignInPage.submitButtonKey,
                        label: l10n.signIn,
                        isLoading: state.signInStatus == GenericStatus.loading,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
              const GoogleSignInButton(),
              const Gap.vertical(height: AppSpacing.sm),
              TextButton(
                onPressed: () => context.goNamed(passwordResetRouteName),
                child: Text(l10n.forgotPassword),
              ),
              TextButton(
                onPressed: () => context.goNamed(signUpRouteName),
                child: Text(l10n.noAccountYet),
              ),
            ],
          );
        },
      ),
    );
  }
}
