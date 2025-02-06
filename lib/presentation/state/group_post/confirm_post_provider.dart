import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

final groupSharedResolutionListProvider = FutureProvider.family<List<String>, GroupSharedResolutionProviderParam>(
  (ref, param) async {
    Map<String, List<String>> sharedResolutionIdMap = {};

    await Future.wait(
      param.groupMemberList.map(
        (memberId) => ref.read(getSharedResolutionListToGroupUsecaseProvider).call(memberId, param.groupId).then(
          (result) {
            final list = result.fold(
              (failure) => <String>[], // 실패 시 빈 리스트 반환
              (list) => list, // 성공 시 리스트 반환
            );
            sharedResolutionIdMap[memberId] = list;
          },
        ),
      ),
    );

    final List<String> sharedResolutionIdList = sharedResolutionIdMap.entries.expand((e) => e.value).toList();

    return sharedResolutionIdList;

    // return ref.read(getSharedResolutionListToGroupUsecaseProvider).call('abc', groupId).then(
    //       (result) => result.fold(
    //         (failure) => Future.error(failure.message),
    //         (success) => success,
    //       ),
    //     );
  },
);

class GroupSharedResolutionProviderParam {
  GroupSharedResolutionProviderParam(this.groupId, this.groupMemberList);

  String groupId;
  List<String> groupMemberList;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupSharedResolutionProviderParam &&
        other.groupId == groupId &&
        other.groupMemberList == groupMemberList;
  }

  @override
  int get hashCode => groupId.hashCode ^ groupMemberList.hashCode;
}

final confirmPostListProvider = FutureProvider.family<List<ConfirmPostEntity>, ConfirmPostProviderParam>(
  (ref, param) => ref.read(getConfirmPostListByDateUsecaseProvider).call(param.resolutionList, param.selectedDate).then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

class ConfirmPostProviderParam {
  ConfirmPostProviderParam(this.resolutionList, this.selectedDate);

  List<String> resolutionList;
  DateTime selectedDate;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfirmPostProviderParam &&
        other.resolutionList == resolutionList &&
        other.selectedDate == selectedDate;
  }

  @override
  int get hashCode => resolutionList.hashCode ^ selectedDate.hashCode;
}
