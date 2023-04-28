import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login/model/user_profile.dart';

abstract class Preferences {
  static Future<void> saveUser(UserProfile result) async {
    final prefs = await SharedPreferences.getInstance();
    final user = jsonEncode(result.toJson());
    await prefs.setString('user', user);
    log('User ${result.data!.name} saved.');
  }

  static Future<UserProfile?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final localData = prefs.getString('user');
    if (localData != null) {
      final result = UserProfile.fromJson(jsonDecode(localData));
      log('User ${result.data!.name} fetched.');
      return result;
    }
    return null;
  }
}
