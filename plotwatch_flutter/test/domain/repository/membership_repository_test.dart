import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group F.
void main() {
  late MockMembershipApiProvider apiProvider;
  late MembershipRepository repository;

  setUp(() {
    apiProvider = MockMembershipApiProvider();
    repository = MembershipRepository(apiProvider: apiProvider);
  });

  group('Given the membership repository', () {
    test('when members, invitations or a preview are fetched then the server '
        'answers are returned', () async {
      final members = [testMember()];
      final invitations = [testInvitation()];
      when(() => apiProvider.listMembers(1)).thenAnswer((_) async => members);
      when(
        () => apiProvider.listInvitations(1),
      ).thenAnswer((_) async => invitations);
      when(
        () => apiProvider.previewInvitation('ABCD2345'),
      ).thenAnswer((_) async => testPreview);

      expect(await repository.fetchMembers(1), members);
      expect(await repository.fetchInvitations(1), invitations);
      expect(await repository.previewInvitation('ABCD2345'), testPreview);
    });

    test('when an invitation is created then the role and approval right are '
        'sent', () async {
      final invitation = testInvitation(role: ProjectRole.coFunder);
      when(
        () => apiProvider.createInvitation(
          1,
          ProjectRole.coFunder,
          canApprove: true,
        ),
      ).thenAnswer((_) async => invitation);

      final result = await repository.createInvitation(
        1,
        ProjectRole.coFunder,
        canApprove: true,
      );

      expect(result, invitation);
    });

    test('when someone joins, is removed or an invitation is cancelled then '
        'the call goes through', () async {
      final member = testMember(role: ProjectRole.siteManager).member;
      when(
        () => apiProvider.acceptInvitation('ABCD2345'),
      ).thenAnswer((_) async => member);
      when(() => apiProvider.removeMember(1, 2)).thenAnswer((_) async {});
      when(() => apiProvider.cancelInvitation(1, 3)).thenAnswer((_) async {});

      expect(await repository.acceptInvitation('ABCD2345'), member);
      await repository.removeMember(1, 2);
      await repository.cancelInvitation(1, 3);

      verify(() => apiProvider.removeMember(1, 2)).called(1);
      verify(() => apiProvider.cancelInvitation(1, 3)).called(1);
    });

    // doc/04b H-4.
    test('when a role is changed then the updated member comes back', () async {
      final changed = testMember(id: 2, role: ProjectRole.viewer).member;
      when(
        () => apiProvider.changeRole(1, 2, ProjectRole.viewer),
      ).thenAnswer((_) async => changed);

      expect(await repository.changeRole(1, 2, ProjectRole.viewer), changed);
    });

    test('when a call fails then the error is rethrown', () async {
      when(
        () => apiProvider.acceptInvitation(any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.invitationExpired));

      await expectLater(
        repository.acceptInvitation('ABCD2345'),
        throwsA(isA<HttpException400>()),
      );
    });
  });
}
