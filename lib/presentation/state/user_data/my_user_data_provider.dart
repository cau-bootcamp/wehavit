import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/domain.dart';

final myUserDataProvider = FutureProvider.autoDispose<UserDataEntity>(
  (ref) => ref.read(getMyUserDataUsecaseProvider).call().then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

final userDataProvider = FutureProvider.family<UserDataEntity, String>(
  (ref, userId) => ref.read(getUserDataFromIdUsecaseProvider).call(userId).then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);
