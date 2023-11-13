import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String displayName,
    required String email,
    required String imageUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static final dummyModel = UserModel(
    displayName: 'model not found',
    email: 'email',
    imageUrl:
        'https://media.istockphoto.com/id/961829842/ko/사진/나쁜-고양이-은행-강도.jpg?s=1024x1024&w=is&k=20&c=7mc4cum-tQaOlV0R9xGD0LINLMmho2OpV9FYZigIgfI=',
  );
}
