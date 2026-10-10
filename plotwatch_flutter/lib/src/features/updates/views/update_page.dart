import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One progress update in full, opened from the feed (UPD-02; doc/04e
/// M5-9 b).
class UpdatePage extends StatefulWidget {
  const UpdatePage({
    super.key,
    required this.projectId,
    required this.updateId,
  });

  final int projectId;
  final int updateId;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<UpdateBloc>().add(
    UpdateEvent.load(projectId: widget.projectId, updateId: widget.updateId),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(
          onPressed: () => context.goNamed(
            feedRouteName,
            pathParameters: {'projectId': '${widget.projectId}'},
          ),
        ),
        title: Text(l10n.updateTitle),
      ),
      mobileBody: BlocBuilder<UpdateBloc, UpdateState>(
        builder: (context, state) {
          final update = state.update;
          return switch (state.loadStatus) {
            _ when update != null => AuthFormLayout(
              title: l10n.updateTitle,
              subtitle: formatDate(update.createdAt.toLocal(), withTime: true),
              children: [
                Text(update.text, style: context.textTheme.bodyLarge),
                const Gap.vertical(height: AppSpacing.lg),
                if (update.authorName case final name?)
                  DetailRow(
                    label: l10n.labelPostedBy,
                    value: personLabel(
                      l10n,
                      name,
                      former: update.authorFormer,
                    ),
                  ),
                if (state.stageName case final stage?)
                  DetailRow(label: l10n.labelUpdateStage, value: stage),
                if (update.workersCount case final workers?)
                  DetailRow(label: l10n.labelWorkersCount, value: '$workers'),
                if (update.weather case final weather?)
                  DetailRow(
                    label: l10n.labelWeather,
                    value: weather.label(l10n),
                  ),
                if (update.issues case final issues?)
                  DetailRow(label: l10n.labelUpdateIssues, value: issues),
              ],
            ),
            GenericStatus.failure => ErrorrWidget(
              errorMessage: state.loadErrorMessage ?? l10n.errorUpdateLoad,
              refreshText: l10n.refresh,
              onPressed: _load,
            ),
            _ => const Center(child: CircularProgressIndicator()),
          };
        },
      ),
    );
  }
}
