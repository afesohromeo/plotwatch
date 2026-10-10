import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A photo's badge as a 20 px dot: check, warning, cross (doc/05 §9.3).
class BadgeDot extends StatelessWidget {
  const BadgeDot({super.key, required this.level});

  final VerificationLevel level;

  @override
  Widget build(BuildContext context) {
    final (icon, background) = switch (level) {
      VerificationLevel.verified => (
        Icons.check_rounded,
        customColors.verifiedSoft,
      ),
      VerificationLevel.partiallyVerified => (
        Icons.priority_high_rounded,
        customColors.partialSoft,
      ),
      VerificationLevel.unverified => (
        Icons.close_rounded,
        customColors.unverifiedSoft,
      ),
      VerificationLevel.pending => (
        Icons.hourglass_top_rounded,
        customColors.lineSoft,
      ),
    };
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, size: 13, color: level.color),
    );
  }
}
