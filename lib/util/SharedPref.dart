import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static String? loadKeyValue(String key) {
    String? value = instance.getString(key);
    // 따옴표 제거 로직 추가
    value = value?.replaceAll('"', '');
    return value;
  }

  static void removeKeyValue(String key) {
    instance.remove(key);
  }

  static dynamic getFromJson(String key) => switch (instance.getString(key)) {
    String json => jsonDecode(json),
    _ => null,
  };

  static Future<bool> setToJson(String key, Object value) {
    log(key);
    return instance.setString(key, jsonEncode(value));
  }
  // 특정 값으로 시작하는 모든 키-값 쌍을 삭제하는 메서드 추가
  static Future<void> removeKeysStartingWith(String prefix) async {
    final keysToRemove = instance.getKeys().where((key) => key.startsWith(prefix));
    for (String key in keysToRemove) {
      await instance.remove(key);
    }
  }
}
