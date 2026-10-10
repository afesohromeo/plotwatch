/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:http/http.dart' as _i85jenna;
import 'package:plotwatch_client/src/protocol/activity_entry.dart' as _i1w9howa;
import 'package:plotwatch_client/src/protocol/activity_page.dart' as _i6kb728u;
import 'package:plotwatch_client/src/protocol/activity_type.dart' as _ip4wlfh9;
import 'package:plotwatch_client/src/protocol/evidence.dart' as _iqq0l4bs;
import 'package:plotwatch_client/src/protocol/evidence_commit.dart'
    as _imtsa3z6;
import 'package:plotwatch_client/src/protocol/evidence_commit_result.dart'
    as _ildz1yta;
import 'package:plotwatch_client/src/protocol/invitation.dart' as _idw8kw5i;
import 'package:plotwatch_client/src/protocol/invitation_preview.dart'
    as _idbqcfcc;
import 'package:plotwatch_client/src/protocol/media_variant.dart' as _ihqw92ih;
import 'package:plotwatch_client/src/protocol/member_view.dart' as _ifqht5qj;
import 'package:plotwatch_client/src/protocol/my_profile.dart' as _iclzzlcy;
import 'package:plotwatch_client/src/protocol/notification.dart' as _i1khdovv;
import 'package:plotwatch_client/src/protocol/notification_page.dart'
    as _irwyz7rs;
import 'package:plotwatch_client/src/protocol/progress_update.dart'
    as _i06dncd6;
import 'package:plotwatch_client/src/protocol/progress_update_draft.dart'
    as _im7e9fup;
import 'package:plotwatch_client/src/protocol/project_details.dart'
    as _iailnz8l;
import 'package:plotwatch_client/src/protocol/project_member.dart' as _ibpqw7ry;
import 'package:plotwatch_client/src/protocol/project_overview.dart'
    as _ixsm3hkh;
import 'package:plotwatch_client/src/protocol/project_role.dart' as _iei5qef1;
import 'package:plotwatch_client/src/protocol/project_sort.dart' as _i50ipmum;
import 'package:plotwatch_client/src/protocol/project_status.dart' as _id1x6c7u;
import 'package:plotwatch_client/src/protocol/project_summary_page.dart'
    as _i5ea8tcf;
import 'package:plotwatch_client/src/protocol/review_decision.dart'
    as _ilrnd6d6;
import 'package:plotwatch_client/src/protocol/site.dart' as _iw3fvswq;
import 'package:plotwatch_client/src/protocol/site_proposal.dart' as _irbyqz3h;
import 'package:plotwatch_client/src/protocol/stage_draft.dart' as _inenhxrz;
import 'package:plotwatch_client/src/protocol/stage_plan.dart' as _i60snhcg;
import 'package:plotwatch_client/src/protocol/stage_review_view.dart'
    as _i41e1va7;
