import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/group/model/model.dart';

class AddResolutionDoneViewModel {
  ResolutionEntity? resolutionEntity;

  List<UserDataEntity>? friendList;

  List<bool>? selectedFriendList;
  List<bool>? tempSelectedFriendList;

  List<GroupListViewCellWidgetModel>? groupModelList;

  List<bool>? selectedGroupList;
  List<bool>? tempSelectedGroupList;
}
