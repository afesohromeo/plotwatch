import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The project page's latest 5 events, live, with "See all" (FEED-01,
/// doc/04e M5-7).
class LatestActivity extends StatefulWidget {
  const LatestActivity({super.key, required this.projectId});

  final int projectId;

  static const shown = 5;
  static const seeAllButtonKey = Key('activity.seeAll');
  static const retryButtonKey = Key('activity.retry');

  @override
  State<LatestActivity> createState() => _LatestActivityState();
}

class _LatestActivityState extends State<LatestActivity> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<FeedBloc>().add(
    FeedEvent.fetchActivity(
      projectId: widget.projectId,
      size: LatestActivity.shown,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        final latest = state.activity.take(LatestActivity.shown).toList();
        // A card with "See all" in its header (doc/05 §9).
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.latestActivityTitle,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  if (latest.isNotEmpty)
                    TextButton(
                      key: LatestActivity.seeAllButtonKey,
                      onPressed: () => context.goNamed(
                        feedRouteName,
                        pathParameters: {'projectId': '${widget.projectId}'},
                      ),
                      child: Text(l10n.seeAll),
                    ),
                ],
              ),
              if (state.reconnecting) const ReconnectingLine(),
              const Gap.vertical(height: AppSpacing.xs),
              if (latest.isEmpty) ...[
                Text(switch (state.activityListStatus) {
                  GenericStatus.failure =>
                    state.activityListError ?? l10n.errorActivityLoad,
                  GenericStatus.success => l10n.activityEmpty,
                  _ => l10n.loading,
                }, style: context.textTheme.bodyMedium),
                // A failed card can be tried again in place (doc/05 §9.4).
                if (state.activityListStatus == GenericStatus.failure)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      key: LatestActivity.retryButtonKey,
                      onPressed: _load,
                      child: Text(l10n.refresh),
                    ),
                  ),
              ] else
                for (final entry in latest) ActivityTile(entry: entry),
            ],
          ),
        );
      },
    );
  }
}
