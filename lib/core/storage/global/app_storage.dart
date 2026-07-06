/*
 *  Created by Mithil Devkar
 *  Application Storage
 */

import 'package:get_storage/get_storage.dart';

import '../../config/app_config.dart';

class AppStorage {
  AppStorage._();

  static final AppStorage _instance = AppStorage._();

  static AppStorage get instance => _instance;

  final GetStorage _storage = GetStorage(
    AppConfig.appStorageName,
  );

  //==========================================================================
  // Write
  //==========================================================================

  Future<void> setValue(
      String key,
      dynamic value,
      ) async {
    await _storage.write(key, value);
  }

  //==========================================================================
  // Read
  //==========================================================================

  T? getValue<T>(String key) {
    return _storage.read<T>(key);
  }

  //==========================================================================
  // Remove
  //==========================================================================

  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  //==========================================================================
  // Clear
  //==========================================================================

  Future<void> clearAll() async {
    await _storage.erase();
  }

  //==========================================================================
  // Contains
  //==========================================================================

  bool hasData(String key) {
    return _storage.hasData(key);
  }
}

class StorageKey {
  StorageKey._();

  //==========================================================================
  // Authentication
  //==========================================================================

  static const String isLoggedIn = 'is_logged_in';
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  //==========================================================================
  // User
  //==========================================================================

  static const String userId = 'user_id';
  static const String userName = 'user_name';
  static const String email = 'email';
  static const String profileImage = 'profile_image';
  static const String role = 'role';

  //==========================================================================
  // Device
  //==========================================================================

  static const String fcmToken = 'fcm_token';

  //==========================================================================
  // Settings
  //==========================================================================

  static const String isDarkMode = 'is_dark_mode';
  static const String languageCode = 'language_code';
  static const String notificationsEnabled =
      'notifications_enabled';

  //==========================================================================
  // Event
  //==========================================================================

  static const String selectedEventId =
      'selected_event_id';

  static const String eventName =
      'event_name';

  //==========================================================================
  // Misc
  //==========================================================================

  static const String firstLaunch = 'first_launch';
}