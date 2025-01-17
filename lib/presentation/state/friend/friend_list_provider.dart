import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

final friendListProvider = FutureProvider<List<UserDataEntity>>(
  (ref) => ref.read(getFriendListUseCaseProvider).call().then(
        (result) => result.fold(
          (failure) => [],
          (success) => success,
        ),
      ),
);
