import 'package:json_annotation/json_annotation.dart';
part 'menu_auth_info_model.g.dart';
//part 파일명.g.dart 추가, @JsonSerializable() 적용 후,
// 터미널에 flutter pub run build_runner build --delete-conflicting-outputs 실행
@JsonSerializable()
class MenuAuthInfoModel {
  String? title;
  String? path;
  int? sort;

  MenuAuthInfoModel(this.title, this.path, this.sort);

  factory MenuAuthInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MenuAuthInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuAuthInfoModelToJson(this);
}
