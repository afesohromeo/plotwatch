import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// doc/04b H-1a: with nested routes the page below stays alive, so it reloads
// when it is shown again.
void main() {
  late int returns;
  late GoRouter router;

  setUp(() {
    returns = 0;
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ReloadOnReturn(
            onReturn: () => returns++,
            child: const Text('parent'),
          ),
          routes: [
            GoRoute(
              path: 'child',
              builder: (context, state) => const Text('child'),
            ),
          ],
        ),
      ],
    );
  });

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
  }

  testWidgets('Given the page when it is first shown then nothing reloads', (
    tester,
  ) async {
    await pump(tester);

    expect(returns, 0);
  });

  testWidgets('Given a page above it when that page is popped (Back) then '
      'it reloads once', (tester) async {
    await pump(tester);
    router.go('/child');
    await tester.pumpAndSettle();
    expect(returns, 0);

    router.pop();
    await tester.pumpAndSettle();

    expect(find.text('parent'), findsOneWidget);
    expect(returns, 1);
  });

  testWidgets('Given a page above it when the app goes to the parent then it '
      'reloads once', (tester) async {
    await pump(tester);
    router.go('/child');
    await tester.pumpAndSettle();

    router.go('/');
    await tester.pumpAndSettle();

    expect(returns, 1);
  });
}
