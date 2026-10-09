import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, group F (M5-9 b).
void main() {
  late MockUpdateApiProvider apiProvider;
  late UpdateRepository repository;

  setUp(() {
    apiProvider = MockUpdateApiProvider();
    repository = UpdateRepository(apiProvider: apiProvider);
  });

  test('Given a draft then it is posted and the update comes back', () async {
    final draft = ProgressUpdateDraft(text: 'Concrete poured.', stageId: 2);
    final update = testUpdate();
    when(() => apiProvider.create(1, draft)).thenAnswer((_) async => update);

    expect(await repository.createUpdate(1, draft), update);
  });

  test('Given an update ID then that update is fetched', () async {
    final update = testUpdate(id: 4);
    when(() => apiProvider.get(1, 4)).thenAnswer((_) async => update);

    expect(await repository.fetchUpdate(1, 4), update);
  });
}
