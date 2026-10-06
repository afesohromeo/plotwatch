import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.inputFormatters,
      required this.validator,
      this.keyboardType,
      this.style,
      this.onChanged,
      this.onTap,
      this.labelText,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autofillHints,
      this.controller,
      this.initialValue,
      this.prefixIcon,
      this.suffixIcon,
      this.labelColor,
      this.bgColor,
      this.radius,
      this.maxlines,
      this.minlines,
      this.readOnly = false,
      this.enabled = true,
      this.hintText,
      this.padding,
      this.contentPadding,
      this.inputStyle,
      this.onEditingComplete,
      this.elevation = 0,
      this.focusNode,
      this.borderRadius,
      this.height = 35,
      this.visualDensity,
      this.autovalidateMode = AutovalidateMode.disabled});

  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? labelText;
  final bool obscureText;
  final bool enableSuggestions;

  /// Lets the browser or phone password manager fill this field, e.g.
  /// [AutofillHints.email]. Fields of one form go in an [AutofillGroup].
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final String? initialValue;
  final Icon? prefixIcon;
  final Color? labelColor;
  final Color? bgColor;

  final Widget? suffixIcon;
  final double? radius;
  final int? maxlines;

  final int? minlines;
  final bool? readOnly;
  final bool? enabled;
  final String? hintText;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;

  final TextStyle? inputStyle;
  final VoidCallback? onEditingComplete;
  final double elevation;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;
  final VisualDensity? visualDensity;
  final AutovalidateMode autovalidateMode;

  /// The label sits above the field (doc/05-design-system.md §5); screen
  /// readers read it just before the field. (No MergeSemantics: fields with
  /// their own tap actions, such as SearchableDropdownField, break it.)
  /// Borders, colours and text styles come from the theme.
  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      enabled: enabled,
      onTap: onTap,
      readOnly: readOnly!,
      maxLines: maxlines ?? 1,
      minLines: minlines,
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      validator: validator,
      keyboardType: keyboardType,
      style: inputStyle ?? context.textTheme.bodyLarge,
      onChanged: (value) {
        final error = validator?.call(value);

        if (error == null) {
          onChanged?.call(value); // ✅ only valid input passes
        }
      },
      decoration: customInputDecoration(
        visualDensity: visualDensity,
        null,
        prefixIcon,
        borderRadius: borderRadius,
        suffixIcon,
        labelColor,
        radius,
        hintText,
        contentPadding,
        context,
        bgColor: bgColor,
      ),
    );

    if (labelText == null) return field;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(labelText!, style: context.textTheme.labelMedium),
        const Gap.vertical(height: 6),
        field,
      ],
    );
  }
}
