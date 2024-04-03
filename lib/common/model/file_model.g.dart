// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
  clntId: json['clntId'] as String? ?? '',
  writeDt: json['writeDt'] as String? ?? '',
  docNo: json['docNo'] as String? ?? '',
  targetType: json['targetType'] as String? ?? '',
  targetId: json['targetId'] as String? ?? '',
  filePath: json['filePath'] as String? ?? '',
  fileNm: json['fileNm'] as String? ?? '',
  saveNm: json['saveNm'] as String? ?? '',
  fileType: json['fileType'] as String? ?? '',
  extension: json['extension'] as String? ?? '',
  fileSize: json['fileSize'] as String? ?? '',
  delYn: json['delYn'] as String? ?? '',
  fileDesc: json['fileDesc'] as String? ?? '',
  fileSeq: json['fileSeq'] as int? ?? 0,
  useYn: json['useYn'] as String? ?? '',
  createdBy: json['createdBy'] as String? ?? '',
  createdAt: json['createdAt'] as String? ?? '',
  updatedBy: json['updatedBy'] as String? ?? '',
  updatedAt: json['updatedAt'] as String? ?? '',
  editable: json['editable'] as String? ?? '',
);

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
  'clntId': instance.clntId,
  'writeDt': instance.writeDt,
  'docNo': instance.docNo,
  'targetType': instance.targetType,
  'targetId': instance.targetId,
  'filePath': instance.filePath,
  'fileNm': instance.fileNm,
  'saveNm': instance.saveNm,
  'fileType': instance.fileType,
  'extension': instance.extension,
  'fileSize': instance.fileSize,
  'delYn': instance.delYn,
  'fileDesc': instance.fileDesc,
  'fileSeq': instance.fileSeq,
  'useYn': instance.useYn,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt,
  'updatedBy': instance.updatedBy,
  'updatedAt': instance.updatedAt,
  'editable': instance.editable,
};
