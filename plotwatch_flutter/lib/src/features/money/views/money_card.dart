import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The Overview's Money card (doc/04f M6-11): released, with a receipt,
/// and the unaccounted amount when it is high. Opens the Money tab.
class MoneyCard extends StatefulWidget {
  const MoneyCard({
    super.key,
    required this.projectId,
    required this.currencyCode,
  });

  final int projectId;
  final String currencyCode;

  static const cardKey = Key('project.moneyCard');

  @override
  State<MoneyCard> createState() => _MoneyCardState();
}

class _MoneyCardState extends State<MoneyCard> {
  @override
  void initState() {
    super.initState();
    context.read<MoneyBloc>().add(MoneyEvent.load(projectId: widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final code = widget.currencyCode;
    return BlocBuilder<MoneyBloc, MoneyState>(
      buildWhen: (previous, current) => previous.summary != current.summary,
      builder: (context, state) {
        final total = state.summary?.total;
        if (total == null) return const SizedBox.shrink();
        // As the Money tab (developer, 2026-10-14): what is left of the
        // money released, and what was spent without a receipt.
        final left = total.releasedMinor - total.spentMinor;
        final noReceipt = total.spentMinor - total.spentWithReceiptMinor;
        final alert = noReceipt > 0;
        return AppCard(
          key: MoneyCard.cardKey,
          onTap: () => context.goNamed(
            moneyRouteName,
            pathParameters: {'projectId': '${widget.projectId}'},
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              IconTile(
                icon: Icons.account_balance_wallet_outlined,
                color: alert ? customColors.accent : customColors.primary,
                background: alert
                    ? customColors.accentSoft
                    : customColors.primarySoft,
              ),
              const Gap.horizontal(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${formatMoney(total.releasedMinor, code)} '
                      '${l10n.moneyReleased.toLowerCase()}',
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      l10n.moneyStageLeft(formatMoney(left, code)),
                      style: context.textTheme.bodySmall,
                    ),
                    if (alert)
                      Text(
                        l10n.moneySpentNoReceipt(formatMoney(noReceipt, code)),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: customColors.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: customColors.muted),
            ],
          ),
        );
      },
    );
  }
}
