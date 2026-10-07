import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockAuthApiProvider apiProvider;
  late AuthRepository repository;
  final authSuccess = FakeAuthSuccess();

  setUpAll(() => registerFallbackValue(FakeAuthSuccess()));

  setUp(() {
    apiProvider = MockAuthApiProvider();
    repository = AuthRepository(apiProvider: apiProvider);
  });

  group('Given the auth repository', () {
    test('when signing in succeeds then the session is saved', () async {
      when(
        () =>
            apiProvider.login(email: 'ada@example.com', password: 'secret123'),
      ).thenAnswer((_) async => authSuccess);
      when(() => apiProvider.saveSession(any())).thenAnswer((_) async {});

      await repository.signIn(email: 'ada@example.com', password: 'secret123');

      verify(() => apiProvider.saveSession(authSuccess)).called(1);
    });

    test('when signing in fails then the error is rethrown and nothing is '
        'saved', () async {
      when(
        () => apiProvider.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        const HttpException400(code: AppErrorCode.authInvalidCredentials),
      );

      await expectLater(
        repository.signIn(email: 'ada@example.com', password: 'wrong-pass'),
        throwsA(isA<HttpException400>()),
      );
      verifyNever(() => apiProvider.saveSession(any()));
    });

    test('when registration finishes then the name and language go in the same '
        'call and the session is saved after it', () async {
      when(
        () => apiProvider.finishRegistration(
          registrationToken: 'token',
          password: 'secret123',
          fullName: 'Ada Lovelace',
          locale: 'fr',
        ),
      ).thenAnswer((_) async => authSuccess);
      when(() => apiProvider.saveSession(any())).thenAnswer((_) async {});

      await repository.finishRegistration(
        registrationToken: 'token',
        password: 'secret123',
        fullName: 'Ada Lovelace',
        locale: 'fr',
      );

      verifyInOrder([
        () => apiProvider.finishRegistration(
          registrationToken: 'token',
          password: 'secret123',
          fullName: 'Ada Lovelace',
          locale: 'fr',
        ),
        () => apiProvider.saveSession(authSuccess),
      ]);
    });

    test('when registration fails then no session is saved', () async {
      when(
        () => apiProvider.finishRegistration(
          registrationToken: any(named: 'registrationToken'),
          password: any(named: 'password'),
          fullName: any(named: 'fullName'),
          locale: any(named: 'locale'),
        ),
      ).thenThrow(const HttpException400(code: AppErrorCode.invalidFullName));

      await expectLater(
        repository.finishRegistration(
          registrationToken: 'token',
          password: 'secret123',
          fullName: ' ',
          locale: 'en',
        ),
        throwsA(isA<HttpException400>()),
      );
      verifyNever(() => apiProvider.saveSession(any()));
    });

    test(
      'when signed-in state is read then it comes from the API provider',
      () {
        when(() => apiProvider.isSignedIn).thenReturn(true);

        expect(repository.isSignedIn, isTrue);
      },
    );
  });
}
