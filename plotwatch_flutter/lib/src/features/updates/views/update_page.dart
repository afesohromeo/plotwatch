import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One progress update in full, opened from the feed (UPD-02; doc/04e
/// M5-9 b), drawn as on the canvas (doc/05 §9.6): who posted it and the
/// text, then the stage, the workers and the weather when set, the issues,
/// and the way to the stage. On wide screens the facts go in a side card.
class UpdatePage extends StatefulWidget {
  const UpdatePage({
    super.key,
    required this.projectId,
    required this.updateId,
  });

  final int projectId;
  final int updateId;

  static const refreshButtonKey = Key('update.refresh');
  static const stageTileKey = Key('update.stage');
  static const stageLinkKey = Key('update.stageLink');
  static const backToActivityKey = Key('update.backToActivity');

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<UpdateBloc>().add(
    UpdateEvent.load(projectId: widget.projectId, updateId: widget.updateId),
  );

  void _toActivity() => context.goNamed(
    feedRouteName,
    pathParameters: {'projectId': '${widget.projectId}'},
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) {
        final update = state.update;
        return ResponsiveScaffoldWrapper(
          props: ScaffoldWrapperProps(
            leading: BackButton(onPressed: _toActivity),
            title: Text(l10n.updateTitle),
            // "Maison Douala · Today, 11:05" (doc/05 §9.6).
            subtitle: update == null
                ? projectNameOf(context)
                : [
                    ?projectNameOf(context),
                    dayAndTime(update.createdAt, l10n),
                  ].join(' · '),
            actions: [
              AppBarMenu(
                items: [
                  AppBarMenuItem(
                    key: UpdatePage.refreshButtonKey,
                    icon: Icons.refresh_rounded,
                    label: l10n.refresh,
                    onTap: _load,
                  ),
                ],
              ),
            ],
            bottom: ProjectBreadcrumbBar(
              projectId: widget.projectId,
              section: ProjectTab.activity,
              leaf: l10n.updateTitle,
            ),
          ),
          mobileBody: switch (state.loadStatus) {
            _ when update != null => _UpdateBody(
              projectId: widget.projectId,
              update: update,
              stageName: state.stageName,
              onRefresh: () async => _load(),
            ),
            GenericStatus.failure when state.notFound => _Gone(
              onBack: _toActivity,
            ),
            GenericStatus.failure => ErrorrWidget(
              errorMessage: state.loadErrorMessage ?? l10n.errorUpdateLoad,
              refreshText: l10n.refresh,
              onPressed: _load,
            ),
            _ => const UpdateSkeleton(),
          },
        );
      },
    );
  }
}

class _UpdateBody extends StatelessWidget {
  const _UpdateBody({
    required this.projectId,
    required this.update,
    required this.stageName,
    required this.onRefresh,
  });

  final int projectId;
  final ProgressUpdate update;
  final String? stageName;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stageId = update.stageId;
    final stage = stageId != null && stageName != null ? stageName : null;
    void openStage() => context.goNamed(
      stageRouteName,
      pathParameters: {'projectId': '$projectId', 'stageId': '$stageId'},
    );

    final author = _AuthorCard(update: update);
    final issues = switch (update.issues) {
      final text? when text.trim().isNotEmpty => _IssuesCallout(text: text),
      _ => null,
    };
    final stageLink = stage == null
        ? null
        : AppCard(
            key: UpdatePage.stageLinkKey,
            onTap: openStage,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.openStageTitle(stage),
                        style: context.textTheme.titleSmall?.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        l10n.openStageHint,
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: customColors.muted),
              ],
            ),
          );

    // The facts that were filled in, nothing for the others.
    final facts = <_Fact>[
      if (stage != null)
        _Fact(
          key: UpdatePage.stageTileKey,
          icon: Icons.layers_outlined,
          label: l10n.labelUpdateStage,
          value: stage,
          onTap: openStage,
        ),
      if (update.workersCount case final workers?)
        _Fact(
          icon: Icons.groups_outlined,
          label: l10n.labelWorkersCount,
          value: '$workers',
        ),
      if (update.weather case final weather?)
        _Fact(
          icon: weather.icon,
          label: l10n.labelWeather,
          value: weather.label(l10n),
          warm: weather == Weather.sunny,
        ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 840) {
          // The text on the left, the facts beside it (doc/05 §9.6).
          return ContentLayout(
            onRefresh: onRefresh,
            maxWidth: 1180,
            main: [author, ?issues],
            side: [
              _OnSiteCard(facts: facts, postedAt: update.createdAt),
              ?stageLink,
            ],
          );
        }
        return ContentLayout(
          onRefresh: onRefresh,
          main: [
            author,
            if (facts.isNotEmpty)
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < facts.length; i++) ...[
                      if (i > 0) const Gap.horizontal(width: AppSpacing.sm),
                      Expanded(child: _FactTile(fact: facts[i])),
                    ],
                  ],
                ),
              ),
            ?issues,
            ?stageLink,
          ],
        );
      },
    );
  }
}

