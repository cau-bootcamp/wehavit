import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'firebase_group_model.freezed.dart';
part 'firebase_group_model.g.dart';

@freezed
class FirebaseGroupModel with _$FirebaseGroupModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory FirebaseGroupModel({
    required String groupName,
    required String groupDescription,
    required String groupRule,
    required String groupManagerUid,
    required List<UserDataEntity> groupMembers,
  }) = _FirebaseGroupModel;

  factory FirebaseGroupModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseGroupModelFromJson(json);
}
