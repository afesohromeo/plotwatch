import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// First page for signed-out users: mark, name and tagline in the middle,
/// the two actions at the bottom (design canvas, direction A).
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: const ScaffoldWrapperProps(hasAppbar: false),
      mobileBody: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AuthFormLayout.maxWidth),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.where_to_vote_rounded,
                        size: 64,
                        color: customColors.primary,
                      ),
                      const Gap.vertical(height: AppSpacing.md),
                      Text(l10n.appTitle, style: context.textTheme.displaySmall),
                      const Gap.vertical(height: AppSpacing.sm),
                      Text(
                        l10n.welcomeTagline,
                        style: context.textTheme.bodyMedium?.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SubmitButton(
                  label: l10n.signIn,
                  onPressed: () => context.goNamed(signInRouteName),
                ),
                const Gap.vertical(height: AppSpacing.md),
                PrimaryButton(
                  withBg: false,
                  width: double.infinity,
                  onPressed: () => context.goNamed(signUpRouteName),
                  child: Text(l10n.createAccount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