/// Who posted it, when, and the text at reading size.
class _AuthorCard extends StatelessWidget {
  const _AuthorCard({required this.update});

  final ProgressUpdate update;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = update.authorName;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: customColors.ink,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  initialsOf(name ?? ''),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: customColors.onPrimary,
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
                      name == null
                          ? l10n.someone
                          : personLabel(
                              l10n,
                              name,
                              former: update.authorFormer,
                            ),
                      style: context.textTheme.titleMedium,
                    ),
                    // Only the site manager posts updates (UPD-01).
                    Text(
                      '${l10n.projectRoleSiteManager} · '
                      '${dayAndTime(update.createdAt, l10n)}',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap.vertical(height: 14),
          SelectableText(
            update.text,
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.55,
              color: customColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

/// One fact of the update: stage, workers or weather.
class _Fact {
  const _Fact({
    this.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.warm = false,
  });

  final Key? key;
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  /// Amber instead of the brand colour (sunny weather).
  final bool warm;
}

/// A fact as a small tile, three in a row on a phone.
class _FactTile extends StatelessWidget {
  const _FactTile({required this.fact});

  final _Fact fact;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: fact.key,
      onTap: fact.onTap,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(
            icon: fact.icon,
            size: 32,
            color: fact.warm ? customColors.partial : customColors.primary,
            background: fact.warm
                ? customColors.partialSoft
                : customColors.primarySoft,
          ),
          const Gap.vertical(height: 6),
          Text(
            fact.label,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            fact.value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleSmall?.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

/// The facts as rows in a side card (tablet and web).
class _OnSiteCard extends StatelessWidget {
  const _OnSiteCard({required this.facts, required this.postedAt});

  final List<_Fact> facts;
  final DateTime postedAt;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rows = [
      for (final fact in facts) (fact.label, fact.value, fact.onTap),
      (l10n.labelPosted, dayAndTime(postedAt, l10n), null),
    ];
    return AppCard(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.updateOnSite, style: context.textTheme.titleSmall),
          const Gap.vertical(height: 4),
          for (var i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                border: i == rows.length - 1
                    ? null
                    : Border(bottom: BorderSide(color: customColors.lineSoft)),
              ),
              child: Row(
                children: [
                  Text(rows[i].$1, style: context.textTheme.bodyMedium),
                  const Gap.horizontal(width: AppSpacing.md),
                  Expanded(
                    child: switch (rows[i].$3) {
                      final onTap? => Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: onTap,
                          child: Text(
                            '${rows[i].$2} ›',
                            style: context.textTheme.titleSmall?.copyWith(
                              color: customColors.primary,
                            ),
                          ),
                        ),
                      ),
                      _ => Text(
                        rows[i].$2,
                        textAlign: TextAlign.end,
                        style: context.textTheme.titleSmall,
                      ),
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// What went wrong on site, in amber (doc/05 §9.6).
class _IssuesCallout extends StatelessWidget {
  const _IssuesCallout({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: customColors.partialSoft,
        borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(
            icon: Icons.warning_amber_rounded,
            size: 36,
            color: customColors.partial,
            background: customColors.surfaceWhite,
          ),
          const Gap.horizontal(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.updateIssuesTitle,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    color: customColors.partial,
                  ),
                ),
                const Gap.vertical(height: 2),
                Text(
                  text,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: customColors.ink,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The update was deleted, or never was in this project.
class _Gone extends StatelessWidget {
  const _Gone({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.updateGone,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            const Gap.vertical(height: AppSpacing.md),
            OutlinedButton(
              key: UpdatePage.backToActivityKey,
              onPressed: onBack,
              child: Text(l10n.backToActivity),
            ),
          ],
        ),
      ),
    );
  }
}
