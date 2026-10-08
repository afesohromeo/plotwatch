/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:plotwatch_client/src/protocol/evidence.dart' as _iqq0l4bs;
import 'package:plotwatch_client/src/protocol/invitation.dart' as _idw8kw5i;
import 'package:plotwatch_client/src/protocol/member_view.dart' as _ifqht5qj;
import 'package:plotwatch_client/src/protocol/site_proposal.dart' as _irbyqz3h;
import 'package:plotwatch_client/src/protocol/stage_draft.dart' as _inenhxrz;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'activity_event.dart' as _iwse5pgb;
import 'activity_type.dart' as _iorr0e24;
import 'app_error_code.dart' as _imu8gbx5;
import 'app_exception.dart' as _it4z223c;
import 'checklist_item.dart' as _ifywsnp6;
import 'checklist_item_draft.dart' as _iuwh2s2t;
import 'evidence.dart' as _iptmmm0p;
import 'evidence_commit.dart' as _it2d46ly;
import 'evidence_commit_result.dart' as _i6593me7;
import 'evidence_status.dart' as _itwc15qq;
import 'invitation.dart' as _ix00wubs;
import 'invitation_preview.dart' as _i8l83u67;
import 'invitation_status.dart' as _ifbgrtog;
import 'media_variant.dart' as _ibclxgv9;
import 'member_status.dart' as _iolegqnm;
import 'member_view.dart' as _iwpqxdug;
import 'my_profile.dart' as _i1hmtol2;
import 'project.dart' as _ifiazq2p;
import 'project_details.dart' as _irbn6ip5;
import 'project_member.dart' as _i7o7d07j;
import 'project_overview.dart' as _iy1z8w9e;
import 'project_role.dart' as _i46wx1t7;
import 'project_status.dart' as _iqsxbscs;
import 'project_summary.dart' as _ivxocntb;
import 'project_summary_page.dart' as _i4o32k29;
import 'project_type.dart' as _irluonl0;
import 'site.dart' as _iz8v5x4v;
import 'site_proposal.dart' as _ira79kry;
import 'site_proposal_status.dart' as _i8b5g94r;
import 'stage.dart' as _igkbma1f;
import 'stage_draft.dart' as _i7mtby60;
import 'stage_plan.dart' as _iwmsx3av;
import 'stage_status.dart' as _iblg1lql;
import 'stage_view.dart' as _iobwm8xj;
import 'user_settings.dart' as _iy88a0nt;
import 'verification_check.dart' as _i92h88x8;
import 'verification_check_name.dart' as _io670pev;
import 'verification_level.dart' as _i5zqa56i;
export 'activity_event.dart';
export 'activity_type.dart';
export 'app_error_code.dart';
export 'app_exception.dart';
export 'checklist_item.dart';
export 'checklist_item_draft.dart';
export 'evidence.dart';
export 'evidence_commit.dart';
export 'evidence_commit_result.dart';
export 'evidence_status.dart';
export 'invitation.dart';
export 'invitation_preview.dart';
export 'invitation_status.dart';
export 'media_variant.dart';
export 'member_status.dart';
export 'member_view.dart';
export 'my_profile.dart';
export 'project.dart';
export 'project_details.dart';
export 'project_member.dart';
export 'project_overview.dart';
export 'project_role.dart';
export 'project_status.dart';
export 'project_summary.dart';
export 'project_summary_page.dart';
export 'project_type.dart';
export 'site.dart';
export 'site_proposal.dart';
export 'site_proposal_status.dart';
export 'stage.dart';
export 'stage_draft.dart';
export 'stage_plan.dart';
export 'stage_status.dart';
export 'stage_view.dart';
export 'user_settings.dart';
export 'verification_check.dart';
export 'verification_check_name.dart';
export 'verification_level.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iwse5pgb.ActivityEvent) {
      return _iwse5pgb.ActivityEvent.fromJson(data) as T;
    }
    if (t == _iorr0e24.ActivityType) {
      return _iorr0e24.ActivityType.fromJson(data) as T;
    }
    if (t == _imu8gbx5.AppErrorCode) {
      return _imu8gbx5.AppErrorCode.fromJson(data) as T;
    }
    if (t == _it4z223c.AppException) {
      return _it4z223c.AppException.fromJson(data) as T;
    }
    if (t == _ifywsnp6.ChecklistItem) {
      return _ifywsnp6.ChecklistItem.fromJson(data) as T;
    }
    if (t == _iuwh2s2t.ChecklistItemDraft) {
      return _iuwh2s2t.ChecklistItemDraft.fromJson(data) as T;
    }
    if (t == _iptmmm0p.Evidence) {
      return _iptmmm0p.Evidence.fromJson(data) as T;
    }
    if (t == _it2d46ly.EvidenceCommit) {
      return _it2d46ly.EvidenceCommit.fromJson(data) as T;
    }
    if (t == _i6593me7.EvidenceCommitResult) {
      return _i6593me7.EvidenceCommitResult.fromJson(data) as T;
    }
    if (t == _itwc15qq.EvidenceStatus) {
      return _itwc15qq.EvidenceStatus.fromJson(data) as T;
    }
    if (t == _ix00wubs.Invitation) {
      return _ix00wubs.Invitation.fromJson(data) as T;
    }
    if (t == _i8l83u67.InvitationPreview) {
      return _i8l83u67.InvitationPreview.fromJson(data) as T;
    }
    if (t == _ifbgrtog.InvitationStatus) {
      return _ifbgrtog.InvitationStatus.fromJson(data) as T;
    }
    if (t == _ibclxgv9.MediaVariant) {
      return _ibclxgv9.MediaVariant.fromJson(data) as T;
    }
    if (t == _iolegqnm.MemberStatus) {
      return _iolegqnm.MemberStatus.fromJson(data) as T;
    }
    if (t == _iwpqxdug.MemberView) {
      return _iwpqxdug.MemberView.fromJson(data) as T;
    }
    if (t == _i1hmtol2.MyProfile) {
      return _i1hmtol2.MyProfile.fromJson(data) as T;
    }
    if (t == _ifiazq2p.Project) {
      return _ifiazq2p.Project.fromJson(data) as T;
    }
    if (t == _irbn6ip5.ProjectDetails) {
      return _irbn6ip5.ProjectDetails.fromJson(data) as T;
    }
    if (t == _i7o7d07j.ProjectMember) {
      return _i7o7d07j.ProjectMember.fromJson(data) as T;
    }
    if (t == _iy1z8w9e.ProjectOverview) {
      return _iy1z8w9e.ProjectOverview.fromJson(data) as T;
    }
    if (t == _i46wx1t7.ProjectRole) {
      return _i46wx1t7.ProjectRole.fromJson(data) as T;
    }
    if (t == _iqsxbscs.ProjectStatus) {
      return _iqsxbscs.ProjectStatus.fromJson(data) as T;
    }
    if (t == _ivxocntb.ProjectSummary) {
      return _ivxocntb.ProjectSummary.fromJson(data) as T;
    }
    if (t == _i4o32k29.ProjectSummaryPage) {
      return _i4o32k29.ProjectSummaryPage.fromJson(data) as T;
    }
    if (t == _irluonl0.ProjectType) {
      return _irluonl0.ProjectType.fromJson(data) as T;
    }
    if (t == _iz8v5x4v.Site) {
      return _iz8v5x4v.Site.fromJson(data) as T;
    }
    if (t == _ira79kry.SiteProposal) {
      return _ira79kry.SiteProposal.fromJson(data) as T;
    }
    if (t == _i8b5g94r.SiteProposalStatus) {
      return _i8b5g94r.SiteProposalStatus.fromJson(data) as T;
    }
    if (t == _igkbma1f.Stage) {
      return _igkbma1f.Stage.fromJson(data) as T;
    }
    if (t == _i7mtby60.StageDraft) {
      return _i7mtby60.StageDraft.fromJson(data) as T;
    }
    if (t == _iwmsx3av.StagePlan) {
      return _iwmsx3av.StagePlan.fromJson(data) as T;
    }
    if (t == _iblg1lql.StageStatus) {
      return _iblg1lql.StageStatus.fromJson(data) as T;
    }
    if (t == _iobwm8xj.StageView) {
      return _iobwm8xj.StageView.fromJson(data) as T;
    }
    if (t == _iy88a0nt.UserSettings) {
      return _iy88a0nt.UserSettings.fromJson(data) as T;
    }
    if (t == _i92h88x8.VerificationCheck) {
      return _i92h88x8.VerificationCheck.fromJson(data) as T;
    }
    if (t == _io670pev.VerificationCheckName) {
      return _io670pev.VerificationCheckName.fromJson(data) as T;
    }
    if (t == _i5zqa56i.VerificationLevel) {
      return _i5zqa56i.VerificationLevel.fromJson(data) as T;
    }
    if (t == _isc.getType<_iwse5pgb.ActivityEvent?>()) {
      return (data != null ? _iwse5pgb.ActivityEvent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iorr0e24.ActivityType?>()) {
      return (data != null ? _iorr0e24.ActivityType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imu8gbx5.AppErrorCode?>()) {
      return (data != null ? _imu8gbx5.AppErrorCode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_it4z223c.AppException?>()) {
      return (data != null ? _it4z223c.AppException.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifywsnp6.ChecklistItem?>()) {
      return (data != null ? _ifywsnp6.ChecklistItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iuwh2s2t.ChecklistItemDraft?>()) {
      return (data != null ? _iuwh2s2t.ChecklistItemDraft.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iptmmm0p.Evidence?>()) {
      return (data != null ? _iptmmm0p.Evidence.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_it2d46ly.EvidenceCommit?>()) {
      return (data != null ? _it2d46ly.EvidenceCommit.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6593me7.EvidenceCommitResult?>()) {
      return (data != null
              ? _i6593me7.EvidenceCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_itwc15qq.EvidenceStatus?>()) {
      return (data != null ? _itwc15qq.EvidenceStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ix00wubs.Invitation?>()) {
      return (data != null ? _ix00wubs.Invitation.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8l83u67.InvitationPreview?>()) {
      return (data != null ? _i8l83u67.InvitationPreview.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifbgrtog.InvitationStatus?>()) {
      return (data != null ? _ifbgrtog.InvitationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibclxgv9.MediaVariant?>()) {
      return (data != null ? _ibclxgv9.MediaVariant.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iolegqnm.MemberStatus?>()) {
      return (data != null ? _iolegqnm.MemberStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwpqxdug.MemberView?>()) {
      return (data != null ? _iwpqxdug.MemberView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1hmtol2.MyProfile?>()) {
      return (data != null ? _i1hmtol2.MyProfile.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifiazq2p.Project?>()) {
      return (data != null ? _ifiazq2p.Project.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irbn6ip5.ProjectDetails?>()) {
      return (data != null ? _irbn6ip5.ProjectDetails.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7o7d07j.ProjectMember?>()) {
      return (data != null ? _i7o7d07j.ProjectMember.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iy1z8w9e.ProjectOverview?>()) {
      return (data != null ? _iy1z8w9e.ProjectOverview.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i46wx1t7.ProjectRole?>()) {
      return (data != null ? _i46wx1t7.ProjectRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqsxbscs.ProjectStatus?>()) {
      return (data != null ? _iqsxbscs.ProjectStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivxocntb.ProjectSummary?>()) {
      return (data != null ? _ivxocntb.ProjectSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4o32k29.ProjectSummaryPage?>()) {
      return (data != null ? _i4o32k29.ProjectSummaryPage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irluonl0.ProjectType?>()) {
      return (data != null ? _irluonl0.ProjectType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iz8v5x4v.Site?>()) {
      return (data != null ? _iz8v5x4v.Site.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ira79kry.SiteProposal?>()) {
      return (data != null ? _ira79kry.SiteProposal.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8b5g94r.SiteProposalStatus?>()) {
      return (data != null ? _i8b5g94r.SiteProposalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_igkbma1f.Stage?>()) {
      return (data != null ? _igkbma1f.Stage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7mtby60.StageDraft?>()) {
      return (data != null ? _i7mtby60.StageDraft.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwmsx3av.StagePlan?>()) {
      return (data != null ? _iwmsx3av.StagePlan.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iblg1lql.StageStatus?>()) {
      return (data != null ? _iblg1lql.StageStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iobwm8xj.StageView?>()) {
      return (data != null ? _iobwm8xj.StageView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iy88a0nt.UserSettings?>()) {
      return (data != null ? _iy88a0nt.UserSettings.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i92h88x8.VerificationCheck?>()) {
      return (data != null ? _i92h88x8.VerificationCheck.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_io670pev.VerificationCheckName?>()) {
      return (data != null
              ? _io670pev.VerificationCheckName.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i5zqa56i.VerificationLevel?>()) {
      return (data != null ? _i5zqa56i.VerificationLevel.fromJson(data) : null)
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _isc.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i92h88x8.VerificationCheck>) {
      return (data as List)
              .map((e) => deserialize<_i92h88x8.VerificationCheck>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i92h88x8.VerificationCheck>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i92h88x8.VerificationCheck>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ivxocntb.ProjectSummary>) {
      return (data as List)
              .map((e) => deserialize<_ivxocntb.ProjectSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_iuwh2s2t.ChecklistItemDraft>) {
      return (data as List)
              .map((e) => deserialize<_iuwh2s2t.ChecklistItemDraft>(e))
              .toList()
          as T;
    }
    if (t == List<_iobwm8xj.StageView>) {
      return (data as List)
              .map((e) => deserialize<_iobwm8xj.StageView>(e))
              .toList()
          as T;
    }
    if (t == List<_ifywsnp6.ChecklistItem>) {
      return (data as List)
              .map((e) => deserialize<_ifywsnp6.ChecklistItem>(e))
              .toList()
          as T;
    }
    if (t == List<_iqq0l4bs.Evidence>) {
      return (data as List)
              .map((e) => deserialize<_iqq0l4bs.Evidence>(e))
              .toList()
          as T;
    }
    if (t == List<_idw8kw5i.Invitation>) {
      return (data as List)
              .map((e) => deserialize<_idw8kw5i.Invitation>(e))
              .toList()
          as T;
    }
    if (t == List<_ifqht5qj.MemberView>) {
      return (data as List)
              .map((e) => deserialize<_ifqht5qj.MemberView>(e))
              .toList()
          as T;
    }
    if (t == List<_inenhxrz.StageDraft>) {
      return (data as List)
              .map((e) => deserialize<_inenhxrz.StageDraft>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_inenhxrz.StageDraft>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_inenhxrz.StageDraft>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_irbyqz3h.SiteProposal>) {
      return (data as List)
              .map((e) => deserialize<_irbyqz3h.SiteProposal>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iwse5pgb.ActivityEvent => 'ActivityEvent',
      _iorr0e24.ActivityType => 'ActivityType',
      _imu8gbx5.AppErrorCode => 'AppErrorCode',
      _it4z223c.AppException => 'AppException',
      _ifywsnp6.ChecklistItem => 'ChecklistItem',
      _iuwh2s2t.ChecklistItemDraft => 'ChecklistItemDraft',
      _iptmmm0p.Evidence => 'Evidence',
      _it2d46ly.EvidenceCommit => 'EvidenceCommit',
      _i6593me7.EvidenceCommitResult => 'EvidenceCommitResult',
      _itwc15qq.EvidenceStatus => 'EvidenceStatus',
      _ix00wubs.Invitation => 'Invitation',
      _i8l83u67.InvitationPreview => 'InvitationPreview',
      _ifbgrtog.InvitationStatus => 'InvitationStatus',
      _ibclxgv9.MediaVariant => 'MediaVariant',
      _iolegqnm.MemberStatus => 'MemberStatus',
      _iwpqxdug.MemberView => 'MemberView',
      _i1hmtol2.MyProfile => 'MyProfile',
      _ifiazq2p.Project => 'Project',
      _irbn6ip5.ProjectDetails => 'ProjectDetails',
      _i7o7d07j.ProjectMember => 'ProjectMember',
      _iy1z8w9e.ProjectOverview => 'ProjectOverview',
      _i46wx1t7.ProjectRole => 'ProjectRole',
      _iqsxbscs.ProjectStatus => 'ProjectStatus',
      _ivxocntb.ProjectSummary => 'ProjectSummary',
      _i4o32k29.ProjectSummaryPage => 'ProjectSummaryPage',
      _irluonl0.ProjectType => 'ProjectType',
      _iz8v5x4v.Site => 'Site',
      _ira79kry.SiteProposal => 'SiteProposal',
      _i8b5g94r.SiteProposalStatus => 'SiteProposalStatus',
      _igkbma1f.Stage => 'Stage',
      _i7mtby60.StageDraft => 'StageDraft',
      _iwmsx3av.StagePlan => 'StagePlan',
      _iblg1lql.StageStatus => 'StageStatus',
      _iobwm8xj.StageView => 'StageView',
      _iy88a0nt.UserSettings => 'UserSettings',
      _i92h88x8.VerificationCheck => 'VerificationCheck',
      _io670pev.VerificationCheckName => 'VerificationCheckName',
      _i5zqa56i.VerificationLevel => 'VerificationLevel',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('plotwatch.', '');
    }

    switch (data) {
      case _iwse5pgb.ActivityEvent():
        return 'ActivityEvent';
      case _iorr0e24.ActivityType():
        return 'ActivityType';
      case _imu8gbx5.AppErrorCode():
        return 'AppErrorCode';
      case _it4z223c.AppException():
        return 'AppException';
      case _ifywsnp6.ChecklistItem():
        return 'ChecklistItem';
      case _iuwh2s2t.ChecklistItemDraft():
        return 'ChecklistItemDraft';
      case _iptmmm0p.Evidence():
        return 'Evidence';
      case _it2d46ly.EvidenceCommit():
        return 'EvidenceCommit';
      case _i6593me7.EvidenceCommitResult():
        return 'EvidenceCommitResult';
      case _itwc15qq.EvidenceStatus():
        return 'EvidenceStatus';
      case _ix00wubs.Invitation():
        return 'Invitation';
      case _i8l83u67.InvitationPreview():
        return 'InvitationPreview';
      case _ifbgrtog.InvitationStatus():
        return 'InvitationStatus';
      case _ibclxgv9.MediaVariant():
        return 'MediaVariant';
      case _iolegqnm.MemberStatus():
        return 'MemberStatus';
      case _iwpqxdug.MemberView():
        return 'MemberView';
      case _i1hmtol2.MyProfile():
        return 'MyProfile';
      case _ifiazq2p.Project():
        return 'Project';
      case _irbn6ip5.ProjectDetails():
        return 'ProjectDetails';
      case _i7o7d07j.ProjectMember():
        return 'ProjectMember';
      case _iy1z8w9e.ProjectOverview():
        return 'ProjectOverview';
      case _i46wx1t7.ProjectRole():
        return 'ProjectRole';
      case _iqsxbscs.ProjectStatus():
        return 'ProjectStatus';
      case _ivxocntb.ProjectSummary():
        return 'ProjectSummary';
      case _i4o32k29.ProjectSummaryPage():
        return 'ProjectSummaryPage';
      case _irluonl0.ProjectType():
        return 'ProjectType';
      case _iz8v5x4v.Site():
        return 'Site';
      case _ira79kry.SiteProposal():
        return 'SiteProposal';
      case _i8b5g94r.SiteProposalStatus():
        return 'SiteProposalStatus';
      case _igkbma1f.Stage():
        return 'Stage';
      case _i7mtby60.StageDraft():
        return 'StageDraft';
      case _iwmsx3av.StagePlan():
        return 'StagePlan';
      case _iblg1lql.StageStatus():
        return 'StageStatus';
      case _iobwm8xj.StageView():
        return 'StageView';
      case _iy88a0nt.UserSettings():
        return 'UserSettings';
      case _i92h88x8.VerificationCheck():
        return 'VerificationCheck';
      case _io670pev.VerificationCheckName():
        return 'VerificationCheckName';
      case _i5zqa56i.VerificationLevel():
        return 'VerificationLevel';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ActivityEvent') {
      return deserialize<_iwse5pgb.ActivityEvent>(data['data']);
    }
    if (dataClassName == 'ActivityType') {
      return deserialize<_iorr0e24.ActivityType>(data['data']);
    }
    if (dataClassName == 'AppErrorCode') {
      return deserialize<_imu8gbx5.AppErrorCode>(data['data']);
    }
    if (dataClassName == 'AppException') {
      return deserialize<_it4z223c.AppException>(data['data']);
    }
    if (dataClassName == 'ChecklistItem') {
      return deserialize<_ifywsnp6.ChecklistItem>(data['data']);
    }
    if (dataClassName == 'ChecklistItemDraft') {
      return deserialize<_iuwh2s2t.ChecklistItemDraft>(data['data']);
    }
    if (dataClassName == 'Evidence') {
      return deserialize<_iptmmm0p.Evidence>(data['data']);
    }
    if (dataClassName == 'EvidenceCommit') {
      return deserialize<_it2d46ly.EvidenceCommit>(data['data']);
    }
    if (dataClassName == 'EvidenceCommitResult') {
      return deserialize<_i6593me7.EvidenceCommitResult>(data['data']);
    }
    if (dataClassName == 'EvidenceStatus') {
      return deserialize<_itwc15qq.EvidenceStatus>(data['data']);
    }
    if (dataClassName == 'Invitation') {
      return deserialize<_ix00wubs.Invitation>(data['data']);
    }
    if (dataClassName == 'InvitationPreview') {
      return deserialize<_i8l83u67.InvitationPreview>(data['data']);
    }
    if (dataClassName == 'InvitationStatus') {
      return deserialize<_ifbgrtog.InvitationStatus>(data['data']);
    }
    if (dataClassName == 'MediaVariant') {
      return deserialize<_ibclxgv9.MediaVariant>(data['data']);
    }
    if (dataClassName == 'MemberStatus') {
      return deserialize<_iolegqnm.MemberStatus>(data['data']);
    }
    if (dataClassName == 'MemberView') {
      return deserialize<_iwpqxdug.MemberView>(data['data']);
    }
    if (dataClassName == 'MyProfile') {
      return deserialize<_i1hmtol2.MyProfile>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_ifiazq2p.Project>(data['data']);
    }
    if (dataClassName == 'ProjectDetails') {
      return deserialize<_irbn6ip5.ProjectDetails>(data['data']);
    }
    if (dataClassName == 'ProjectMember') {
      return deserialize<_i7o7d07j.ProjectMember>(data['data']);
    }
    if (dataClassName == 'ProjectOverview') {
      return deserialize<_iy1z8w9e.ProjectOverview>(data['data']);
    }
    if (dataClassName == 'ProjectRole') {
      return deserialize<_i46wx1t7.ProjectRole>(data['data']);
    }
    if (dataClassName == 'ProjectStatus') {
      return deserialize<_iqsxbscs.ProjectStatus>(data['data']);
    }
    if (dataClassName == 'ProjectSummary') {
      return deserialize<_ivxocntb.ProjectSummary>(data['data']);
    }
    if (dataClassName == 'ProjectSummaryPage') {
      return deserialize<_i4o32k29.ProjectSummaryPage>(data['data']);
    }
    if (dataClassName == 'ProjectType') {
      return deserialize<_irluonl0.ProjectType>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_iz8v5x4v.Site>(data['data']);
    }
    if (dataClassName == 'SiteProposal') {
      return deserialize<_ira79kry.SiteProposal>(data['data']);
    }
    if (dataClassName == 'SiteProposalStatus') {
      return deserialize<_i8b5g94r.SiteProposalStatus>(data['data']);
    }
    if (dataClassName == 'Stage') {
      return deserialize<_igkbma1f.Stage>(data['data']);
    }
    if (dataClassName == 'StageDraft') {
      return deserialize<_i7mtby60.StageDraft>(data['data']);
    }
    if (dataClassName == 'StagePlan') {
      return deserialize<_iwmsx3av.StagePlan>(data['data']);
    }
    if (dataClassName == 'StageStatus') {
      return deserialize<_iblg1lql.StageStatus>(data['data']);
    }
    if (dataClassName == 'StageView') {
      return deserialize<_iobwm8xj.StageView>(data['data']);
    }
    if (dataClassName == 'UserSettings') {
      return deserialize<_iy88a0nt.UserSettings>(data['data']);
    }
    if (dataClassName == 'VerificationCheck') {
      return deserialize<_i92h88x8.VerificationCheck>(data['data']);
    }
    if (dataClassName == 'VerificationCheckName') {
      return deserialize<_io670pev.VerificationCheckName>(data['data']);
    }
    if (dataClassName == 'VerificationLevel') {
      return deserialize<_i5zqa56i.VerificationLevel>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('plotwatch', this);
    _iacc.Protocol().registerHostProtocol('plotwatch', this);
  }

  @override
  String getModuleName() => 'plotwatch';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
