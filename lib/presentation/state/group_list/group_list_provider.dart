import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/group_list_cell.dart';

final groupListProvider = FutureProvider<List<GroupEntity>>(
  (ref) => ref.read(getGroupListUseCaseProvider).call(NoParams()).then(
        (result) => result.fold(
          (failure) => [],
          (success) => success,
        ),
      ),
);

final groupListCellModelProvider = FutureProvider.family<GroupListCellModel, GroupEntity>(
  (ref, groupEntity) => ref.read(getGroupListViewCellWidgetModelUsecaseProvider).call(groupEntity: groupEntity).then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);
