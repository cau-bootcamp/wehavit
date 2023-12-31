import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'waiting_user_model.freezed.dart';
part 'waiting_user_model.g.dart';

@freezed
class WaitingUser with _$WaitingUser {
  @TimestampConverter()
  const factory WaitingUser({
    DateTime? updatedAt,
    String? userId,
    String? name,
    String? email,
    String? imageUrl,
  }) = _WaitingUser;

  factory WaitingUser.fromJson(Map<String, dynamic> json) =>
      _$WaitingUserFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
