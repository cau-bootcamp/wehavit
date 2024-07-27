import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_entity.freezed.dart';
part 'user_data_entity.g.dart';

@freezed
class UserDataEntity with _$UserDataEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory UserDataEntity({
    String? handle,
    String? userId,
    String? userName,
    String? userImageUrl,
    String? aboutMe,
    String? messageToken,
    DateTime? createdAt,
    int? cumulativeGoals,
    int? cumulativePosts,
    int? cumulativeReactions,
  }) = _UserDataEntity;

  factory UserDataEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDataEntityFromJson(json);

  static UserDataEntity dummyModel = UserDataEntity(
    userName: 'dummy user',
    handle: 'dummy@dummy.com',
    userId: '00000000',
    userImageUrl: 'https://www.cau.ac.kr/cau/img/campusinfo/mascot-tab1_01.jpg',
    aboutMe: 'This is me! Hello world!',
    createdAt: DateTime.now().subtract(const Duration(days: 31)),
    cumulativeGoals: 32,
    cumulativePosts: 21,
    cumulativeReactions: 10,
  );
}

enum UserIncrementalDataType {
  goal,
  post,
  reaction,
}
