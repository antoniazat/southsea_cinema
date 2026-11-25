import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main() {
  test('UserSettings defaults to empty values and false newsletter', () {
    const UserSettings settings = UserSettings();
    expect(settings.name, isEmpty);
    expect(settings.address, isEmpty);
    expect(settings.email, isEmpty);
    expect(settings.receiveNewsletter, isFalse);
  });

  test('UserSettings stores configured values', () {
    const UserSettings settings = UserSettings(
      name: 'Jessica Holmes',
      address: '22 Sports Wall',
      email: 'jessica@yourmom.com',
      receiveNewsletter: true,
    );
    expect(settings.name, 'Jessica Holmes');
    expect(settings.address, '22 Sports Wall');
    expect(settings.email, 'jessica@yourmom.com');
    expect(settings.receiveNewsletter, isTrue);
  });
}
