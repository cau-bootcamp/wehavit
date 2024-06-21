import 'package:wehavit/presentation/group_post/group_post.dart';

class FriendPostViewModel extends PostViewModel {
  static final mondayOfThisWeek = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).subtract(Duration(days: DateTime.now().weekday - 1));

  List<String> sharedResolutionIdList = [];
}
