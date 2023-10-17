class AddResolutionModel {
  AddResolutionModel({
    this.goalStatement = '',
    this.actionStatement = '',
    this.oathStatement = '',
    List<bool>? isDaySelectedList,
  }) : isDaySelectedList = isDaySelectedList ?? List<bool>.filled(7, false);

  String goalStatement;
  String actionStatement;
  String oathStatement;
  List<bool> isDaySelectedList = List<bool>.filled(7, false);

  AddResolutionModel copyWith({
    List<bool>? isDaySelectedList,
    String? goalStatement,
    String? actionStatement,
    String? oathStatement,
  }) {
    return AddResolutionModel(
      goalStatement: goalStatement ?? this.goalStatement,
      actionStatement: actionStatement ?? this.actionStatement,
      oathStatement: oathStatement ?? this.oathStatement,
      isDaySelectedList: isDaySelectedList ?? this.isDaySelectedList,
    );
  }

  List<bool> getToggledDaySelectedList(int indexToToggle) {
    return Iterable<int>.generate(isDaySelectedList.length).toList().map((idx) {
      return idx == indexToToggle
          ? !isDaySelectedList[idx]
          : isDaySelectedList[idx];
    }).toList();
  }
}
