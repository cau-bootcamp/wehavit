import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_entity.freezed.dart';
part 'user_data_entity.g.dart';

@freezed
class UserDataEntity with _$UserDataEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory UserDataEntity({
    @Default('') String handle,
    @Default('') String userId,
    @Default('') String userName,
    @Default('') String userImageUrl,
    @Default('') String aboutMe,
    @Default('') String messageToken,
    required DateTime createdAt,
    @Default(0) int cumulativeGoals,
    @Default(0) int cumulativePosts,
    @Default(0) int cumulativeReactions,
  }) = _UserDataEntity;

  factory UserDataEntity.fromJson(Map<String, dynamic> json) => _$UserDataEntityFromJson(json);

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
