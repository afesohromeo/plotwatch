import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    show AuthSuccess;

class MockAuthApiProvider extends Mock implements AuthApiProvider {}

class MockProfileApiProvider extends Mock implements ProfileApiProvider {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockProfileRepository extends Mock implements ProfileRepository {}

class FakeAuthSuccess extends Fake implements AuthSuccess {}

class MockProjectApiProvider extends Mock implements ProjectApiProvider {}

class MockProjectRepository extends Mock implements ProjectRepository {}
