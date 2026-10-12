import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// "or", then Continue with Google in Plotwatch's outlined style, with
/// Google's own G (its branding rules). Hidden where Google sign-in isn't
/// configured (doc/04g step 4).
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  static const buttonKey = Key('googleSignIn.button');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<GoogleSignInBloc, GoogleSignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == GenericStatus.failure &&
            state.errorMessage != null) {
          DialogUtils.handleFailure(context, state.errorMessage!);
          context.read<GoogleSignInBloc>().add(const GoogleSignInEvent.reset());
        }
      },
      builder: (context, state) {
        if (!state.isAvailable) return const SizedBox.shrink();
        final isLoading = state.status == GenericStatus.loading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap.vertical(height: AppSpacing.md),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  child: Text(
                    l10n.orDivider,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: customColors.muted,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const Gap.vertical(height: AppSpacing.md),
            OutlinedButton(
              key: buttonKey,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () => context.read<GoogleSignInBloc>().add(
                      GoogleSignInEvent.started(
                        locale: Localizations.localeOf(context).languageCode,
                      ),
                    ),
              child: isLoading
                  ? const SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/google.svg',
                          package: 'serverpod_auth_idp_flutter',
                          width: 20,
                          height: 20,
                        ),
                        const Gap.horizontal(width: AppSpacing.sm),
                        Flexible(
                          child: Text(
                            l10n.continueWithGoogle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}
