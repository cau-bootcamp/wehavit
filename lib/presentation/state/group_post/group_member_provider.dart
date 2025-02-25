import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

final loadAchievePercentageProvider = FutureProvider.autoDispose.family<double, LoadAchievePercentageProviderParam>(
  (ref, param) => ref
      .read(getAchievementPercentageForGroupMemberUsecaseProvider)
      .call(groupId: param.groupId, userId: param.userId)
      .then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

class LoadAchievePercentageProviderParam {
  LoadAchievePercentageProviderParam(this.groupId, this.userId);

  String groupId;
  String userId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadAchievePercentageProviderParam && other.groupId == groupId && other.userId == userId;
  }

  @override
  int get hashCode => groupId.hashCode ^ userId.hashCode;
}

final sharedResolutionCountProvider = FutureProvider.family<int, SharedResolutionCountProviderParam>(
  (ref, param) => ref
      .read(getSharedResolutionListToGroupUsecaseProvider)
      .call(param.userId, param.groupId)
      .then((result) => result.fold((failure) => Future.error(failure.message), (success) => success.length)),
);

class SharedResolutionCountProviderParam {
  SharedResolutionCountProviderParam(this.groupId, this.userId);

  String groupId;
  String userId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SharedResolutionCountProviderParam && other.groupId == groupId && other.userId == userId;
  }

  @override
  int get hashCode => groupId.hashCode ^ userId.hashCode;
}

final getAppliedUserIdListProvider = FutureProvider.autoDispose.family<List<String>, GroupEntity>(
  (ref, groupEntity) => ref
      .read(getAppliedUserListForGroupEntityUsecaseProvider)
      .call(groupEntity)
      .then((result) => result.fold((failure) => Future.error(failure.message), (success) => success)),
);
