// ignore: file_names
extension GetMonday on DateTime {
  DateTime getMondayDateTime() {
    DateTime startDate = DateTime(year, month, day)
        .subtract(Duration(days: weekday - DateTime.monday));

    return startDate;
  }
}
