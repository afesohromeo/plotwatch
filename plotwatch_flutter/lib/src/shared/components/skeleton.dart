import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Sweeps a soft highlight across the [SkeletonBox]es inside [child], the
/// shape of a page while it loads (doc/05 §9.8; from PlusLocate). Stays
/// still when the system "reduce animations" setting is on, and is
/// announced as "Loading".
class ShimmerSkeleton extends StatefulWidget {
  const ShimmerSkeleton({super.key, required this.child});

  final Widget child;

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = customColors.ink.withValues(alpha: 0.08);
    final highlight = customColors.ink.withValues(alpha: 0.03);

    return Semantics(
      label: AppLocalizations.of(context)!.loading,
      child: ExcludeSemantics(
        child: AnimatedBuilder(
          animation: _controller,
          child: widget.child,
          builder: (context, child) => ShaderMask(
            // Paints the gradient only where the (opaque) boxes are.
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => LinearGradient(
              begin: const Alignment(-1, -0.3),
              end: const Alignment(1, 0.3),
              colors: [base, highlight, base],
              stops: const [0.35, 0.5, 0.65],
              transform: _SlidingGradientTransform(_controller.value * 2 - 1),
            ).createShader(bounds),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.slidePercent);

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
}

/// A placeholder shape for [ShimmerSkeleton].
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.radius = 6,
  });

  /// A circle of [size].
  const SkeletonBox.circle({super.key, required double size})
    : width = size,
      height = size,
      radius = size / 2;

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // Any opaque colour: ShimmerSkeleton recolours it.
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// A list row while it loads: an icon square and two lines.
class SkeletonRow extends StatelessWidget {
  const SkeletonRow({super.key, this.trailing = false, this.square = 40});

  /// A short figure at the end, e.g. an amount.
  final bool trailing;
  final double square;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SkeletonBox(width: square, height: square, radius: square * .3),
          const Gap.horizontal(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FractionallySizedBox(
                  widthFactor: .7,
                  child: SkeletonBox(height: 14),
                ),
                Gap.vertical(height: 6),
                FractionallySizedBox(
                  widthFactor: .45,
                  child: SkeletonBox(height: 11),
                ),
              ],
            ),
          ),
          if (trailing) ...[
            const Gap.horizontal(width: 12),
            const SkeletonBox(width: 64, height: 14),
          ],
        ],
      ),
    );
  }
}

/// A white card holding [rows] of a loading page.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key, required this.child, this.padding});

  /// The shapes; wrapped in a [ShimmerSkeleton] here.
  final Widget child;
  final EdgeInsetsGeometry? padding;

  /// [count] rows in a card, e.g. a list's first page.
  factory SkeletonCard.rows({
    Key? key,
    int count = 3,
    bool trailing = false,
  }) => SkeletonCard(
    key: key,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    child: Column(
      children: [
        for (var i = 0; i < count; i++) SkeletonRow(trailing: trailing),
      ],
    ),
  );

  /// A card with a title line and [lines] text lines.
  factory SkeletonCard.text({Key? key, int lines = 3}) => SkeletonCard(
    key: key,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FractionallySizedBox(
          widthFactor: .4,
          child: SkeletonBox(height: 16),
        ),
        for (var i = 0; i < lines; i++) ...[
          const Gap.vertical(height: 10),
          FractionallySizedBox(
            widthFactor: i == lines - 1 ? .6 : 1,
            child: const SkeletonBox(height: 12),
          ),
        ],
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      child: ShimmerSkeleton(child: child),
    );
  }
}

/// The teal hero's place while it loads (the Overview, the Money tab).
class SkeletonHero extends StatelessWidget {
  const SkeletonHero({super.key, this.height = 170});

  final double height;

  @override
  Widget build(BuildContext context) {
    return ShimmerSkeleton(
      child: SkeletonBox(height: height, radius: PlotwatchTheme.heroRadius),
    );
  }
}

/// A scrolling page of loading [children], padded like [ContentLayout].
class SkeletonPage extends StatelessWidget {
  const SkeletonPage({super.key, required this.children, this.maxWidth = 840});

  final List<Widget> children;
  final double maxWidth;

  static const pageKey = Key('skeleton.page');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: pageKey,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const Gap.vertical(height: 14),
                children[i],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
