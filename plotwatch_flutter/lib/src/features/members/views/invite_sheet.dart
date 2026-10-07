import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Bottom sheet: choose a role (and approval rights for a co-funder), create
/// the invitation, then show and share its code and link (MEMB-01;
/// decisions M2-6 to M2-8).
class InviteSheet extends StatelessWidget {
  const InviteSheet({super.key, required this.projectId, this.onCreated});

  final int projectId;

  /// Called once the invitation exists, so the members page lists it.
  final ValueChanged<Invitation>? onCreated;

  static const canApproveKey = Key('invite.canApprove');
  static const createButtonKey = Key('invite.create');
  static const shareButtonKey = Key('invite.share');

  /// Roles that can be invited; the owner role can't (decision M2-6).
  static const _roles = [
    ProjectRole.siteManager,
    ProjectRole.coFunder,
    ProjectRole.viewer,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<InvitationBloc>();

    return BlocConsumer<InvitationBloc, InvitationState>(
      listenWhen: (previous, current) =>
          previous.createStatus != current.createStatus,
      listener: (context, state) {
        if (state.createStatus == GenericStatus.success &&
            state.invitation != null) {
          onCreated?.call(state.invitation!);
        } else if (state.createStatus == GenericStatus.failure &&
            state.createErrorMessage != null) {
          DialogUtils.handleFailure(context, state.createErrorMessage!);
        }
      },
      builder: (context, state) {
        final invitation = state.invitation;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: invitation == null
                  ? _form(context, state, bloc, l10n)
                  : _created(context, invitation, bloc, l10n),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _form(
    BuildContext context,
    InvitationState state,
    InvitationBloc bloc,
    AppLocalizations l10n,
  ) {
    return [
      Text(l10n.inviteTitle, style: context.textTheme.headlineSmall),
      const Gap.vertical(height: AppSpacing.lg),
      Text(l10n.labelRole, style: context.textTheme.labelMedium),
      const Gap.vertical(height: 6),
      SegmentedButton<ProjectRole>(
        showSelectedIcon: false,
        segments: [
          for (final role in _roles)
            ButtonSegment(value: role, label: Text(role.label(l10n))),
        ],
        selected: {state.role},
        onSelectionChanged: (selection) =>
            bloc.add(InvitationEvent.roleChanged(role: selection.first)),
      ),
      if (state.role == ProjectRole.coFunder) ...[
        const Gap.vertical(height: AppSpacing.sm),
        SwitchListTile(
          key: canApproveKey,
          contentPadding: EdgeInsets.zero,
          value: state.canApprove,
          title: Text(l10n.canApproveLabel),
          onChanged: (value) =>
              bloc.add(InvitationEvent.canApproveChanged(canApprove: value)),
        ),
      ],
      const Gap.vertical(height: AppSpacing.lg),
      SubmitButton(
        key: createButtonKey,
        label: l10n.createInvitationAction,
        isLoading: state.createStatus == GenericStatus.loading,
        onPressed: () =>
            bloc.add(InvitationEvent.createSubmitted(projectId: projectId)),
      ),
    ];
  }

  List<Widget> _created(
    BuildContext context,
    Invitation invitation,
    InvitationBloc bloc,
    AppLocalizations l10n,
  ) {
    return [
      Text(l10n.invitationReadyTitle, style: context.textTheme.headlineSmall),
      const Gap.vertical(height: AppSpacing.sm),
      Text(l10n.invitationReadyText, style: context.textTheme.bodyMedium),
      const Gap.vertical(height: AppSpacing.lg),
      Center(
        child: SelectableText(
          formatInvitationCode(invitation.code),
          style: context.textTheme.headlineMedium?.copyWith(
            letterSpacing: 4,
            color: customColors.primary,
          ),
        ),
      ),
      const Gap.vertical(height: AppSpacing.sm),
      Center(
        child: SelectableText(
          invitationLink(invitation.code),
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall,
        ),
      ),
      const Gap.vertical(height: AppSpacing.lg),
      SubmitButton(
        key: shareButtonKey,
        label: l10n.shareAction,
        onPressed: () => bloc.add(const InvitationEvent.shareRequested()),
      ),
      const Gap.vertical(height: AppSpacing.sm),
      PrimaryButton(
        withBg: false,
        width: double.infinity,
        onPressed: () => Navigator.of(context).maybePop(),
        child: Text(l10n.doneAction),
      ),
    ];
  }
}
