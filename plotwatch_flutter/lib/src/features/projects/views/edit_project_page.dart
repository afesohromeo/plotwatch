import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The owner edits a project's details (PROJ-04). The server checks that
/// the caller is the owner.
class EditProjectPage extends StatefulWidget {
  const EditProjectPage({super.key, required this.projectId});

  final int projectId;

  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProjectOverviewBloc>();
    if (bloc.state.overview?.project.id != widget.projectId) {
      bloc.add(ProjectOverviewEvent.fetchProject(projectId: widget.projectId));
    }
  }

  void _backToProject() => context.goNamed(
    projectRouteName,
    pathParameters: {'projectId': '${widget.projectId}'},
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProjectOverviewBloc>();

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: _backToProject),
        title: Text(l10n.editProjectTitle),
        bottom: ProjectBreadcrumbBar(
          projectId: widget.projectId,
          leaf: l10n.editProjectTitle,
        ),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<ProjectOverviewBloc, ProjectOverviewState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus ||
            previous.overviewStatus != current.overviewStatus,
        listener: (context, state) {
          void resetFlowStep() =>
              bloc.add(const ProjectOverviewEvent.resetFlowStep());

          if (state.actionStatus == GenericStatus.success) {
            DialogUtils.handleSuccess(
              context,
              l10n.projectSaved,
              postActions: [resetFlowStep, _backToProject],
            );
          } else if (state.actionStatus == GenericStatus.failure &&
              state.actionErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.actionErrorMessage!,
              postActions: [resetFlowStep],
            );
          } else if (state.overviewStatus == GenericStatus.failure &&
              state.overviewErrorMessage != null) {
            DialogUtils.handleFailure(context, state.overviewErrorMessage!);
          }
        },
        buildWhen: (previous, current) =>
            previous.overview != current.overview ||
            previous.actionStatus != current.actionStatus,
        builder: (context, state) {
          final project = state.overview?.project;
          if (project == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return AuthFormLayout(
            title: project.name,
            children: [
              ProjectDetailsForm(
                initial: ProjectDetails(
                  name: project.name,
                  description: project.description,
                  type: project.type,
                  currencyCode: project.currencyCode,
                  plannedStart: project.plannedStart,
                  plannedEnd: project.plannedEnd,
                ),
                submitLabel: l10n.saveChanges,
                isLoading: state.actionStatus == GenericStatus.loading,
                onSubmit: (details) => bloc.add(
                  ProjectOverviewEvent.updateProject(details: details),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
