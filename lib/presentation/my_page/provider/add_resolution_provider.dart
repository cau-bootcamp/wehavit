import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/entities/entities.dart';

class AddResolutionNotifier extends StateNotifier<ResolutionEntity> {
  AddResolutionNotifier(Ref ref) : super(ResolutionEntity(startDate: DateTime.now()));

  void changeFanList(List<UserDataEntity> newFanList) {
    state = state.copyWith(shareFriendEntityList: newFanList);
  }

  void changeGroupList(List<GroupEntity> list) {
    state = state.copyWith(shareGroupEntityList: list);
  }

  void changeActionPerWeekState(int newActionPerWeek) {
    state = state.copyWith(actionPerWeek: newActionPerWeek);
  }

  void changeGoalStatement(String newStatement) {
    state = state.copyWith(goalStatement: newStatement);
  }

  void changeActionStatement(String newStatement) {
    state = state.copyWith(actionStatement: newStatement);
  }

  // EitherFuture<bool> uploadResolutionEntity() {
  // return _uploadResolutionUsecase(
  //   goalStatement: state.goalStatement!,
  //   actionStatement: state.actionStatement!,
  //   shareFriendList: state.shareFriendEntityList ?? [],
  //   shareGroupList: state.shareGroupEntityList ?? [],
  //   actionPerWeek: state.actionPerWeek!,
  // );
  // }
}
