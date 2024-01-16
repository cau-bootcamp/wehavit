import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_entity.freezed.dart';
part 'user_data_entity.g.dart';

@freezed
class UserDataEntity with _$UserDataEntity {
  @JsonSerializable()
  factory UserDataEntity({
    String? userEmail,
    String? userId,
    String? userName,
    String? userImageUrl,
  }) = _UserDataEntity;

  factory UserDataEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDataEntityFromJson(json);

  static UserDataEntity dummyModel = UserDataEntity(
    userName: 'dummy user',
    userEmail: 'dummy@dummy.com',
    userId: '00000000',
    userImageUrl: 'https://www.cau.ac.kr/cau/img/campusinfo/mascot-tab1_01.jpg',
  );
}
