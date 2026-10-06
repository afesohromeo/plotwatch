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
import 'package:plotwatch_server/src/generated/project_details.dart'
    as _i4y7utee;
import 'package:plotwatch_server/src/generated/project_role.dart' as _izsiizob;
import 'package:plotwatch_server/src/generated/project_status.dart'
    as _ipfaavrx;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../endpoints/email_idp_endpoint.dart' as _ilutrrxn;
import '../endpoints/jwt_refresh_endpoint.dart' as _in48dm4x;
import '../endpoints/membership_endpoint.dart' as _it8meaj6;
import '../endpoints/profile_endpoint.dart' as _i2cx2pww;
import '../endpoints/project_endpoint.dart' as _iemg8ri2;
import '../endpoints/site_endpoint.dart' as _iisfmjap;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _ilutrrxn.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
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
      'profile': _i2cx2pww.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
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
    };
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
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _iemg8ri2.ProjectEndpoint).create(
                    session,
                    params['details'],
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
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
