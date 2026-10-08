import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group G (decision M2-15).
void main() {
  late MockSiteApiProvider apiProvider;
  late SiteRepository repository;

  setUp(() {
    apiProvider = MockSiteApiProvider();
    repository = SiteRepository(apiProvider: apiProvider);
  });

  group('Given the site repository', () {
    test('when a GPS reading is proposed then its position, accuracy and '
        'mock flag are sent', () async {
      final proposal = testProposal();
      when(
        () => apiProvider.propose(
          1,
          lat: 5.4778,
          lng: 10.4176,
          accuracyM: 8,
          isMocked: false,
        ),
      ).thenAnswer((_) async => proposal);

      expect(await repository.proposeSite(1, testReading()), proposal);
    });

    test('when proposals are fetched, or one is validated or rejected, then '
        'the call goes through', () async {
      final site = testSite();
      when(
        () => apiProvider.listProposals(1),
      ).thenAnswer((_) async => [testProposal()]);
      when(
        () => apiProvider.validate(1, 7, radiusM: 40, addressText: 'Gate'),
      ).thenAnswer((_) async => site);
      when(
        () => apiProvider.reject(1, 7, reason: 'Wrong plot'),
      ).thenAnswer((_) async {});

      expect(await repository.fetchProposals(1), hasLength(1));
      expect(
        await repository.validateProposal(
          1,
          7,
          radiusM: 40,
          addressText: 'Gate',
        ),
        site,
      );
      await repository.rejectProposal(1, 7, reason: 'Wrong plot');
      verify(() => apiProvider.reject(1, 7, reason: 'Wrong plot')).called(1);
    });

    // doc/04b H-3.
    test(
      'when the site is updated then its radius and address are sent',
      () async {
        final site = testSite();
        when(
          () => apiProvider.update(1, radiusM: 120, addressText: 'Gate'),
        ).thenAnswer((_) async => site);

        expect(
          await repository.updateSite(1, radiusM: 120, addressText: 'Gate'),
          site,
        );
      },
    );

    test('when a call fails then the error is rethrown', () async {
      when(
        () => apiProvider.listProposals(any()),
      ).thenThrow(const NetworkException());

      await expectLater(
        repository.fetchProposals(1),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
