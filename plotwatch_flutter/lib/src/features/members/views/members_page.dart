import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's members with their role; the owner invites, changes roles,
/// removes members and cancels pending invitations (MEMB-01, 04, 05, 07).
/// The server enforces who may do what.
class MembersPage extends StatefulWidget {
  const MembersPage({super.key, required this.projectId});

  final int projectId;

  static const inviteButtonKey = Key('members.invite');
  static const refreshButtonKey = Key('members.refresh');
  static Key removeButtonKey(int memberId) => Key('members.remove.$memberId');
  static Key formerMemberKey(int memberId) => Key('members.former.$memberId');
  static Key changeRoleButtonKey(int memberId) =>
      Key('members.changeRole.$memberId');
  static Key roleOptionKey(ProjectRole role) =>
      Key('members.roleOption.${role.name}');
  static Key shareInvitationKey(int invitationId) =>
      Key('members.shareInvitation.$invitationId');
  static Key cancelInvitationKey(int invitationId) =>
      Key('members.cancelInvitation.$invitationId');

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<MembersBloc>().add(
    MembersEvent.fetchMembers(projectId: widget.projectId),
  );

  /// Opens the invite sheet: empty to create an invitation, or showing an
  /// existing [invitation] to share it again (doc/04b F3-1).
  Future<void> _openInviteSheet({Invitation? invitation}) async {
    final membersBloc = context.read<MembersBloc>();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => BlocProvider(
        create: (_) => InvitationBloc(
          membershipRepository: context.read<MembershipRepository>(),
          shareProvider: const ShareProvider(),
          clipboardProvider: const ClipboardProvider(),
          invitation: invitation,
        ),
        child: InviteSheet(
          projectId: widget.projectId,
          onCreated: (invitation) => membersBloc.add(
            MembersEvent.invitationCreated(invitation: invitation),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmRemove(MemberView view, AppLocalizations l10n) async {
    final bloc = context.read<MembersBloc>();
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.removeMemberTitle(view.fullName ?? view.email ?? ''),
      message: l10n.removeMemberMessage,
    );
    if (confirmed) {
      bloc.add(MembersEvent.removeMember(memberId: view.member.id!));
    }
  }

  /// The roles a member can be given; the current one is marked and
  /// picking it changes nothing (doc/04b H-4).
  Future<void> _chooseRole(MemberView view, AppLocalizations l10n) async {
    final bloc = context.read<MembersBloc>();
    final current = view.member.role;
    final role = await showDialog<ProjectRole>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.changeRoleTitle(view.fullName ?? view.email ?? '')),
        children: [
          for (final role in ProjectRole.values)
            if (role != ProjectRole.owner)
              SimpleDialogOption(
                key: MembersPage.roleOptionKey(role),
                onPressed: () => Navigator.of(dialogContext).pop(role),
                child: Row(
                  children: [
                    Expanded(child: Text(role.label(l10n))),
                    if (role == current)
                      Icon(Icons.check_rounded, color: customColors.primary),
                  ],
                ),
              ),
        ],
      ),
    );
    if (role != null && role != current) {
      bloc.add(MembersEvent.changeRole(memberId: view.member.id!, role: role));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<MembersBloc>();

    return BlocConsumer<MembersBloc, MembersState>(
      listenWhen: (previous, current) =>
          previous.actionStatus != current.actionStatus,
      listener: (context, state) {
        void resetFlowStep() => bloc.add(const MembersEvent.resetFlowStep());
        if (state.actionStatus == GenericStatus.failure &&
            state.actionErrorMessage != null) {
          DialogUtils.handleFailure(
            context,
            state.actionErrorMessage!,
            postActions: [resetFlowStep],
          );
        } else if (state.actionStatus == GenericStatus.success) {
          resetFlowStep();
        }
      },
      buildWhen: (previous, current) =>
          previous.membersStatus != current.membersStatus ||
          previous.members != current.members ||
          previous.invitations != current.invitations ||
          previous.overview != current.overview,
      builder: (context, state) {
        return ResponsiveScaffoldWrapper(
          props: ScaffoldWrapperProps(
            leading: BackButton(
              onPressed: () => context.goNamed(
                projectRouteName,
                pathParameters: {'projectId': '${widget.projectId}'},
              ),
            ),
            title: Text(l10n.membersTitle),
            actions: [
              IconButton(
                key: MembersPage.refreshButtonKey,
                tooltip: l10n.refresh,
                color: customColors.primary,
                icon: const Icon(Icons.refresh_rounded),
                onPressed: _load,
              ),
            ],
            showFloatingButton: state.isOwner && !state.isClosed,
            onPressed: _openInviteSheet,
            buttonIcon: Icon(
              Icons.person_add_alt_1_outlined,
              key: MembersPage.inviteButtonKey,
              semanticLabel: l10n.inviteAction,
            ),
          ),
          mobileBody: switch (state.membersStatus) {
            _ when state.overview != null => _MembersList(
              state: state,
              onRefresh: () async => _load(),
              onRemove: (view) => _confirmRemove(view, l10n),
              onChangeRole: (view) => _chooseRole(view, l10n),
              onShareInvitation: (invitation) =>
                  _openInviteSheet(invitation: invitation),
              onCancelInvitation: (invitation) => bloc.add(
                MembersEvent.cancelInvitation(invitationId: invitation.id!),
              ),
            ),
            GenericStatus.failure => ErrorrWidget(
              errorMessage: state.membersErrorMessage ?? l10n.errorMembersLoad,
              refreshText: l10n.refresh,
              onPressed: _load,
            ),
            _ => const Center(child: CircularProgressIndicator()),
          },
        );
      },
    );
  }
}

class _MembersList extends StatelessWidget {
  const _MembersList({
    required this.state,
    required this.onRemove,
    required this.onChangeRole,
    required this.onCancelInvitation,
    required this.onShareInvitation,
    required this.onRefresh,
  });

