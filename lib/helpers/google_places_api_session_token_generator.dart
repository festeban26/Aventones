import 'package:uuid/uuid.dart';

/// A session token generator.
/// It uses UUID v4 as recommended by the Google Places API guidelines.
class GooglePlacesApiSessionTokenGenerator {
  static const int _TOKEN_EXPIRATION_IN_MINUTES = 5;

  static DateTime _lastTimeASessionTokenWasGenerated;
  static String _currentToken;
  static bool _mustResetSessionToken = false;

  static String getToken() {
    if (_lastTimeASessionTokenWasGenerated == null || _currentToken == null) {
      _lastTimeASessionTokenWasGenerated = DateTime.now();
      _currentToken = Uuid().v4();
    }
    // If the session token was used to request place basic data, the token must
    // be reset.
    else if (_mustResetSessionToken) {
      _lastTimeASessionTokenWasGenerated = DateTime.now();
      _currentToken = Uuid().v4();
      _mustResetSessionToken = false;
    }

    /// If 5 minutes has passed since the UUID was generated, generate another
    /// UUID due to Google Places API UUID time lifespan (5 min between calls with
    /// the same UUID).
    else if (DateTime.now().difference(_lastTimeASessionTokenWasGenerated) >
        Duration(
            minutes: GooglePlacesApiSessionTokenGenerator
                ._TOKEN_EXPIRATION_IN_MINUTES)) {
      _lastTimeASessionTokenWasGenerated = DateTime.now();
      _currentToken = Uuid().v4();
    }
    return _currentToken;
  }

  static void resetToken() {
    _mustResetSessionToken = true;
  }
}
