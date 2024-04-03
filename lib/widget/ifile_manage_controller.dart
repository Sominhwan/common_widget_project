import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../common/model/file_model.dart';


class IFileManageController with ChangeNotifier {
  static final _imagePicker = ImagePicker();
  final String _clntId;
  final String _targetType;
  String targetId;

  IFileManageController({
    required String clntId,
    required String targetType,
    required this.targetId,
    bool readOnly = false,
  })  : _clntId = clntId,
        _targetType = targetType,
        _readOnly = readOnly;
  List<FileModel> _fileList = [];
  List<FileModel> get fileList => _fileList;
  List<FileModel> _deleteList = [];
  List<MultipartFile> _addedList = [];
  List<MultipartFile> get addedList => _addedList;

  bool _readOnly;
  bool get readOnly => _readOnly;
  set readOnly(bool val) {
    _readOnly = val;
    notifyListeners();
  }

  int get fileCnt => _fileList.length + _addedList.length;
  bool get isChanged => _addedList.isNotEmpty || _deleteList.isNotEmpty;

  // Future<void> search() {
  //   return CommonApi()
  //       .getFiles(
  //     clntId: _clntId,
  //     targetType: _targetType,
  //     targetId: targetId,
  //   )
  //       .then((res) {
  //     _fileList = res;
  //     _deleteList = [];
  //     _addedList = [];
  //     notifyListeners();
  //   });
  // }

  // Future<void> save() {
  //   return Future.wait([
  //     if (_addedList.isNotEmpty)
  //       CommonApi().uploadFiles(
  //         _addedList,
  //         clntId: _clntId,
  //         targetType: _targetType,
  //         targetId: targetId,
  //       ).then((_) {
  //         _addedList = [];
  //       }),
  //     if (_deleteList.isNotEmpty)
  //       CommonApi().deleteFiles(_deleteList).then((_) {
  //         _deleteList = [];
  //       })
  //   ]).then((_) {
  //     return search();
  //   });
  // }


}
