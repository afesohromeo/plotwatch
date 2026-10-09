import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, group E (M5-4): the bell's badge,
// the notification centre, mark read, tap opens the source.
void main() {
  late AppLocalizations l10n;
  late MockNotificationsBloc bloc;

  final unread = testNotification(id: 7);
  final read = testNotification(
    id: 6,
    type: NotificationType.memberJoined,
    payload: const {
      'memberName': 'Chen',
      'projectName': 'Maison Douala',
      'role': 'viewer',
    },
    readAt: DateTime.utc(2026, 10, 9, 11),
  );

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const NotificationsEvent.markAllRead());
  });
  setUp(() => bloc = MockNotificationsBloc());

  GoRouter router(Widget page) => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => page,
        routes: [
          GoRoute(
            name: notificationsRouteName,
            path: 'notifications',
            builder: (context, state) => const Text('the centre'),
          ),
          GoRoute(
            name: stageRouteName,
            path: 'projects/:projectId/stages/:stageId',
            builder: (context, state) =>
                Text('stage ${state.pathParameters['stageId']}'),
          ),
        ],
      ),
    ],
  );

  Future<void> pumpPage(WidgetTester tester, Widget page) =>
      tester.pumpRouterApp(
        router(BlocProvider<NotificationsBloc>.value(value: bloc, child: page)),
      );

  group('Given the bell', () {
    testWidgets('when there are unread notifications then it shows how many', (
      tester,
    ) async {
      when(
        () => bloc.state,
      ).thenReturn(const NotificationsState(unreadCount: 3));

      await pumpPage(tester, const Scaffold(body: NotificationBell()));

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('when a live notification arrives then the badge follows', (
      tester,
    ) async {
      whenListen(
        bloc,
        Stream.value(const NotificationsState(unreadCount: 1)),
        initialState: const NotificationsState(),
      );

      await pumpPage(tester, const Scaffold(body: NotificationBell()));
      expect(find.text('1'), findsNothing);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('when it is tapped then the notification centre opens', (
      tester,
    ) async {
      when(() => bloc.state).thenReturn(const NotificationsState());

      await pumpPage(tester, const Scaffold(body: NotificationBell()));
      await tester.tap(find.byKey(NotificationBell.buttonKey));
      await tester.pumpAndSettle();

      expect(find.text('the centre'), findsOneWidget);
    });
  });

  group('Given the notification centre', () {
    final loaded = NotificationsState(
      unreadCount: 1,
      notifications: [unread, read],
      paginatedNotifications: [unread, read],
      maxNotifications: true,
      notificationsPageKey: 6,
      notificationsListStatus: GenericStatus.success,
    );

    Future<void> pumpCentre(WidgetTester tester) async {
      whenListen(
        bloc,
        Stream.value(loaded),
        initialState: const NotificationsState(),
      );
      await pumpPage(tester, const NotificationsPage());
      await tester.pumpAndSettle();
    }

    testWidgets('then each notification reads as a sentence', (tester) async {
      await pumpCentre(tester);

      expect(find.text(unread.sentence(l10n)), findsOneWidget);
      expect(find.text(read.sentence(l10n)), findsOneWidget);
    });

    testWidgets('when an unread one is tapped then it is marked read and its '
        'stage opens', (tester) async {
      await pumpCentre(tester);

      await tester.tap(find.byKey(NotificationsPage.tileKey(7)));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const NotificationsEvent.markRead(7))).called(1);
      expect(find.text('stage 2'), findsOneWidget);
    });

    testWidgets('when "mark all read" is tapped then all are marked read', (
      tester,
    ) async {
      await pumpCentre(tester);

      await tester.tap(find.byKey(NotificationsPage.markAllReadButtonKey));
      await tester.pump();

      verify(() => bloc.add(const NotificationsEvent.markAllRead())).called(1);
    });
  });
}
