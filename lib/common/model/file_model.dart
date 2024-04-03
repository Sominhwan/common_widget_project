import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';
//part 파일명.g.dart 추가, @JsonSerializable() 적용 후,
// 터미널에 flutter pub run build_runner build --delete-conflicting-outputs 실행

@JsonSerializable()
class FileModel {
  String clntId;
  String writeDt;
  String docNo;
  String targetType;
  String targetId;
  String filePath;
  String fileNm;
  String saveNm;
  String fileType;
  String extension;
  String fileSize;
  String delYn;
  String fileDesc;
  int fileSeq;
  String useYn;
  String createdBy;
  String createdAt;
  String updatedBy;
  String updatedAt;
  String editable;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? byteArray;

  FileModel({
    this.clntId = '',
    this.writeDt = '',
    this.docNo = '',
    this.targetType = '',
    this.targetId = '',
    this.filePath = '',
    this.fileNm = '',
    this.saveNm = '',
    this.fileType = '',
    this.extension = '',
    this.fileSize = '',
    this.delYn = '',
    this.fileDesc = '',
    this.fileSeq = 0,
    this.useYn = '',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedBy = '',
    this.updatedAt = '',
    this.editable = '',
  });

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);

  int get bytes =>
      ((double.tryParse(fileSize.replaceFirst('MB', '')) ?? 10) * 1048576)
          .ceil();
}
