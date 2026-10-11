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
  static Key memberMenuKey(int memberId) => Key('members.menu.$memberId');
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
            // "Maison Douala · 4 people" (doc/05 §9.3).
            subtitle: state.overview == null
                ? null
                : '${state.overview!.project.name} · '
                      '${l10n.peopleCount(state.members.length)}',
            bottom: ProjectBreadcrumbBar(
              projectId: widget.projectId,
              projectName: state.overview?.project.name,
              leaf: l10n.membersTitle,
            ),
            actions: [
              AppBarMenu(
                items: [
                  AppBarMenuItem(
                    key: MembersPage.refreshButtonKey,
                    icon: Icons.refresh_rounded,
                    label: l10n.refresh,
                    onTap: _load,
                  ),
                ],
              ),
            ],
            showFloatingButton: state.isOwner && !state.isClosed,
            onPressed: _openInviteSheet,
            buttonLabel: l10n.inviteAction,
            buttonIcon: Icon(
              Icons.person_add_alt_1_outlined,
              key: MembersPage.inviteButtonKey,
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
            _ => const MembersSkeleton(),
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

    final canManage = state.isOwner;
    return ContentLayout(
      maxWidth: 720,
      onRefresh: onRefresh,
      main: [
        // Everyone in one card (doc/05 §9.3).
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            children: [
              for (var i = 0; i < state.members.length; i++)
                _MemberRow(
                  view: state.members[i],
                  last: i == state.members.length - 1,
                  menu:
                      canManage &&
                          state.members[i].member.role != ProjectRole.owner
                      ? [
                          if (!state.isClosed)
                            AppBarMenuItem(
                              key: MembersPage.changeRoleButtonKey(
                                state.members[i].member.id!,
                              ),
                              icon: Icons.manage_accounts_outlined,
                              label: l10n.changeRoleTitle(
                                state.members[i].fullName ?? '',
                              ),
                              onTap: () => onChangeRole(state.members[i]),
                            ),
                          AppBarMenuItem(
                            key: MembersPage.removeButtonKey(
                              state.members[i].member.id!,
                            ),
                            icon: Icons.person_remove_outlined,
                            label: l10n.removeMemberTitle(
                              state.members[i].fullName ?? '',
                            ),
                            destructive: true,
                            onTap: () => onRemove(state.members[i]),
                          ),
                        ]
                      : const [],
                ),
            ],
          ),
        ),
        if (canManage && state.invitations.isNotEmpty) ...[
          Text(l10n.pendingInvitations, style: context.textTheme.titleMedium),
          for (final invitation in state.invitations)
            DashedBorder(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatInvitationCode(invitation.code),
                            style: context.textTheme.titleMedium?.copyWith(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '${invitation.role.label(l10n)} · '
                            '${l10n.invitationExpires(formatDate(invitation.expiresAt.toLocal()))}',
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      key: MembersPage.shareInvitationKey(invitation.id!),
                      onPressed: () => onShareInvitation(invitation),
                      child: Text(l10n.shareInvitationAction),
                    ),
                    IconButton(
                      key: MembersPage.cancelInvitationKey(invitation.id!),
                      tooltip: l10n.cancelInvitationAction,
                      color: customColors.muted,
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => onCancelInvitation(invitation),
                    ),
                  ],
                ),
              ),
            ),
        ],
        // Removed members stay on record (doc/04e C-2b).
        if (state.formerMembers.isNotEmpty) ...[
          Text(
            l10n.formerMembersTitle,
            style: context.textTheme.titleMedium?.copyWith(
              color: customColors.muted,
            ),
          ),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Column(
              children: [
                for (var i = 0; i < state.formerMembers.length; i++)
                  _MemberRow(
                    key: MembersPage.formerMemberKey(
                      state.formerMembers[i].member.id!,
                    ),
                    view: state.formerMembers[i],
                    former: true,
                    subtitle: _removedLine(l10n, state.formerMembers[i]),
                    last: i == state.formerMembers.length - 1,
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

/// One member (doc/05 §9.3): their initials in the role's tone, name and
/// a line under it, the role chip, and the owner's ⋮.
class _MemberRow extends StatelessWidget {
  const _MemberRow({
    super.key,
    required this.view,
    required this.last,
    this.menu = const [],
    this.former = false,
    this.subtitle,
  });

  final MemberView view;
  final bool last;
  final List<AppBarMenuItem> menu;
  final bool former;
  final String? subtitle;

  static (Color, Color) toneOf(ProjectRole role) => switch (role) {
    ProjectRole.owner => (customColors.primary, customColors.onPrimary),
    ProjectRole.siteManager => (customColors.ink, customColors.onPrimary),
    ProjectRole.coFunder => (customColors.accent, customColors.onPrimary),
    ProjectRole.viewer => (customColors.line, customColors.ink),
  };

  static (Color, Color) chipOf(ProjectRole role) => switch (role) {
    ProjectRole.owner => (customColors.primarySoft, customColors.primary),
    ProjectRole.siteManager => (
      customColors.accentSoft,
      const Color(0xFF7E3719),
    ),
    _ => (customColors.ground, customColors.ink),
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = view.fullName ?? view.email ?? '';
    final role = view.member.role;
    final (avatar, initials) = former
        ? (customColors.ground, customColors.muted)
        : toneOf(role);
    final (chipBg, chipText) = former
        ? (customColors.ground, customColors.muted)
        : chipOf(role);
    final line =
        subtitle ??
        [
          if (view.fullName != null && view.email != null) view.email!,
          if (role == ProjectRole.coFunder && view.member.canApprove)
            l10n.canApproveShort,
        ].join(' · ');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: customColors.lineSoft)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: avatar, shape: BoxShape.circle),
            child: Text(
              initialsOf(name),
              style: context.textTheme.labelMedium?.copyWith(
                color: initials,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Gap.horizontal(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: former ? customColors.muted : customColors.ink,
                  ),
                ),
                if (line.isNotEmpty)
                  Text(
                    line,
                    style: context.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const Gap.horizontal(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              role.label(l10n),
              style: context.textTheme.labelSmall?.copyWith(color: chipText),
            ),
          ),
          if (menu.isNotEmpty)
            PopupMenuButton<int>(
              key: MembersPage.memberMenuKey(view.member.id!),
              tooltip: l10n.moreActions,
              icon: Icon(Icons.more_vert_rounded, color: customColors.muted),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              color: customColors.surfaceWhite,
              surfaceTintColor: Colors.transparent,
              onSelected: (index) => menu[index].onTap(),
              itemBuilder: (context) => [
                for (var i = 0; i < menu.length; i++)
                  PopupMenuItem<int>(
                    key: menu[i].key,
                    value: i,
                    child: Text(
                      menu[i].label,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: menu[i].destructive
                            ? customColors.unverified
                            : customColors.ink,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
