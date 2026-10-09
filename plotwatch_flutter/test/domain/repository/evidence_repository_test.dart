import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04d-m4-capture.md, group B: captures through `client.evidence`.
void main() {
  late MockEvidenceApiProvider apiProvider;
  late EvidenceRepository repository;

  setUp(() {
    apiProvider = MockEvidenceApiProvider();
    repository = EvidenceRepository(apiProvider: apiProvider);
  });

  group('Given the evidence repository', () {
    test('when a capture is committed, finalized or retracted then the '
        'server answer is returned', () async {
      final commit = testEvidenceCommit();
      final result = EvidenceCommitResult(
        evidence: testEvidence(status: EvidenceStatus.committed),
        uploadDescription: 'desc',
      );
      final finalized = testEvidence();
      when(() => apiProvider.commit(1, commit)).thenAnswer((_) async => result);
      when(() => apiProvider.finalize(1, 9)).thenAnswer((_) async => finalized);
      when(
        () => apiProvider.retract(1, 9, 'Blurred'),
      ).thenAnswer((_) async => finalized);

      expect(await repository.commit(1, commit), result);
      expect(await repository.finalize(1, 9), finalized);
      expect(await repository.retract(1, 9, 'Blurred'), finalized);
    });

    test(
      'when the upload is refused then it throws an UploadException',
      () async {
        final bytes = Uint8List.fromList([1, 2, 3]);
        when(
          () => apiProvider.upload('desc', bytes),
        ).thenAnswer((_) async => false);

        await expectLater(
          repository.upload('desc', bytes),
          throwsA(isA<UploadException>()),
        );
      },
    );

    // M4-F2: Serverpod's FileUploader can hang forever when the connection
    // fails, which left the capture screen spinning.
    test('when the upload never answers then it gives up with an '
        'UploadException', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      when(
        () => apiProvider.upload('desc', bytes),
      ).thenAnswer((_) => Completer<bool>().future);
      final impatient = EvidenceRepository(
        apiProvider: apiProvider,
        uploadTimeout: const Duration(milliseconds: 20),
      );

      await expectLater(
        impatient.upload('desc', bytes),
        throwsA(isA<UploadException>()),
      );
    });

    test('when the upload succeeds then nothing is thrown', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      when(
        () => apiProvider.upload('desc', bytes),
      ).thenAnswer((_) async => true);

      await repository.upload('desc', bytes);

      verify(() => apiProvider.upload('desc', bytes)).called(1);
    });

    test('when a photo is fetched then its bytes are returned', () async {
      final bytes = Uint8List.fromList([7, 8, 9]);
      when(
        () => apiProvider.media(1, 9, MediaVariant.thumbnail),
      ).thenAnswer((_) async => ByteData.sublistView(bytes));

      expect(await repository.media(1, 9, MediaVariant.thumbnail), bytes);
    });

    test('when a call fails then the error is rethrown', () async {
      when(
        () => apiProvider.list(any(), any()),
      ).thenThrow(const NetworkException());

      await expectLater(
        repository.fetchStageEvidence(1, 2),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
