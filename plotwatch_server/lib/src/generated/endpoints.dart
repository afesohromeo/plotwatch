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
import 'package:plotwatch_server/src/generated/activity_type.dart' as _idpi4lil;
import 'package:plotwatch_server/src/generated/evidence_commit.dart'
    as _idi5nd8p;
import 'package:plotwatch_server/src/generated/media_variant.dart' as _i70qn4qh;
import 'package:plotwatch_server/src/generated/progress_update_draft.dart'
    as _ie8srvsh;
import 'package:plotwatch_server/src/generated/project_details.dart'
    as _i4y7utee;
import 'package:plotwatch_server/src/generated/project_role.dart' as _izsiizob;
import 'package:plotwatch_server/src/generated/project_sort.dart' as _ickpqaa4;
import 'package:plotwatch_server/src/generated/project_status.dart'
    as _ipfaavrx;
import 'package:plotwatch_server/src/generated/review_decision.dart'
    as _iykfo9bc;
import 'package:plotwatch_server/src/generated/stage_draft.dart' as _ieegu8zj;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../endpoints/activity_endpoint.dart' as _ijhtbkuk;
import '../endpoints/email_idp_endpoint.dart' as _ilutrrxn;
import '../endpoints/evidence_endpoint.dart' as _i2cvsm7u;
import '../endpoints/jwt_refresh_endpoint.dart' as _in48dm4x;
import '../endpoints/membership_endpoint.dart' as _it8meaj6;
import '../endpoints/notification_endpoint.dart' as _ihb11yhk;
import '../endpoints/profile_endpoint.dart' as _i2cx2pww;
import '../endpoints/progress_update_endpoint.dart' as _i95o6e4v;
import '../endpoints/project_endpoint.dart' as _iemg8ri2;
import '../endpoints/site_endpoint.dart' as _iisfmjap;
import '../endpoints/stage_endpoint.dart' as _id8pc9av;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'activity': _ijhtbkuk.ActivityEndpoint()
        ..initialize(
          server,
          'activity',
          null,
        ),
      'emailIdp': _ilutrrxn.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'evidence': _i2cvsm7u.EvidenceEndpoint()
        ..initialize(
          server,
          'evidence',
          null,
        ),
      'jwtRefresh': _in48dm4x.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'membership': _it8meaj6.MembershipEndpoint()
        ..initialize(
          server,
          'membership',
          null,
        ),
      'notification': _ihb11yhk.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'profile': _i2cx2pww.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'progressUpdate': _i95o6e4v.ProgressUpdateEndpoint()
        ..initialize(
          server,
          'progressUpdate',
          null,
        ),
      'project': _iemg8ri2.ProjectEndpoint()
        ..initialize(
          server,
          'project',
          null,
        ),
      'site': _iisfmjap.SiteEndpoint()
        ..initialize(
          server,
          'site',
          null,
        ),
      'stage': _id8pc9av.StageEndpoint()
        ..initialize(
          server,
          'stage',
          null,
        ),
    };
    connectors['activity'] = _is.EndpointConnector(
      name: 'activity',
      endpoint: endpoints['activity']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'beforeId': _is.ParameterDescription(
              name: 'beforeId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'types': _is.ParameterDescription(
              name: 'types',
              type: _is.getType<List<_idpi4lil.ActivityType>?>(),
              nullable: true,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['activity'] as _ijhtbkuk.ActivityEndpoint).list(
                    session,
                    params['projectId'],
                    beforeId: params['beforeId'],
                    pageSize: params['pageSize'],
                    types: params['types'],
                    stageId: params['stageId'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'afterId': _is.ParameterDescription(
              name: 'afterId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['activity'] as _ijhtbkuk.ActivityEndpoint).watch(
                session,
                params['projectId'],
                afterId: params['afterId'],
              ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'finishRegistrationWithProfile': _is.MethodConnector(
          name: 'finishRegistrationWithProfile',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'locale': _is.ParameterDescription(
              name: 'locale',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .finishRegistrationWithProfile(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                    fullName: params['fullName'],
                    locale: params['locale'],
                  ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['evidence'] = _is.EndpointConnector(
      name: 'evidence',
      endpoint: endpoints['evidence']!,
      methodConnectors: {
        'commit': _is.MethodConnector(
          name: 'commit',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'commit': _is.ParameterDescription(
              name: 'commit',
              type: _is.getType<_idi5nd8p.EvidenceCommit>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint).commit(
                    session,
                    params['projectId'],
                    params['commit'],
                  ),
        ),
        'uploadDescription': _is.MethodConnector(
          name: 'uploadDescription',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'evidenceId': _is.ParameterDescription(
              name: 'evidenceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint)
                  .uploadDescription(
                    session,
                    params['projectId'],
                    params['evidenceId'],
                  ),
        ),
        'finalize': _is.MethodConnector(
          name: 'finalize',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'evidenceId': _is.ParameterDescription(
              name: 'evidenceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint)
                  .finalize(
                    session,
                    params['projectId'],
                    params['evidenceId'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint).list(
                    session,
                    params['projectId'],
                    params['stageId'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'evidenceId': _is.ParameterDescription(
              name: 'evidenceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint).get(
                    session,
                    params['projectId'],
                    params['evidenceId'],
                  ),
        ),
        'media': _is.MethodConnector(
          name: 'media',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'evidenceId': _is.ParameterDescription(
              name: 'evidenceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'variant': _is.ParameterDescription(
              name: 'variant',
              type: _is.getType<_i70qn4qh.MediaVariant>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint).media(
                    session,
                    params['projectId'],
                    params['evidenceId'],
                    params['variant'],
                  ),
        ),
        'retract': _is.MethodConnector(
          name: 'retract',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'evidenceId': _is.ParameterDescription(
              name: 'evidenceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint).retract(
                    session,
                    params['projectId'],
                    params['evidenceId'],
                    params['reason'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _in48dm4x.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['membership'] = _is.EndpointConnector(
      name: 'membership',
      endpoint: endpoints['membership']!,
      methodConnectors: {
        'createInvitation': _is.MethodConnector(
          name: 'createInvitation',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_izsiizob.ProjectRole>(),
              nullable: false,
            ),
            'canApprove': _is.ParameterDescription(
              name: 'canApprove',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .createInvitation(
                        session,
                        params['projectId'],
                        params['role'],
                        canApprove: params['canApprove'],
                      ),
        ),
        'listInvitations': _is.MethodConnector(
          name: 'listInvitations',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .listInvitations(
                        session,
                        params['projectId'],
                      ),
        ),
        'cancelInvitation': _is.MethodConnector(
          name: 'cancelInvitation',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'invitationId': _is.ParameterDescription(
              name: 'invitationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .cancelInvitation(
                        session,
                        params['projectId'],
                        params['invitationId'],
                      ),
        ),
        'previewInvitation': _is.MethodConnector(
          name: 'previewInvitation',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .previewInvitation(
                        session,
                        params['code'],
                      ),
        ),
        'acceptInvitation': _is.MethodConnector(
          name: 'acceptInvitation',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .acceptInvitation(
                        session,
                        params['code'],
                      ),
        ),
        'listMembers': _is.MethodConnector(
          name: 'listMembers',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .listMembers(
                        session,
                        params['projectId'],
                      ),
        ),
        'listFormerMembers': _is.MethodConnector(
          name: 'listFormerMembers',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .listFormerMembers(
                        session,
                        params['projectId'],
                      ),
        ),
        'changeRole': _is.MethodConnector(
          name: 'changeRole',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'memberId': _is.ParameterDescription(
              name: 'memberId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_izsiizob.ProjectRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .changeRole(
                        session,
                        params['projectId'],
                        params['memberId'],
                        params['role'],
                      ),
        ),
        'removeMember': _is.MethodConnector(
          name: 'removeMember',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'memberId': _is.ParameterDescription(
              name: 'memberId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['membership'] as _it8meaj6.MembershipEndpoint)
                      .removeMember(
                        session,
                        params['projectId'],
                        params['memberId'],
                      ),
        ),
      },
    );
    connectors['notification'] = _is.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'beforeId': _is.ParameterDescription(
              name: 'beforeId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'unreadOnly': _is.ParameterDescription(
              name: 'unreadOnly',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .list(
                        session,
                        beforeId: params['beforeId'],
                        pageSize: params['pageSize'],
                        unreadOnly: params['unreadOnly'],
                      ),
        ),
        'unreadCount': _is.MethodConnector(
          name: 'unreadCount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .unreadCount(session),
        ),
        'markRead': _is.MethodConnector(
          name: 'markRead',
          params: {
            'notificationId': _is.ParameterDescription(
              name: 'notificationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .markRead(
                        session,
                        params['notificationId'],
                      ),
        ),
        'markAllRead': _is.MethodConnector(
          name: 'markAllRead',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .markAllRead(session),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'afterId': _is.ParameterDescription(
              name: 'afterId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                  .watch(
                    session,
                    afterId: params['afterId'],
                  ),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getMe': _is.MethodConnector(
          name: 'getMe',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getMe(session),
        ),
        'updateMe': _is.MethodConnector(
          name: 'updateMe',
          params: {
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'countryCode': _is.ParameterDescription(
              name: 'countryCode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'locale': _is.ParameterDescription(
              name: 'locale',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['profile'] as _i2cx2pww.ProfileEndpoint).updateMe(
                    session,
                    fullName: params['fullName'],
                    countryCode: params['countryCode'],
                    locale: params['locale'],
                  ),
        ),
      },
    );
    connectors['progressUpdate'] = _is.EndpointConnector(
      name: 'progressUpdate',
      endpoint: endpoints['progressUpdate']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'draft': _is.ParameterDescription(
              name: 'draft',
              type: _is.getType<_ie8srvsh.ProgressUpdateDraft>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['progressUpdate']
                          as _i95o6e4v.ProgressUpdateEndpoint)
                      .create(
                        session,
                        params['projectId'],
                        params['draft'],
                      ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'updateId': _is.ParameterDescription(
              name: 'updateId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['progressUpdate']
                          as _i95o6e4v.ProgressUpdateEndpoint)
                      .get(
                        session,
                        params['projectId'],
                        params['updateId'],
                      ),
        ),
      },
    );
    connectors['project'] = _is.EndpointConnector(
      name: 'project',
      endpoint: endpoints['project']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'details': _is.ParameterDescription(
              name: 'details',
              type: _is.getType<_i4y7utee.ProjectDetails>(),
              nullable: false,
            ),
            'stages': _is.ParameterDescription(
              name: 'stages',
              type: _is.getType<List<_ieegu8zj.StageDraft>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _iemg8ri2.ProjectEndpoint).create(
                    session,
                    params['details'],
                    stages: params['stages'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipfaavrx.ProjectStatus?>(),
              nullable: true,
            ),
            'search': _is.ParameterDescription(
              name: 'search',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'sort': _is.ParameterDescription(
              name: 'sort',
              type: _is.getType<_ickpqaa4.ProjectSort?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _iemg8ri2.ProjectEndpoint).list(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    status: params['status'],
                    search: params['search'],
                    sort: params['sort'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _iemg8ri2.ProjectEndpoint).get(
                    session,
                    params['projectId'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'details': _is.ParameterDescription(
              name: 'details',
              type: _is.getType<_i4y7utee.ProjectDetails>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _iemg8ri2.ProjectEndpoint).update(
                    session,
                    params['projectId'],
                    params['details'],
                  ),
        ),
        'setStatus': _is.MethodConnector(
          name: 'setStatus',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipfaavrx.ProjectStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _iemg8ri2.ProjectEndpoint).setStatus(
                    session,
                    params['projectId'],
                    params['status'],
                  ),
        ),
      },
    );
    connectors['site'] = _is.EndpointConnector(
      name: 'site',
      endpoint: endpoints['site']!,
      methodConnectors: {
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _iisfmjap.SiteEndpoint).get(
                session,
                params['projectId'],
              ),
        ),
        'propose': _is.MethodConnector(
          name: 'propose',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'lat': _is.ParameterDescription(
              name: 'lat',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'lng': _is.ParameterDescription(
              name: 'lng',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'accuracyM': _is.ParameterDescription(
              name: 'accuracyM',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'isMocked': _is.ParameterDescription(
              name: 'isMocked',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _iisfmjap.SiteEndpoint).propose(
                session,
                params['projectId'],
                lat: params['lat'],
                lng: params['lng'],
                accuracyM: params['accuracyM'],
                isMocked: params['isMocked'],
              ),
        ),
        'listProposals': _is.MethodConnector(
          name: 'listProposals',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['site'] as _iisfmjap.SiteEndpoint).listProposals(
                    session,
                    params['projectId'],
                  ),
        ),
        'validate': _is.MethodConnector(
          name: 'validate',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'proposalId': _is.ParameterDescription(
              name: 'proposalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'radiusM': _is.ParameterDescription(
              name: 'radiusM',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'addressText': _is.ParameterDescription(
              name: 'addressText',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _iisfmjap.SiteEndpoint).validate(
                session,
                params['projectId'],
                params['proposalId'],
                radiusM: params['radiusM'],
                addressText: params['addressText'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'radiusM': _is.ParameterDescription(
              name: 'radiusM',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'addressText': _is.ParameterDescription(
              name: 'addressText',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _iisfmjap.SiteEndpoint).update(
                session,
                params['projectId'],
                radiusM: params['radiusM'],
                addressText: params['addressText'],
              ),
        ),
        'reject': _is.MethodConnector(
          name: 'reject',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'proposalId': _is.ParameterDescription(
              name: 'proposalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _iisfmjap.SiteEndpoint).reject(
                session,
                params['projectId'],
                params['proposalId'],
                reason: params['reason'],
              ),
        ),
      },
    );
    connectors['stage'] = _is.EndpointConnector(
      name: 'stage',
      endpoint: endpoints['stage']!,
      methodConnectors: {
        'plan': _is.MethodConnector(
          name: 'plan',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stage'] as _id8pc9av.StageEndpoint).plan(
                session,
                params['projectId'],
              ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stage'] as _id8pc9av.StageEndpoint).get(
                session,
                params['projectId'],
                params['stageId'],
              ),
        ),
        'createPlan': _is.MethodConnector(
          name: 'createPlan',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stages': _is.ParameterDescription(
              name: 'stages',
              type: _is.getType<List<_ieegu8zj.StageDraft>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['stage'] as _id8pc9av.StageEndpoint).createPlan(
                    session,
                    params['projectId'],
                    params['stages'],
                  ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'draft': _is.ParameterDescription(
              name: 'draft',
              type: _is.getType<_ieegu8zj.StageDraft>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stage'] as _id8pc9av.StageEndpoint).create(
                session,
                params['projectId'],
                params['draft'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'draft': _is.ParameterDescription(
              name: 'draft',
              type: _is.getType<_ieegu8zj.StageDraft>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stage'] as _id8pc9av.StageEndpoint).update(
                session,
                params['projectId'],
                params['stageId'],
                params['draft'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stage'] as _id8pc9av.StageEndpoint).delete(
                session,
                params['projectId'],
                params['stageId'],
              ),
        ),
        'reorder': _is.MethodConnector(
          name: 'reorder',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageIds': _is.ParameterDescription(
              name: 'stageIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['stage'] as _id8pc9av.StageEndpoint).reorder(
                    session,
                    params['projectId'],
                    params['stageIds'],
                  ),
        ),
        'start': _is.MethodConnector(
          name: 'start',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stage'] as _id8pc9av.StageEndpoint).start(
                session,
                params['projectId'],
                params['stageId'],
              ),
        ),
        'submit': _is.MethodConnector(
          name: 'submit',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stage'] as _id8pc9av.StageEndpoint).submit(
                session,
                params['projectId'],
                params['stageId'],
              ),
        ),
        'review': _is.MethodConnector(
          name: 'review',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'decision': _is.ParameterDescription(
              name: 'decision',
              type: _is.getType<_iykfo9bc.ReviewDecision>(),
              nullable: false,
            ),
            'comment': _is.ParameterDescription(
              name: 'comment',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stage'] as _id8pc9av.StageEndpoint).review(
                session,
                params['projectId'],
                params['stageId'],
                params['decision'],
                comment: params['comment'],
              ),
        ),
        'reviews': _is.MethodConnector(
          name: 'reviews',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stageId': _is.ParameterDescription(
              name: 'stageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['stage'] as _id8pc9av.StageEndpoint).reviews(
                    session,
                    params['projectId'],
                    params['stageId'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