  final MembersState state;
  final ValueChanged<MemberView> onRemove;
  final ValueChanged<MemberView> onChangeRole;
  final ValueChanged<Invitation> onCancelInvitation;
  final ValueChanged<Invitation> onShareInvitation;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AuthFormLayout(
      title: state.overview!.project.name,
      subtitle: l10n.membersTitle,
      onRefresh: onRefresh,
      children: [
        for (final view in state.members)
          _Row(
            title: view.fullName ?? view.email ?? '',
            subtitle: view.fullName == null ? null : view.email,
            chip: ProjectChip(label: view.member.role.label(l10n)),
            action: state.isOwner && view.member.role != ProjectRole.owner
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!state.isClosed)
                      IconButton(
                        key: MembersPage.changeRoleButtonKey(view.member.id!),
                        tooltip: l10n.changeRoleTitle(view.fullName ?? ''),
                        color: customColors.primary,
                        icon: const Icon(Icons.manage_accounts_outlined),
                        onPressed: () => onChangeRole(view),
                      ),
                      IconButton(
                        key: MembersPage.removeButtonKey(view.member.id!),
                        tooltip: l10n.removeMemberTitle(view.fullName ?? ''),
                        color: customColors.unverified,
                        icon: const Icon(Icons.person_remove_outlined),
                        onPressed: () => onRemove(view),
                      ),
                    ],
                  )
                : null,
          ),
        // Removed members stay on record (doc/04e C-2b).
        if (state.formerMembers.isNotEmpty) ...[
          const Gap.vertical(height: AppSpacing.md),
          Text(l10n.formerMembersTitle, style: context.textTheme.titleMedium),
          const Gap.vertical(height: AppSpacing.sm),
          for (final view in state.formerMembers)
            _Row(
              key: MembersPage.formerMemberKey(view.member.id!),
              title: view.fullName ?? view.email ?? '',
              subtitle: _removedLine(l10n, view),
              chip: ProjectChip(
                label: view.member.role.label(l10n),
                color: customColors.muted,
              ),
            ),
        ],
        if (state.isOwner && state.invitations.isNotEmpty) ...[
          const Gap.vertical(height: AppSpacing.md),
          Text(l10n.pendingInvitations, style: context.textTheme.titleMedium),
          const Gap.vertical(height: AppSpacing.sm),
          for (final invitation in state.invitations)
            _Row(
              title: formatInvitationCode(invitation.code),
              subtitle: l10n.invitationExpires(
                formatDate(invitation.expiresAt.toLocal()),
              ),
              chip: ProjectChip(label: invitation.role.label(l10n)),
              action: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    key: MembersPage.shareInvitationKey(invitation.id!),
                    tooltip: l10n.shareInvitationAction,
                    color: customColors.primary,
                    icon: const Icon(Icons.ios_share_rounded),
                    onPressed: () => onShareInvitation(invitation),
                  ),
                  IconButton(
                    key: MembersPage.cancelInvitationKey(invitation.id!),
                    tooltip: l10n.cancelInvitationAction,
                    color: customColors.unverified,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => onCancelInvitation(invitation),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }
}

/// When a former member joined and left, and who removed them.
String _removedLine(AppLocalizations l10n, MemberView view) {
  final joined = formatDate(view.member.joinedAt.toLocal());
  final removedAt = view.member.removedAt;
  final removed = removedAt == null ? '' : formatDate(removedAt.toLocal());
  return switch (view.removedByName) {
    final String by => l10n.formerMemberRemovedBy(joined, removed, by),
    null => l10n.formerMemberRemoved(joined, removed),
  };
}

/// One member or invitation: title, optional subtitle, role chip, action.
class _Row extends StatelessWidget {
  const _Row({
    super.key,
    required this.title,
    required this.chip,
    this.subtitle,
    this.action,
  });

  final String title;
  final String? subtitle;
  final Widget chip;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.bodyLarge),
                if (subtitle != null)
                  Text(subtitle!, style: context.textTheme.bodySmall),
                const Gap.vertical(height: AppSpacing.xs),
                chip,
              ],
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
