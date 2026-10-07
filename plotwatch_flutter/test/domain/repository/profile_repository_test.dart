import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockProfileApiProvider apiProvider;
  late ProfileRepository repository;
  final profile = MyProfile(
    fullName: 'Ada Lovelace',
    email: 'ada@example.com',
    countryCode: 'CM',
    locale: 'fr',
  );

  setUp(() {
    apiProvider = MockProfileApiProvider();
    repository = ProfileRepository(apiProvider: apiProvider);
  });

  group('Given the profile repository', () {
    test('when fetching then it returns the profile', () async {
      when(() => apiProvider.getMe()).thenAnswer((_) async => profile);

      expect(await repository.fetchMe(), profile);
    });

    test(
      'when updating then it passes the values and returns the result',
      () async {
        when(
          () => apiProvider.updateMe(
            fullName: 'Ada Lovelace',
            countryCode: 'CM',
            locale: 'fr',
          ),
        ).thenAnswer((_) async => profile);

        final result = await repository.updateMe(
          fullName: 'Ada Lovelace',
          countryCode: 'CM',
          locale: 'fr',
        );

        expect(result, profile);
      },
    );

    test('when the API fails then the error is rethrown', () async {
      when(() => apiProvider.getMe()).thenThrow(const NetworkException());

      await expectLater(repository.fetchMe(), throwsA(isA<NetworkException>()));
    });
  });
}
