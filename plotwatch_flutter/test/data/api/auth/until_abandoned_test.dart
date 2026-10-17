import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Plan: doc/04g-m8-hardening.md, step 10e. On the web, closing Google's tab
// left the Continue with Google button spinning for 5 minutes.
void main() {
  const grace = Duration(milliseconds: 50);

  group('Given the web Google sign-in waiting for its tab', () {
    test('when Google answers then the answer comes through', () async {
      final returns = StreamController<void>();

      final result = untilAbandoned(Future.value('code'), returns.stream);

      expect(await result, 'code');
      await returns.close();
    });

    test('when the person comes back with no answer then it is cancelled', () async {
      final returns = StreamController<void>();
      final never = Completer<String>();

      final result = untilAbandoned(never.future, returns.stream, grace: grace);
      returns.add(null);

      expect(await result, isNull);
      await returns.close();
    });

    test('when the answer comes just after the person is back then it '
        'still counts', () async {
      final returns = StreamController<void>();
      final answer = Completer<String>();

      final result = untilAbandoned(answer.future, returns.stream, grace: grace);
      returns.add(null);
      answer.complete('code');

      expect(await result, 'code');
      await returns.close();
    });

    test('when Google fails then the error comes through', () async {
      final returns = StreamController<void>();

      final result = untilAbandoned<String>(
        Future.error(StateError('denied')),
        returns.stream,
      );

      await expectLater(result, throwsA(isA<StateError>()));
      await returns.close();
    });

    test('when an answer comes after the cancel then it is ignored', () async {
      final returns = StreamController<void>();
      final late = Completer<String>();

      final result = untilAbandoned(late.future, returns.stream, grace: grace);
      returns.add(null);
      expect(await result, isNull);

      late.completeError(StateError('timeout'));
      await Future<void>.delayed(grace);
      await returns.close();
    });
  });
}
