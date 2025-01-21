import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

final confirmPostListProvider = FutureProvider.family<List<ConfirmPostEntity>, GroupConfirmPostProviderParam>(
  (ref, param) => ref.read(getGroupConfirmPostListByDateUsecaseProvider).call(param.groupId, param.selectedDate).then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

class GroupConfirmPostProviderParam {
  GroupConfirmPostProviderParam(this.groupId, this.selectedDate);

  String groupId;
  DateTime selectedDate;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupConfirmPostProviderParam && other.groupId == groupId && other.selectedDate == selectedDate;
  }

  @override
  int get hashCode => groupId.hashCode ^ selectedDate.hashCode;
}
