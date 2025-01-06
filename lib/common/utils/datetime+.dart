// ignore: file_names
import 'package:intl/intl.dart';

extension GetRelaventDay on DateTime {
  DateTime parseDateOnly() {
    return DateTime(year, month, day);
  }

  DateTime getMondayDateTime() {
    DateTime startDate = parseDateOnly().subtract(Duration(days: weekday - DateTime.monday));

    return startDate;
  }
}

extension FormatKorean on DateTime {
  static final DateFormat dateFormatter = DateFormat('yyyy년 MM월 dd일');
  static final DateFormat timeFormatter = DateFormat('a h시 m분', 'ko');

  String getFormattedString({String format = ''}) {
    if (format.isEmpty) {
      return dateFormatter.format(this);
    } else {
      final DateFormat formatter = DateFormat(format);
      return formatter.format(this);
    }
  }

  String formatToKoreanTime() {
    // "a"는 오전/오후, "h"는 12시간제 시각, "m"은 분
    return timeFormatter.format(this);
  }
}

const List<String> weekdayKorean = ['월', '화', '수', '목', '금', '토', '일'];
