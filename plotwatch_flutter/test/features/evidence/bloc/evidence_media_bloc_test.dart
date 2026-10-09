import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04d-m4-capture.md, decision M4-4 and group D: photos come
// through the server; a page keeps the bytes it loaded.
void main() {
  late MockEvidenceRepository repository;
  final bytes = Uint8List.fromList([1, 2, 3]);
  final key = EvidenceMediaState.keyFor(9, MediaVariant.thumbnail);

  setUpAll(() => registerFallbackValue(MediaVariant.photo));
  setUp(() => repository = MockEvidenceRepository());

  EvidenceMediaBloc build() =>
      EvidenceMediaBloc(evidenceRepository: repository);

  const request = EvidenceMediaEvent.requested(
    projectId: 1,
    evidenceId: 9,
    variant: MediaVariant.thumbnail,
  );

  blocTest<EvidenceMediaBloc, EvidenceMediaState>(
    'Given a thumbnail when it is requested then its bytes are kept',
    setUp: () => when(
      () => repository.media(1, 9, MediaVariant.thumbnail),
    ).thenAnswer((_) async => bytes),
    build: build,
    act: (bloc) => bloc.add(request),
    expect: () => [
      EvidenceMediaState(loading: {key}),
      EvidenceMediaState(images: {key: bytes}),
    ],
  );

  blocTest<EvidenceMediaBloc, EvidenceMediaState>(
    'Given a thumbnail already loaded when it is requested again then it '
    'isn\'t fetched again',
    build: build,
    seed: () => EvidenceMediaState(images: {key: bytes}),
    act: (bloc) => bloc.add(request),
    expect: () => <EvidenceMediaState>[],
    verify: (_) => verifyNever(() => repository.media(any(), any(), any())),
  );

  blocTest<EvidenceMediaBloc, EvidenceMediaState>(
    'Given the network is down when a thumbnail is requested then it is '
    'marked as failed',
    setUp: () => when(
      () => repository.media(any(), any(), any()),
    ).thenThrow(const NetworkException()),
    build: build,
    act: (bloc) => bloc.add(request),
    expect: () => [
      EvidenceMediaState(loading: {key}),
      EvidenceMediaState(failed: {key}),
    ],
  );
}
