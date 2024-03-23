

import 'package:flutter/material.dart';

import '../../../util/SharedPref.dart';

class MainProvider extends ChangeNotifier {
  /// 광고 일주일 안보기
  void saveAutoSaveSet(String key, String value) {
    SharedPref.setToJson(
      key,
      value,
    );
  }

  void removeAutoSaveText(String key) {
    SharedPref.removeKeyValue(key);
  }

  void removeKeysStarting(String key) {
    SharedPref.removeKeysStartingWith(key);
  }

  String? getAutoSaveText(String key) {
    return SharedPref.loadKeyValue(key);
  }
}