import 'package:plotwatch_client/src/protocol/stage_view.dart' as _ilm4jwcv;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// A project's activity feed: pages and a live stream with catch-up
/// (FEED-01–03, 05; doc/04e M5-5, M5-7). Thin: sign-in → permission → one
/// service call (`_standards/14` §4.2).
/// {@category Endpoint}
class EndpointActivity extends _isc.EndpointRef {
  EndpointActivity(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'activity';

  /// Newest first, older than [beforeId] (`_standards/14` §3.3), only
  /// the [types] given and only [stageId]'s events when given (doc/05
  /// §9.4). Nullable instead of default values: see `ProjectEndpoint.list`.
  _ida.Future<_i6kb728u.ActivityPage> list(
    int projectId, {
    int? beforeId,
    int? pageSize,
    List<_ip4wlfh9.ActivityType>? types,
    int? stageId,
  }) => caller.callServerEndpoint<_i6kb728u.ActivityPage>(
    'activity',
    'list',
    {
      'projectId': projectId,
      'beforeId': beforeId,
      'pageSize': pageSize,
      'types': types,
      'stageId': stageId,
    },
  );

  /// The events after [afterId], then the new ones as they happen. Without
  /// [afterId], only the new ones.
  _ida.Stream<_i1w9howa.ActivityEntry> watch(
    int projectId, {
    int? afterId,
  }) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i1w9howa.ActivityEntry>,
        _i1w9howa.ActivityEntry
      >(
        'activity',
        'watch',
        {
          'projectId': projectId,
          'afterId': afterId,
        },
        {},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Last step of Plotwatch's sign-up (decision M1-4): creates the account
  /// and saves the user's name and language **in the same request**, so no
  /// other request can see the new user half-created (Cloud bug of
  /// 2026-10-06). Invalid profile values are refused before the account is
  /// created.
  _ida.Future<_iacc.AuthSuccess> finishRegistrationWithProfile({
    required String registrationToken,
    required String password,
    required String fullName,
    required String locale,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistrationWithProfile',
    {
      'registrationToken': registrationToken,
      'password': password,
      'fullName': fullName,
      'locale': locale,
    },
  );

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// Captures (CAP, VER; doc/02 §9.1, doc/04d). Thin: sign-in → permission →
/// validate → one service call (`_standards/14` §4.2).
/// {@category Endpoint}
class EndpointEvidence extends _isc.EndpointRef {
  EndpointEvidence(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'evidence';

  /// The site manager sends a photo's hash and metadata; the server records
  /// its own time and answers with the upload description (M4-3).
  _ida.Future<_ildz1yta.EvidenceCommitResult> commit(
    int projectId,
    _imtsa3z6.EvidenceCommit commit,
  ) => caller.callServerEndpoint<_ildz1yta.EvidenceCommitResult>(
    'evidence',
    'commit',
    {
      'projectId': projectId,
      'commit': commit,
    },
  );

  /// A new upload description for a capture still committed (retry).
  _ida.Future<String> uploadDescription(
    int projectId,
    int evidenceId,
  ) => caller.callServerEndpoint<String>(
    'evidence',
    'uploadDescription',
    {
      'projectId': projectId,
      'evidenceId': evidenceId,
    },
  );

  /// Checks the uploaded photo and gives the capture its badge (M4-6).
  _ida.Future<_iqq0l4bs.Evidence> finalize(
    int projectId,
    int evidenceId,
  ) => caller.callServerEndpoint<_iqq0l4bs.Evidence>(
    'evidence',
    'finalize',
    {
      'projectId': projectId,
      'evidenceId': evidenceId,
    },
  );

  /// A stage's captures, newest first.
  _ida.Future<List<_iqq0l4bs.Evidence>> list(
    int projectId,
    int stageId,
  ) => caller.callServerEndpoint<List<_iqq0l4bs.Evidence>>(
    'evidence',
    'list',
    {
      'projectId': projectId,
      'stageId': stageId,
    },
  );

  _ida.Future<_iqq0l4bs.Evidence> get(
    int projectId,
    int evidenceId,
  ) => caller.callServerEndpoint<_iqq0l4bs.Evidence>(
    'evidence',
    'get',
    {
      'projectId': projectId,
      'evidenceId': evidenceId,
    },
  );

  /// The photo or its thumbnail, through the server (decision M4-4).
  _ida.Future<_idt.ByteData> media(
    int projectId,
    int evidenceId,
    _ihqw92ih.MediaVariant variant,
  ) => caller.callServerEndpoint<_idt.ByteData>(
    'evidence',
    'media',
    {
      'projectId': projectId,
      'evidenceId': evidenceId,
      'variant': variant,
    },
  );

  /// The author withdraws a capture with a reason (CAP-09).
  _ida.Future<_iqq0l4bs.Evidence> retract(
    int projectId,
    int evidenceId,
    String reason,
  ) => caller.callServerEndpoint<_iqq0l4bs.Evidence>(
    'evidence',
    'retract',
    {
      'projectId': projectId,
      'evidenceId': evidenceId,
      'reason': reason,
    },
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Invitations and members (MEMB-01–05, 08). Thin: sign-in → permission →
/// validate → one service call (`_standards/14` §4.2).
/// {@category Endpoint}
class EndpointMembership extends _isc.EndpointRef {
  EndpointMembership(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'membership';

  _ida.Future<_idw8kw5i.Invitation> createInvitation(
    int projectId,
    _iei5qef1.ProjectRole role, {
    bool? canApprove,
  }) => caller.callServerEndpoint<_idw8kw5i.Invitation>(
    'membership',
    'createInvitation',
    {
      'projectId': projectId,
      'role': role,
      'canApprove': canApprove,
    },
  );

  _ida.Future<List<_idw8kw5i.Invitation>> listInvitations(int projectId) =>
      caller.callServerEndpoint<List<_idw8kw5i.Invitation>>(
        'membership',
        'listInvitations',
        {'projectId': projectId},
      );

  _ida.Future<void> cancelInvitation(
    int projectId,
    int invitationId,
  ) => caller.callServerEndpoint<void>(
    'membership',
    'cancelInvitation',
    {
      'projectId': projectId,
      'invitationId': invitationId,
    },
  );

  /// Signed-in only: the code is the authorization (MEMB-03).
  _ida.Future<_idbqcfcc.InvitationPreview> previewInvitation(String code) =>
      caller.callServerEndpoint<_idbqcfcc.InvitationPreview>(
        'membership',
        'previewInvitation',
        {'code': code},
      );

  /// Signed-in only: the code is the authorization (MEMB-03).
  _ida.Future<_ibpqw7ry.ProjectMember> acceptInvitation(String code) =>
      caller.callServerEndpoint<_ibpqw7ry.ProjectMember>(
        'membership',
        'acceptInvitation',
        {'code': code},
      );

  _ida.Future<List<_ifqht5qj.MemberView>> listMembers(int projectId) =>
      caller.callServerEndpoint<List<_ifqht5qj.MemberView>>(
        'membership',
        'listMembers',
        {'projectId': projectId},
      );

  /// Removed members, most recent first, with who removed them: their
  /// actions stay in the project's history (doc/04e C-2b).
  _ida.Future<List<_ifqht5qj.MemberView>> listFormerMembers(int projectId) =>
      caller.callServerEndpoint<List<_ifqht5qj.MemberView>>(
        'membership',
        'listFormerMembers',
        {'projectId': projectId},
      );

  /// The owner gives a member another role (doc/04b H-4, MEMB-07).
  _ida.Future<_ibpqw7ry.ProjectMember> changeRole(
    int projectId,
    int memberId,
    _iei5qef1.ProjectRole role,
  ) => caller.callServerEndpoint<_ibpqw7ry.ProjectMember>(
    'membership',
    'changeRole',
    {
      'projectId': projectId,
      'memberId': memberId,
      'role': role,
    },
  );

  _ida.Future<void> removeMember(
    int projectId,
    int memberId,
  ) => caller.callServerEndpoint<void>(
    'membership',
    'removeMember',
    {
      'projectId': projectId,
      'memberId': memberId,
    },
  );
}

/// The signed-in user's in-app notifications (NOT-01, doc/04e M5-4). Each
/// call only ever touches the caller's own notifications.
/// {@category Endpoint}
class EndpointNotification extends _isc.EndpointRef {
  EndpointNotification(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  /// Newest first, older than [beforeId], with the unread count; only the
  /// unread ones with [unreadOnly] (doc/05 §9.4). Nullable instead of
  /// default values: see `ProjectEndpoint.list`.
  _ida.Future<_irwyz7rs.NotificationPage> list({
    int? beforeId,
    int? pageSize,
    bool? unreadOnly,
  }) => caller.callServerEndpoint<_irwyz7rs.NotificationPage>(
    'notification',
    'list',
    {
      'beforeId': beforeId,
      'pageSize': pageSize,
      'unreadOnly': unreadOnly,
    },
  );

  _ida.Future<int> unreadCount() => caller.callServerEndpoint<int>(
    'notification',
    'unreadCount',
    {},
  );

  _ida.Future<void> markRead(int notificationId) =>
      caller.callServerEndpoint<void>(
        'notification',
        'markRead',
        {'notificationId': notificationId},
      );

  _ida.Future<void> markAllRead() => caller.callServerEndpoint<void>(
    'notification',
    'markAllRead',
    {},
  );

  /// The notifications after [afterId], then the new ones as they come.
  /// Without [afterId], only the new ones.
  _ida.Stream<_i1khdovv.AppNotification> watch({int? afterId}) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i1khdovv.AppNotification>,
        _i1khdovv.AppNotification
      >(
        'notification',
        'watch',
        {'afterId': afterId},
        {},
      );
}

/// The signed-in user's own profile (PROF-01–03).
/// Thin: sign-in → validate → one service call (`_standards/14` §4.2).
/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  _ida.Future<_iclzzlcy.MyProfile> getMe() =>
      caller.callServerEndpoint<_iclzzlcy.MyProfile>(
        'profile',
        'getMe',
        {},
      );

  _ida.Future<_iclzzlcy.MyProfile> updateMe({
    required String fullName,
    String? countryCode,
    required String locale,
  }) => caller.callServerEndpoint<_iclzzlcy.MyProfile>(
    'profile',
    'updateMe',
    {
      'fullName': fullName,
      'countryCode': countryCode,
      'locale': locale,
    },
  );
}

/// The site manager's progress updates (UPD-01, UPD-02; doc/04e M5-9 b).
/// Thin: sign-in → permission → validate → one service call
/// (`_standards/14` §4.2).
/// {@category Endpoint}
class EndpointProgressUpdate extends _isc.EndpointRef {
  EndpointProgressUpdate(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'progressUpdate';

  _ida.Future<_i06dncd6.ProgressUpdate> create(
    int projectId,
    _im7e9fup.ProgressUpdateDraft draft,
  ) => caller.callServerEndpoint<_i06dncd6.ProgressUpdate>(
    'progressUpdate',
    'create',
    {
      'projectId': projectId,
      'draft': draft,
    },
  );

  _ida.Future<_i06dncd6.ProgressUpdate> get(
    int projectId,
    int updateId,
  ) => caller.callServerEndpoint<_i06dncd6.ProgressUpdate>(
    'progressUpdate',
    'get',
    {
      'projectId': projectId,
      'updateId': updateId,
    },
  );
}

/// Projects (PROJ-01–05). Thin: sign-in → permission → validate → one
/// service call (`_standards/14` §4.2).
/// {@category Endpoint}
class EndpointProject extends _isc.EndpointRef {
  EndpointProject(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'project';

  /// Any signed-in user can create a project and becomes its owner. The
  /// wizard sends the chosen template's [stages] with it, so the project and
  /// its plan are created together (decision M3-3). Nullable instead of a
  /// default value: see [list].
  _ida.Future<_ixsm3hkh.ProjectOverview> create(
    _iailnz8l.ProjectDetails details, {
    List<_inenhxrz.StageDraft>? stages,
  }) => caller.callServerEndpoint<_ixsm3hkh.ProjectOverview>(
    'project',
    'create',
    {
      'details': details,
      'stages': stages,
    },
  );

  /// The caller's projects, a page at a time (`_standards/14` §3.1): only
  /// [status] when given, only names containing [search], ordered by
  /// [sort] (the latest activity first by default; doc/05 §9.4).
  /// Nullable instead of default values: the generated client makes a named
  /// parameter with a default required (Serverpod 4.0.3).
  _ida.Future<_i5ea8tcf.ProjectSummaryPage> list({
    int? page,
    int? pageSize,
    _id1x6c7u.ProjectStatus? status,
    String? search,
    _i50ipmum.ProjectSort? sort,
  }) => caller.callServerEndpoint<_i5ea8tcf.ProjectSummaryPage>(
    'project',
    'list',
    {
      'page': page,
      'pageSize': pageSize,
      'status': status,
      'search': search,
      'sort': sort,
    },
  );

  _ida.Future<_ixsm3hkh.ProjectOverview> get(int projectId) =>
      caller.callServerEndpoint<_ixsm3hkh.ProjectOverview>(
        'project',
        'get',
        {'projectId': projectId},
      );

  _ida.Future<_ixsm3hkh.ProjectOverview> update(
    int projectId,
    _iailnz8l.ProjectDetails details,
  ) => caller.callServerEndpoint<_ixsm3hkh.ProjectOverview>(
    'project',
    'update',
    {
      'projectId': projectId,
      'details': details,
    },
  );

  _ida.Future<_ixsm3hkh.ProjectOverview> setStatus(
    int projectId,
    _id1x6c7u.ProjectStatus status,
  ) => caller.callServerEndpoint<_ixsm3hkh.ProjectOverview>(
    'project',
    'setStatus',
    {
      'projectId': projectId,
      'status': status,
    },
  );
}

/// The site's location (SITE-03, 04, 07; decision M2-15). Thin: sign-in →
/// permission → validate → one service call (`_standards/14` §4.2).
/// {@category Endpoint}
class EndpointSite extends _isc.EndpointRef {
  EndpointSite(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'site';

  /// The validated site, or null while the project waits for one.
  _ida.Future<_iw3fvswq.Site?> get(int projectId) =>
      caller.callServerEndpoint<_iw3fvswq.Site?>(
        'site',
        'get',
        {'projectId': projectId},
      );

  /// The site manager's GPS reading on the plot (phone app only).
  _ida.Future<_irbyqz3h.SiteProposal> propose(
    int projectId, {
    required double lat,
    required double lng,
    required double accuracyM,
    required bool isMocked,
  }) => caller.callServerEndpoint<_irbyqz3h.SiteProposal>(
    'site',
    'propose',
    {
      'projectId': projectId,
      'lat': lat,
      'lng': lng,
      'accuracyM': accuracyM,
      'isMocked': isMocked,
    },
  );

  _ida.Future<List<_irbyqz3h.SiteProposal>> listProposals(int projectId) =>
      caller.callServerEndpoint<List<_irbyqz3h.SiteProposal>>(
        'site',
        'listProposals',
        {'projectId': projectId},
      );

  _ida.Future<_iw3fvswq.Site> validate(
    int projectId,
    int proposalId, {
    required int radiusM,
    String? addressText,
  }) => caller.callServerEndpoint<_iw3fvswq.Site>(
    'site',
    'validate',
    {
      'projectId': projectId,
      'proposalId': proposalId,
      'radiusM': radiusM,
      'addressText': addressText,
    },
  );

  /// The owner changes the radius and the address of the validated site
  /// without a new GPS reading (doc/04b H-3); a blank address removes it.
  _ida.Future<_iw3fvswq.Site> update(
    int projectId, {
    required int radiusM,
    String? addressText,
  }) => caller.callServerEndpoint<_iw3fvswq.Site>(
    'site',
    'update',
    {
      'projectId': projectId,
      'radiusM': radiusM,
      'addressText': addressText,
    },
  );

  _ida.Future<void> reject(
    int projectId,
    int proposalId, {
    String? reason,
  }) => caller.callServerEndpoint<void>(
    'site',
    'reject',
    {
      'projectId': projectId,
      'proposalId': proposalId,
      'reason': reason,
    },
  );
}

/// The stage plan (STG-01–09, BUD-01–02; doc/04c). Thin: sign-in →
/// permission → validate → one service call (`_standards/14` §4.2).
/// {@category Endpoint}
class EndpointStage extends _isc.EndpointRef {
  EndpointStage(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'stage';

  /// The stages in order, the total budget and the progress.
  _ida.Future<_i60snhcg.StagePlan> plan(int projectId) =>
      caller.callServerEndpoint<_i60snhcg.StagePlan>(
        'stage',
        'plan',
        {'projectId': projectId},
      );

  _ida.Future<_ilm4jwcv.StageView> get(
    int projectId,
    int stageId,
  ) => caller.callServerEndpoint<_ilm4jwcv.StageView>(
    'stage',
    'get',
    {
      'projectId': projectId,
      'stageId': stageId,
    },
  );

  /// Fills an empty plan, e.g. from a template (decision M3-3).
  _ida.Future<_i60snhcg.StagePlan> createPlan(
    int projectId,
    List<_inenhxrz.StageDraft> stages,
  ) => caller.callServerEndpoint<_i60snhcg.StagePlan>(
    'stage',
    'createPlan',
    {
      'projectId': projectId,
      'stages': stages,
    },
  );

  _ida.Future<_ilm4jwcv.StageView> create(
    int projectId,
    _inenhxrz.StageDraft draft,
  ) => caller.callServerEndpoint<_ilm4jwcv.StageView>(
    'stage',
    'create',
    {
      'projectId': projectId,
      'draft': draft,
    },
  );

  _ida.Future<_ilm4jwcv.StageView> update(
    int projectId,
    int stageId,
    _inenhxrz.StageDraft draft,
  ) => caller.callServerEndpoint<_ilm4jwcv.StageView>(
    'stage',
    'update',
    {
      'projectId': projectId,
      'stageId': stageId,
      'draft': draft,
    },
  );

  _ida.Future<void> delete(
    int projectId,
    int stageId,
  ) => caller.callServerEndpoint<void>(
    'stage',
    'delete',
    {
      'projectId': projectId,
      'stageId': stageId,
    },
  );

  /// [stageIds] lists every stage of the project once, in the new order.
  _ida.Future<_i60snhcg.StagePlan> reorder(
    int projectId,
    List<int> stageIds,
  ) => caller.callServerEndpoint<_i60snhcg.StagePlan>(
    'stage',
    'reorder',
    {
      'projectId': projectId,
      'stageIds': stageIds,
    },
  );

  /// The site manager starts work on a stage (STG-06).
  _ida.Future<_ilm4jwcv.StageView> start(
    int projectId,
    int stageId,
  ) => caller.callServerEndpoint<_ilm4jwcv.StageView>(
    'stage',
    'start',
    {
      'projectId': projectId,
      'stageId': stageId,
    },
  );

  /// The site manager sends a complete stage for review (STG-07).
  _ida.Future<_ilm4jwcv.StageView> submit(
    int projectId,
    int stageId,
  ) => caller.callServerEndpoint<_ilm4jwcv.StageView>(
    'stage',
    'submit',
    {
      'projectId': projectId,
      'stageId': stageId,
    },
  );

  /// An approver approves the stage or requests changes with a comment
  /// (REV-03, doc/04e M5-3). Nullable instead of a default value: see
  /// `ProjectEndpoint.list`.
  _ida.Future<_ilm4jwcv.StageView> review(
    int projectId,
    int stageId,
    _ilrnd6d6.ReviewDecision decision, {
    String? comment,
  }) => caller.callServerEndpoint<_ilm4jwcv.StageView>(
    'stage',
    'review',
    {
      'projectId': projectId,
      'stageId': stageId,
      'decision': decision,
      'comment': comment,
    },
  );

  /// The stage's review history, oldest first (REV-05).
  _ida.Future<List<_i41e1va7.StageReviewView>> reviews(
    int projectId,
    int stageId,
  ) => caller.callServerEndpoint<List<_i41e1va7.StageReviewView>>(
    'stage',
    'reviews',
    {
      'projectId': projectId,
      'stageId': stageId,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    activity = EndpointActivity(this);
    emailIdp = EndpointEmailIdp(this);
    evidence = EndpointEvidence(this);
    jwtRefresh = EndpointJwtRefresh(this);
    membership = EndpointMembership(this);
    notification = EndpointNotification(this);
    profile = EndpointProfile(this);
    progressUpdate = EndpointProgressUpdate(this);
    project = EndpointProject(this);
    site = EndpointSite(this);
    stage = EndpointStage(this);
    modules = Modules(this);
  }

  late final EndpointActivity activity;

  late final EndpointEmailIdp emailIdp;

  late final EndpointEvidence evidence;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointMembership membership;

  late final EndpointNotification notification;

  late final EndpointProfile profile;

  late final EndpointProgressUpdate progressUpdate;

  late final EndpointProject project;

  late final EndpointSite site;

  late final EndpointStage stage;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'activity': activity,
    'emailIdp': emailIdp,
    'evidence': evidence,
    'jwtRefresh': jwtRefresh,
    'membership': membership,
    'notification': notification,
    'profile': profile,
    'progressUpdate': progressUpdate,
    'project': project,
    'site': site,
    'stage': stage,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
