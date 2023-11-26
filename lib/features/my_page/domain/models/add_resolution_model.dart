import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';

class AddResolutionModel {
  AddResolutionModel({
    this.goalStatement = '',
    this.actionStatement = '',
    this.oathStatement = '',
    List<FriendModel>? fanList,
    List<bool>? isDaySelectedList,
  }) : isDaySelectedList = isDaySelectedList ?? List<bool>.filled(7, false) {
    this.fanList = fanList?.toList() ?? [];
  }

  String goalStatement;
  String actionStatement;
  String oathStatement;
  List<FriendModel> fanList = [];
  List<bool> isDaySelectedList = List<bool>.filled(7, false);

  AddResolutionModel copyWith({
    List<bool>? isDaySelectedList,
    String? goalStatement,
    String? actionStatement,
    String? oathStatement,
    List<FriendModel>? fanList,
  }) {
    final ad = AddResolutionModel(
      goalStatement: goalStatement ?? this.goalStatement,
      actionStatement: actionStatement ?? this.actionStatement,
      oathStatement: oathStatement ?? this.oathStatement,
      isDaySelectedList: isDaySelectedList ?? this.isDaySelectedList,
      fanList: fanList ?? this.fanList,
    );
    return ad;
  }

  List<bool> getToggledDaySelectedList(int indexToToggle) {
    return Iterable<int>.generate(isDaySelectedList.length).toList().map((idx) {
      return idx == indexToToggle
          ? !isDaySelectedList[idx]
          : isDaySelectedList[idx];
    }).toList();
  }
}
