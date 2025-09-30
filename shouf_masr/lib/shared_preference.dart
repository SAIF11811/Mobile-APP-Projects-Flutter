import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String keyRememberMeTraveler = 'remember_me_traveler';
  static const String keyRememberMeAgency = 'remember_me_agency';
  static const String keyCompany = 'company';
  static const String keyEmail = 'email';
  static const String keyPassword = 'password';

  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // Traveler Remember Me
  static Future<void> setTravelerRememberMe(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(keyRememberMeTraveler, value);
  }

  static Future<bool> getTravelerRememberMe() async {
    final prefs = await _prefs;
    return prefs.getBool(keyRememberMeTraveler) ?? false;
  }

  // Agency Remember Me
  static Future<void> setAgencyRememberMe(
      bool value, {
        String? company,
        String? email,
        String? password,
      }) async {
    final prefs = await _prefs;
    await prefs.setBool(keyRememberMeAgency, value);
    if (value) {
      if (company != null) await prefs.setString(keyCompany, company);
      if (email != null) await prefs.setString(keyEmail, email);
      if (password != null) await prefs.setString(keyPassword, password);
    }
  }

  static Future<bool> getAgencyRememberMe() async {
    final prefs = await _prefs;
    return prefs.getBool(keyRememberMeAgency) ?? false;
  }

  static Future<String?> getCompany() async {
    final prefs = await _prefs;
    return prefs.getString(keyCompany);
  }

  static Future<String?> getEmail() async {
    final prefs = await _prefs;
    return prefs.getString(keyEmail);
  }

  static Future<String?> getPassword() async {
    final prefs = await _prefs;
    return prefs.getString(keyPassword);
  }

  static Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
