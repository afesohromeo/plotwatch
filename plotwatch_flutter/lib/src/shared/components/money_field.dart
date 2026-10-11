import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// An amount in [currencyCode], typed in the app language (decision M3-9).
/// Empty means no amount yet; the caller reads the value with
/// [parseMoney]. The check mirrors the server's (0 to 10^15 minor units,
/// no more decimals than the currency has).
class MoneyField extends StatelessWidget {
  const MoneyField({
    super.key,
    required this.controller,
    required this.currencyCode,
    required this.labelText,
  });

  final TextEditingController controller;
  final String currencyCode;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return InputField(
      controller: controller,
      labelText: labelText,
      keyboardType: TextInputType.numberWithOptions(
        decimal: currencyDigits(currencyCode) > 0,
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        // The symbol, as amounts are written: FCFA (decision M3-9, 2026-10-11).
        child: Text(
          currencySymbol(currencyCode),
          style: context.textTheme.bodyMedium,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return null;
        return parseMoney(value, currencyCode, locale: locale) == null
            ? l10n.validateBudgetInvalid
            : null;
      },
    );
  }
}
