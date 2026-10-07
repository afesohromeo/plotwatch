import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Joining a project: type or paste the code (or open the invitation link),
/// see the project, role and inviter, then join (MEMB-03, AC-2).
class JoinProjectPage extends StatefulWidget {
  const JoinProjectPage({super.key, this.initialCode});

  /// From the invitation link `/join/:code`; checked at once.
  final String? initialCode;

  static const codeFieldKey = Key('join.code');
  static const checkButtonKey = Key('join.check');
  static const joinButtonKey = Key('join.join');

  @override
  State<JoinProjectPage> createState() => _JoinProjectPageState();
}

class _JoinProjectPageState extends State<JoinProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();

  @override
  void initState() {
    super.initState();
    final initialCode = widget.initialCode;
    if (initialCode != null && initialCode.isNotEmpty) {
      _code.text = initialCode;
      context.read<JoinProjectBloc>().add(
        JoinProjectEvent.previewRequested(code: initialCode),
      );
    }
    _code.addListener(_onCodeChanged);
  }

  /// Editing the code after a check drops the preview (doc/04b F2-1). The
  /// BLoC ignores edits that keep the checked code.
  void _onCodeChanged() {
    final state = context.read<JoinProjectBloc>().state;
    if (state.previewStatus != GenericStatus.initial &&
        _code.text.trim() != state.code) {
      context.read<JoinProjectBloc>().add(
        JoinProjectEvent.codeEdited(code: _code.text),
      );
    }
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _check() {
    if (!_formKey.currentState!.validate()) return;
    context.read<JoinProjectBloc>().add(
      JoinProjectEvent.previewRequested(code: _code.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<JoinProjectBloc>();

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: () => context.goNamed(homeRouteName)),
        title: Text(l10n.joinTitle),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<JoinProjectBloc, JoinProjectState>(
        listenWhen: (previous, current) =>
            previous.joinStatus != current.joinStatus,
        listener: (context, state) {
          if (state.joinStatus == GenericStatus.success &&
              state.joined != null) {
            context.goNamed(
              projectRouteName,
              pathParameters: {'projectId': '${state.joined!.projectId}'},
            );
          } else if (state.joinStatus == GenericStatus.failure &&
              state.joinErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.joinErrorMessage!,
              postActions: [
                () => bloc.add(const JoinProjectEvent.resetFlowStep()),
              ],
            );
          }
        },
        builder: (context, state) {
          final preview = state.preview;
          return AuthFormLayout(
            title: l10n.joinHeading,
            children: [
              Form(
                key: _formKey,
                child: InputField(
                  key: JoinProjectPage.codeFieldKey,
                  controller: _code,
                  labelText: l10n.labelInvitationCode,
                  enableSuggestions: false,
                  validator: (value) => Validators.invitationCode(value, l10n),
                ),
              ),
              const Gap.vertical(height: AppSpacing.md),
              SubmitButton(
                key: JoinProjectPage.checkButtonKey,
                label: l10n.checkCodeAction,
                isLoading: state.previewStatus == GenericStatus.loading,
                onPressed: _check,
              ),
              if (state.previewStatus == GenericStatus.failure &&
                  state.previewErrorMessage != null) ...[
                const Gap.vertical(height: AppSpacing.md),
                Text(
                  state.previewErrorMessage!,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: customColors.unverified,
                  ),
                ),
              ],
              if (state.previewStatus == GenericStatus.success &&
                  preview != null) ...[
                const Gap.vertical(height: AppSpacing.lg),
                Text(preview.projectName, style: context.textTheme.titleLarge),
                const Gap.vertical(height: AppSpacing.sm),
                Wrap(children: [ProjectChip(label: preview.role.label(l10n))]),
                if (preview.inviterName != null) ...[
                  const Gap.vertical(height: AppSpacing.sm),
                  Text(
                    l10n.invitedBy(preview.inviterName!),
                    style: context.textTheme.bodyMedium,
                  ),
                ],
                Text(
                  l10n.invitationExpires(
                    formatDate(preview.expiresAt.toLocal()),
                  ),
                  style: context.textTheme.bodySmall,
                ),
                const Gap.vertical(height: AppSpacing.lg),
                SubmitButton(
                  key: JoinProjectPage.joinButtonKey,
                  label: l10n.joinAction,
                  isLoading: state.joinStatus == GenericStatus.loading,
                  onPressed: () =>
                      bloc.add(const JoinProjectEvent.joinRequested()),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
