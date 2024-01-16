import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.displayName,
    required this.imageUrl,
    required this.email,
  });

  String uid;
  String displayName;
  String imageUrl;
  String email;

  UserDataEntity toUserDataEntity() {
    return UserDataEntity(
      userId: uid,
      userEmail: email,
      userImageUrl: imageUrl,
      userName: displayName,
    );
  }

  static UserModel fromEntity(UserDataEntity entity) {
    return UserModel(
      uid: entity.userId!,
      displayName: entity.userName!,
      imageUrl: entity.userEmail!,
      email: entity.userEmail!,
    );
  }
}
