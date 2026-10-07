import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Mirrors the server rules: password (auth module default) and name (M1-2).
void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  group('Given the email validator', () {
    test('when empty then it asks for an email', () {
      expect(Validators.email('', l10n), l10n.validateEmailRequired);
    });
    test('when malformed then it says invalid', () {
      expect(Validators.email('ada@', l10n), l10n.validateEmailInvalid);
    });
    test('when valid (with surrounding spaces) then it passes', () {
      expect(Validators.email(' ada@example.com ', l10n), isNull);
    });
  });

  group('Given the password validator', () {
    test('when empty then it asks for a password', () {
      expect(Validators.password('', l10n), l10n.validatePasswordRequired);
    });
    test('when shorter than 8 characters then it says too short', () {
      expect(
        Validators.password('1234567', l10n),
        l10n.validatePasswordTooShort,
      );
    });
    test('when it starts or ends with a space then it says no spaces', () {
      expect(
        Validators.password(' 12345678', l10n),
        l10n.validatePasswordSpaces,
      );
      expect(
        Validators.password('12345678 ', l10n),
        l10n.validatePasswordSpaces,
      );
    });
    test('when 8 characters without outer spaces then it passes', () {
      expect(Validators.password('12345678', l10n), isNull);
    });
  });

  group('Given the confirm-password validator', () {
    test('when empty then it asks to confirm', () {
      expect(
        Validators.confirmPassword('', 'secret123', l10n),
        l10n.validateConfirmPasswordRequired,
      );
    });
    test('when different from the password then it says they do not match', () {
      expect(
        Validators.confirmPassword('secret124', 'secret123', l10n),
        l10n.validatePasswordMismatch,
      );
    });
    test('when equal to the password then it passes', () {
      expect(
        Validators.confirmPassword('secret123', 'secret123', l10n),
        isNull,
      );
    });
  });

  group('Given the code validator', () {
    test('when blank then it asks for the code', () {
      expect(Validators.code('  ', l10n), l10n.validateCodeRequired);
    });
    test('when filled then it passes', () {
      expect(Validators.code('AB12CD34', l10n), isNull);
    });
  });

  group('Given the name validator', () {
    test('when blank then it asks for a name', () {
      expect(Validators.fullName('   ', l10n), l10n.validateNameRequired);
    });
    test('when longer than 100 characters then it says too long', () {
      expect(Validators.fullName('x' * 101, l10n), l10n.validateNameTooLong);
    });
    test('when 1 to 100 characters then it passes', () {
      expect(Validators.fullName('Ada Lovelace', l10n), isNull);
    });
  });

  // Mirrors the server's ProjectService.validateDetails (doc/04b, group B).
  group('Given the project name validator', () {
    test('when blank then it asks for a project name', () {
      expect(
        Validators.projectName('  ', l10n),
        l10n.validateProjectNameRequired,
      );
    });
    test('when longer than 100 characters then it says too long', () {
      expect(
        Validators.projectName('x' * 101, l10n),
        l10n.validateProjectNameTooLong,
      );
    });
    test('when 1 to 100 characters then it passes', () {
      expect(Validators.projectName('House in Bafoussam', l10n), isNull);
    });
  });

  group('Given the project description validator', () {
    test('when empty then it passes (it is optional)', () {
      expect(Validators.projectDescription('', l10n), isNull);
    });
    test('when longer than 1,000 characters then it says too long', () {
      expect(
        Validators.projectDescription('x' * 1001, l10n),
        l10n.validateDescriptionTooLong,
      );
    });
  });
}
