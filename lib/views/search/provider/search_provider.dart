
import 'package:common_project/util/SharedPref.dart';
import 'package:common_project/views/search/model/menu_auth_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider extends ChangeNotifier {
  final Set<int> _readAutoSaveSet = {};

  // void loadAutoSaveSet() {
  //   if (SharedPref.getFromJson('User_${UserInfo().userCd}/AutoSaveSet')
  //   case List list) {
  //     _readAutoSaveSet = list.cast<String>().toSet();
  //   } else {
  //     _readAutoSaveSet = {};
  //   }
  // }

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
    // _readAutoSaveSet.add(seq);
    saveAutoSaveSet(key, value);
    notifyListeners();
    // SharedPref.init();
  }

  void onInit() {
  }

  void onDispose() {

  }
}
