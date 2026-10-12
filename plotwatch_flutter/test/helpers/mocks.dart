import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class MockMembershipApiProvider extends Mock implements MembershipApiProvider {}

class MockMembershipRepository extends Mock implements MembershipRepository {}

class MockShareProvider extends Mock implements ShareProvider {}

class MockClipboardProvider extends Mock implements ClipboardProvider {}

class MockSiteApiProvider extends Mock implements SiteApiProvider {}

class MockSiteRepository extends Mock implements SiteRepository {}

class MockLocationProvider extends Mock implements LocationProvider {}

class MockStageApiProvider extends Mock implements StageApiProvider {}

class MockStageRepository extends Mock implements StageRepository {}

class MockEvidenceApiProvider extends Mock implements EvidenceApiProvider {}

class MockEvidenceRepository extends Mock implements EvidenceRepository {}

class MockCameraProvider extends Mock implements CameraProvider {}

class MockDeviceInfoProvider extends Mock implements DeviceInfoProvider {}

class MockActivityApiProvider extends Mock implements ActivityApiProvider {}

class MockActivityRepository extends Mock implements ActivityRepository {}

class MockNotificationApiProvider extends Mock
    implements NotificationApiProvider {}

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

class MockUpdateApiProvider extends Mock implements UpdateApiProvider {}

class MockUpdateRepository extends Mock implements UpdateRepository {}

// Used by several pages (doc/04e group E).
class MockFeedBloc extends MockBloc<FeedEvent, FeedState> implements FeedBloc {}

class MockNotificationsBloc
    extends MockBloc<NotificationsEvent, NotificationsState>
    implements NotificationsBloc {}

// The ledger (doc/04f).
class MockLedgerApiProvider extends Mock implements LedgerApiProvider {}

class MockLedgerRepository extends Mock implements LedgerRepository {}

class MockMoneyBloc extends MockBloc<MoneyEvent, MoneyState>
    implements MoneyBloc {}

class MockGoogleSignInBloc extends MockBloc<GoogleSignInEvent, GoogleSignInState>
    implements GoogleSignInBloc {}

/// The auth pages hold the Google button (doc/04g step 4): a Google bloc,
/// not configured unless [bloc] says otherwise.
Widget withGoogleSignIn(Widget child, {GoogleSignInBloc? bloc}) {
  final google = bloc ?? MockGoogleSignInBloc();
  if (bloc == null) {
    when(() => google.state).thenReturn(const GoogleSignInState());
  }
  return BlocProvider<GoogleSignInBloc>.value(value: google, child: child);
}
