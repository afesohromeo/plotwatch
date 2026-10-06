import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Whether the text field inside the widget found by [fieldKey] hides its text.
bool isObscured(WidgetTester tester, Key fieldKey) {
  final textField = tester.widget<TextField>(
    find.descendant(of: find.byKey(fieldKey), matching: find.byType(TextField)),
  );
  return textField.obscureText;
}
