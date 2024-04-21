
import 'package:common_project/util/SharedPref.dart';
import 'package:common_project/views/search/model/menu_auth_info_model.dart';
import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier {
  final Set<int> _readAutoSaveSet = {};
  /// 메뉴 리스트 가져오기
  final List<MenuAuthInfoModel> _menuAuthInfoList = [];
  List<MenuAuthInfoModel> get menuAuthInfoList => _menuAuthInfoList;

  /// 자동 저장 기능
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

  bool isUnread(String? seq) {
    return !_readAutoSaveSet.contains(seq);
  }

  void onRead(String key, String value) {
    saveAutoSaveSet(key, value);
    notifyListeners();
  }

  void onInit() {
  }

  void onDispose() {

  }
}
