import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/data/repository/user_model_fetch_repository_impl.dart';
import 'package:wehavit/features/swipe_view/domain/repository/user_model_fetch_repository.dart';

final userModelFetchRepositoryProvider =
    Provider<UserModelFetchRepository>((ref) {
  return UserModelFetchRepositoryImpl(ref);
});
