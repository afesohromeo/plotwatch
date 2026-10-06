import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Signed-in placeholder until the project list arrives in M2 (decision M1-8).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const signOutButtonKey = Key('home.signOut');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous.signOutStatus != current.signOutStatus,
      listener: (context, state) {
        if (state.signOutStatus == GenericStatus.failure &&
            state.signOutErrorMessage != null) {
          DialogUtils.handleFailure(context, state.signOutErrorMessage!);
        }
      },
      child: ResponsiveScaffoldWrapper(
        props: ScaffoldWrapperProps(
          title: Padding(
            padding: const EdgeInsets.only(left: AppSpacing.md),
            child: Text(l10n.homeTitle),
          ),
          actions: [
            TextButton.icon(
              key: signOutButtonKey,
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(const AuthenticationEvent.signOutRequested()),
              icon: const Icon(Icons.logout),
              label: Text(l10n.signOut),
            ),
          ],
        ),
        mobileBody: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              l10n.homePlaceholder,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
