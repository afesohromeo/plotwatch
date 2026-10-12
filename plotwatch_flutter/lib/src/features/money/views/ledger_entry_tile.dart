import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One ledger entry in the Money tab (canvas M-Money): what it was, which
/// stage, who and when, the amount as it moved the money, and its tag
/// (receipt, confirmation, reversal).
class LedgerEntryTile extends StatelessWidget {
  const LedgerEntryTile({
    super.key,
    required this.entry,
    required this.currencyCode,
    required this.onTap,
    this.stageName,
  });

  final LedgerEntry entry;
  final String currencyCode;
  final VoidCallback onTap;
  final String? stageName;

  static Key keyFor(int entryId) => Key('ledger.entry.$entryId');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (iconColor, iconBackground) = entry.isReversal
        ? (customColors.muted, customColors.lineSoft)
        : entry.isRelease
        ? (customColors.primary, customColors.primarySoft)
        : (customColors.accent, customColors.accentSoft);
    final inward = entry.isRelease == entry.amountMinor > 0;
    final line = [
      ?stageName,
      entry.recordedByName ?? l10n.someone,
      formatDate(entryDay(entry)),
    ].join(' · ');

    return AppCard(
      key: keyFor(entry.id!),
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          IconTile(
            icon: entry.icon,
            color: iconColor,
            background: iconBackground,
          ),
          const Gap.horizontal(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.isReversal
                      ? l10n.reversalOf(entry.note ?? '')
                      : entry.title(l10n),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  line,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall,
                ),
                // Spent on a finished stage: the funders see it at once.
                if (entry.afterApproval ?? false) ...[
                  const Gap.vertical(height: 4),
                  LedgerTag(
                    label: l10n.tagAfterApproval,
                    color: customColors.partial,
                    background: customColors.partialSoft,
                  ),
                ],
              ],
            ),
          ),
          const Gap.horizontal(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                entry.signed(currencyCode),
                style: context.textTheme.titleSmall?.copyWith(
                  color: inward && !entry.isReversal
                      ? customColors.verified
                      : customColors.ink,
                  decoration: entry.isReversed
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              const Gap.vertical(height: 4),
              LedgerTag.of(entry, l10n),
            ],
          ),
        ],
      ),
    );
  }
}

/// The calendar day an entry happened, kept as the day it was entered
/// (stored at UTC midnight), whatever the phone's time zone.
DateTime entryDay(LedgerEntry entry) => DateTime(
  entry.occurredOn.year,
  entry.occurredOn.month,
  entry.occurredOn.day,
);

/// A small pill under an entry's amount: Receipt, No receipt, Confirmed,
/// Not confirmed yet, Reversed, Reversal.
class LedgerTag extends StatelessWidget {
  const LedgerTag({
    super.key,
    required this.label,
    required this.color,
    required this.background,
  });

  factory LedgerTag.of(LedgerEntry entry, AppLocalizations l10n) {
    if (entry.isReversal) {
      return LedgerTag(
        label: l10n.tagReversal,
        color: customColors.muted,
        background: customColors.lineSoft,
      );
    }
    if (entry.isReversed) {
      return LedgerTag(
        label: l10n.tagReversed,
        color: customColors.muted,
        background: customColors.lineSoft,
      );
    }
    if (entry.isRelease) {
      return entry.confirmedAt == null
          ? LedgerTag(
              label: l10n.tagNotConfirmed,
              color: customColors.partial,
              background: customColors.partialSoft,
            )
          : LedgerTag(
              label: l10n.tagConfirmed,
              color: customColors.verified,
              background: customColors.verifiedSoft,
            );
    }
    return entry.hasReceipt
        ? LedgerTag(
            label: l10n.tagReceipt,
            color: customColors.verified,
            background: customColors.verifiedSoft,
          )
        : LedgerTag(
            label: l10n.tagNoReceipt,
            color: customColors.accent,
            background: customColors.accentSoft,
          );
  }

  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
