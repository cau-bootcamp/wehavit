class AddResolutionModel {
  AddResolutionModel({
    this.goalStatement = '',
    this.actionStatement = '',
    this.oathStatement = '',
    List<bool>? isDaySelectedList,
  }) : isDaySelectedList = List<bool>.filled(7, false);

  List<bool> isDaySelectedList;
  String goalStatement;
  String actionStatement;
  String oathStatement;

  AddResolutionModel copyWith({
    List<bool>? isDaySelectedList,
    String? goalStatement,
    String? actionStatement,
    String? oathStatement,
  }) {
    return AddResolutionModel(
      isDaySelectedList: isDaySelectedList ?? this.isDaySelectedList,
      goalStatement: goalStatement ?? this.goalStatement,
      actionStatement: actionStatement ?? this.actionStatement,
      oathStatement: oathStatement ?? this.oathStatement,
    );
  }

  List<bool> getToggledDaySelectedList(List<bool> origin, int toggleIndex) {
    return Iterable<int>.generate(origin.length).toList().map((idx) {
      return idx == toggleIndex ? !origin[idx] : origin[idx];
    }).toList();
  }
}
