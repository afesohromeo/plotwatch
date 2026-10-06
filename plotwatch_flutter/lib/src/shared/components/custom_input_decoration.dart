import 'package:flutter/material.dart';

/// Input decoration for the kit's fields. Borders, fill, text styles and the
/// focus/error colours come from the theme's `inputDecorationTheme`
/// (doc/05-design-system.md §5); this only adds what a field passes in.
/// [labelColor], [radius] and [borderRadius] are kept for existing callers
/// and no longer override the design system.
InputDecoration customInputDecoration(
  String? labelText,
  Icon? prefixIcon,
  Widget? suffixIcon,
  Color? labelColor,
  double? radius,
  String? hintText,
  EdgeInsets? contentPadding,
  BuildContext context, {
  FloatingLabelAlignment alignment = FloatingLabelAlignment.start,
  Color? bgColor,
  BorderRadius? borderRadius,
  VisualDensity? visualDensity,
}) {
  return InputDecoration(
    visualDensity: visualDensity,
    contentPadding: contentPadding,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    labelText: labelText,
    floatingLabelAlignment: alignment,
    fillColor: bgColor,
  );
}
