import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The site radius: a label, a 10–500 m slider in 5 m steps and the value
/// (SITE-03). Shared by the validate and the edit pages (doc/04b H-3).
class SiteRadiusField extends StatelessWidget {
  const SiteRadiusField({
    super.key,
    required this.sliderKey,
    required this.radiusM,
    required this.onChanged,
  });

  /// Lets each page's tests find its slider.
  final Key sliderKey;
  final int radiusM;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.labelRadius, style: context.textTheme.labelMedium),
        Row(
          children: [
            Expanded(
              child: Slider(
                key: sliderKey,
                min: minSiteRadiusM.toDouble(),
                max: maxSiteRadiusM.toDouble(),
                divisions: (maxSiteRadiusM - minSiteRadiusM) ~/ 5,
                value: radiusM.toDouble(),
                label: l10n.radiusMeters(radiusM),
                onChanged: (value) => onChanged(value.round()),
              ),
            ),
            Text(
              l10n.radiusMeters(radiusM),
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
