import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _tokenKey = 'auth_token';
  static const _onboardingKey = 'onboarding_seen';

  Future<void> saveToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_tokenKey);
  }

  Future<void> markOnboardingSeen() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_onboardingKey, true);
  }

  Future<bool> hasSeenOnboarding() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_onboardingKey) ?? false;
  }
}
