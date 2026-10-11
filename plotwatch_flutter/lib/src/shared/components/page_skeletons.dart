import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The pages' shapes while they load for the first time (doc/05 §9.8),
/// built from [SkeletonCard], [SkeletonRow] and [SkeletonHero] so each one
/// looks like the page that comes.

/// Two columns from [ContentLayout]'s width, one below it.
Widget _columns(List<Widget> main, List<Widget> side) => LayoutBuilder(
  builder: (context, constraints) {
    Widget column(List<Widget> children) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const Gap.vertical(height: 14),
          children[i],
        ],
      ],
    );
    if (constraints.maxWidth < 840 || side.isEmpty) {
      return column([...main, ...side]);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: column(main)),
        const Gap.horizontal(width: 20),
        Expanded(flex: 2, child: column(side)),
      ],
    );
  },
);

/// The project list: cards with a cover.
class ProjectListSkeleton extends StatelessWidget {
  const ProjectListSkeleton({super.key, this.count = 2});

  final int count;

  @override
  Widget build(BuildContext context) {
    // Whatever room it gets, without overflowing.
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) const Gap.vertical(height: AppSpacing.md),
            const _CoverCard(),
          ],
        ],
      ),
    );
  }
}

class _CoverCard extends StatelessWidget {
  const _CoverCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: ShimmerSkeleton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SkeletonBox(height: ProjectCard.coverHeight, radius: 0),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FractionallySizedBox(
                    widthFactor: .55,
                    child: SkeletonBox(height: 18),
                  ),
                  Gap.vertical(height: 8),
                  FractionallySizedBox(
                    widthFactor: .35,
                    child: SkeletonBox(height: 12),
                  ),
                  Gap.vertical(height: 14),
                  SkeletonBox(height: 8, radius: 4),
                  Gap.vertical(height: 10),
                  FractionallySizedBox(
                    widthFactor: .8,
                    child: SkeletonBox(height: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The Overview: the hero, the attention and members cards, then the side
/// cards.
class OverviewSkeleton extends StatelessWidget {
  const OverviewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      maxWidth: 1200,
      children: [
        _columns(
          [
            const SkeletonHero(),
            SkeletonCard.rows(count: 1),
            SkeletonCard.rows(count: 1),
          ],
          [SkeletonCard.rows(count: 4), SkeletonCard.text()],
        ),
      ],
    );
  }
}

/// The Stages tab: the summary line, the chips, the timeline.
class StagePlanSkeleton extends StatelessWidget {
  const StagePlanSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      maxWidth: 640,
      children: [
        const ShimmerSkeleton(
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: .7,
            child: SkeletonBox(height: 14),
          ),
        ),
        for (var i = 0; i < 4; i++)
          Row(
            children: [
              const ShimmerSkeleton(child: SkeletonBox.circle(size: 24)),
              const Gap.horizontal(width: 12),
              Expanded(child: SkeletonCard.rows(count: 1)),
            ],
          ),
      ],
    );
  }
}

/// The stage page: the chips line, then the checklist.
class StageSkeleton extends StatelessWidget {
  const StageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      maxWidth: 1200,
      children: [
        _columns(
          [
            const ShimmerSkeleton(
              child: Row(
                children: [
                  SkeletonBox(width: 150, height: 26, radius: 13),
                  Gap.horizontal(width: 8),
                  SkeletonBox(width: 90, height: 26, radius: 13),
                ],
              ),
            ),
            SkeletonCard.rows(count: 3, trailing: true),
          ],
          [
            const ShimmerSkeleton(child: SkeletonBox(height: 220, radius: 16)),
          ],
        ),
      ],
    );
  }
}

/// The photo page: the photo, the verdict, the details.
class EvidenceSkeleton extends StatelessWidget {
  const EvidenceSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      maxWidth: 1200,
      children: [
        _columns(
          [const ShimmerSkeleton(child: SkeletonBox(height: 260, radius: 16))],
          [SkeletonCard.rows(count: 1), SkeletonCard.text(lines: 5)],
        ),
      ],
    );
  }
}

/// A list's rows in cards (Activity, notifications), each its own card.
class RowsSkeleton extends StatelessWidget {
  const RowsSkeleton({super.key, this.count = 5, this.trailing = false});

  final int count;
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) const Gap.vertical(height: AppSpacing.sm),
          SkeletonCard(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: SkeletonRow(trailing: trailing),
          ),
        ],
      ],
    );
  }
}

/// The members page: one card of member rows.
class MembersSkeleton extends StatelessWidget {
  const MembersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      maxWidth: 720,
      children: [SkeletonCard.rows(count: 4, trailing: true)],
    );
  }
}

/// A progress update: the author and text, the three tiles.
class UpdateSkeleton extends StatelessWidget {
  const UpdateSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      maxWidth: 1180,
      children: [
        _columns(
          [SkeletonCard.text(lines: 4)],
          [SkeletonCard.rows(count: 3)],
        ),
      ],
    );
  }
}

/// The Money tab: the summary, the switch, the entries.
class MoneySkeleton extends StatelessWidget {
  const MoneySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkeletonPage(
      children: [
        SkeletonHero(height: 150),
        ShimmerSkeleton(child: SkeletonBox(height: 44, radius: 12)),
        RowsSkeleton(count: 4, trailing: true),
      ],
    );
  }
}

/// A ledger entry: the amount card, the details.
class LedgerEntrySkeleton extends StatelessWidget {
  const LedgerEntrySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      maxWidth: 720,
      children: [SkeletonCard.text(lines: 2), SkeletonCard.text(lines: 4)],
    );
  }
}
