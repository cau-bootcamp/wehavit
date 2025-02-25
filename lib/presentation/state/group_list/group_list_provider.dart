import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

final groupListProvider = FutureProvider<List<GroupEntity>>(
  (ref) => ref.read(getGroupListUseCaseProvider).call(NoParams()).then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);
