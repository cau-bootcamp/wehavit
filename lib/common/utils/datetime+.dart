// ignore: file_names
extension GetMonday on DateTime {
  DateTime getMondayDateTime() {
    DateTime startDate = DateTime(year, month, day)
        .subtract(Duration(days: weekday - DateTime.monday));

    return startDate;
  }
}

const List<String> weekdayKorean = [
  '월',
  '화',
  '수',
  '목',
  '금',
  '토',
  '일',
];
