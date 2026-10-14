import 'package:flutter/material.dart';

/// An amount on one line, shrunk to fit its space rather than wrapped onto
/// two (developer, 2026-10-14: "20,650,000 FCFA" broke in the Money cards).
class OneLineAmount extends StatelessWidget {
  const OneLineAmount(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text, maxLines: 1, softWrap: false, style: style),
    );
  }
}
