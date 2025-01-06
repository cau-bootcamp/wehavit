import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp.runtimeType == String) {
      Timestamp newTimestamp = Timestamp.fromDate(DateTime.parse(timestamp as String));

      DateTime dateTime = newTimestamp.toDate();
      return dateTime;
    } else {
      return timestamp.toDate();
    }
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
