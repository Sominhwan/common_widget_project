
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

import '../common/model/file_model.dart';
import 'ifile_manage_controller.dart';

class ImageFileUploadWidget extends StatefulWidget {
  final IFileManageController iFileManageController;
  const ImageFileUploadWidget({
    super.key,
    required this.iFileManageController
  });

  @override
  State<ImageFileUploadWidget> createState() => _ImageFileUploadWidgetState();
}


class _ImageFileUploadWidgetState extends State<ImageFileUploadWidget> {
  final List<MultipartFile> _addedList = [];
  final List<FileModel> _fileList = [];
  final List<String> _addedFilePaths = []; // 파일 경로를 저장하는 리스트
  final Map<int, Future<Uint8List>> _imageFutures = {}; // 이미지 데이터 Future를 저장할 맵
  late Future<Uint8List> _future;
  static final _imagePicker = ImagePicker();

  Future<void> loadPreviewFile() async {
    // _fileManageController = IFileManageController(
    //     clntId: _emergencyGuideMapManageModel?.clntId ?? '',
    //     targetType: '00006',
    //     targetId: '${_emergencyGuideMapManageModel?.clntId}_${_emergencyGuideMapManageModel?.writeDt}_${_emergencyGuideMapManageModel?.docNo}'
    // );
    // await _fileManageController.search();
    // setState(() {
    //   _fileList = _fileManageController.fileList;
    //   _fileList.asMap().forEach((index, file) {
    //     _imageFutures[index] = CommonApi().getFileData(clntId: file.clntId, writeDt: file.writeDt, docNo: file.docNo);
    //   });
    // });
  }
  Future<Uint8List> loadImageFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    _future = loadImageFromAssets('assets/images/image.png');
    if(widget.iFileManageController.fileList.isNotEmpty) {
      loadPreviewFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: Color.fromRGBO(203, 203, 203, 1), width: 0.3),
            right: BorderSide(color: Color.fromRGBO(203, 203, 203, 1), width: 0.3),
          ),
          color: Colors.white,
        ),
        child: _addedFilePaths.isEmpty
            ? const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '사진 등록',
                style: TextStyle(fontSize: 14, color: Color.fromRGBO(203, 203, 203, 1)),
              ),
              SizedBox(width: 5),
              Icon(Icons.image, color: Color.fromRGBO(203, 203, 203, 1), size: 18),
            ],
          ),
        )
            : (widget.iFileManageController.fileList.isEmpty)
            ? Image.file(File(_addedFilePaths.first), fit: BoxFit.cover) // For a single image
            : //if(file.fileType == 'IMAGE')
                   FutureBuilder<Uint8List>(
                      // future: _imageFutures[index],
                     future: _future,
                     builder: (context, snapshot) {
                       if (snapshot.connectionState == ConnectionState.done) {
                         if (snapshot.hasData) {
                           // Future에서 이미지 데이터가 성공적으로 로드된 경우
                           return Image.memory(
                             snapshot.requireData,
                             fit: BoxFit.cover, // 컨테이너에 이미지를 맞추도록 설정
                           );
                         } else {
                           // 데이터 로드에 실패한 경우
                           return Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               const Text(
                                 "File load error",
                               ),
                               ElevatedButton.icon(
                                 style: ElevatedButton.styleFrom(elevation: 0),
                                 onPressed: () {
                                   setState(() {
                                     // 이미지 로드를 다시 시도
                                     loadPreviewFile();
                                   });
                                 },
                                 icon: const Icon(Icons.refresh),
                                 label: const Text(
                                   '새로고침',
                                 ),
                               ),
                             ],
                           );
                         }
                       } else {
                         // 데이터가 아직 로드되지 않은 경우
                         return const Center(
                           child: CupertinoActivityIndicator(
                             radius: 20,
                             color: Colors.grey,
                           ),
                         );
                       }
                     },
                    )

                // else {
                //   return const Center(
                //     child: Text(
                //       '허용된 확장자가 아닙니다.\n허용된 확장자 : jpg,jpeg,gif,png',
                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                //     ),
                //   );
                // }
      ),
      onTap: () async {
        addFile(context);
      },
    );
  }
  void _addPickedFiles(BuildContext context, Iterable<String> paths) async {
    _addedFilePaths.clear();
    if (paths.isEmpty) return;
    final List<MultipartFile> tempAddedList = [];
    bool isExceeded = false;

    for (String path in paths) {
      try {
        final file = await MultipartFile.fromFile(path);
        if (file.length <= 10000000) {
          tempAddedList.add(file);
        } else {
          isExceeded = true;
          break; // 파일 크기 초과 시, 반복 중단
        }
      } catch (e) {
        // 파일 로딩 실패 처리 (예: 로그 출력, 사용자에게 알림 등)
        log('Error loading file: $e');
      }
    }
    if (isExceeded) {
      // 파일 크기가 초과되었다는 메시지
      if(context.mounted) {

      }
    } else {
      _addedList.addAll(tempAddedList);
      widget.iFileManageController.addedList.clear();
      widget.iFileManageController.addedList.addAll(tempAddedList);
      setState(() {
        _addedFilePaths.addAll(paths);
      });
    }
  }

  /// 파일 추가
  void addFile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (context)  {
        return SizedBox(
          height: 170,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '파일선택',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          //Permission.photos.onGrantedCallback(() {
                            FilePicker.platform
                                .pickFiles(allowMultiple: false, type: FileType.image)
                                .then((res) {
                              if (res != null && res.files.isNotEmpty) {
                                _addPickedFiles(context, [res.files.first.path!]);
                              }
                            });
                          //});
                        },
                        child: SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Transform.rotate (
                                  angle: 45 * (3.141592653589793 / 180), // 45도 기울임
                                  child: const Icon(
                                    Icons.attach_file,
                                    size: 25,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text('파일에서 선택'),
                                const Spacer(),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          // Permission.camera.(() {
                            _imagePicker.pickImage(source: ImageSource.camera).then((image) {
                              _addPickedFiles(context, [if (image != null) image.path]);
                            });
                          // });
                        },
                        child: const SizedBox(
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.photo_camera,
                                  size: 25,
                                ),
                                SizedBox(width: 10),
                                Text('촬영하기'),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        );
      },
    );
  }
}
