import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/friend_list/domain/repositories/friend_repository_provider.dart';
import 'package:wehavit/features/friend_list/domain/usecases/get_friend_list_usecase.dart';

final getFriendListUseCaseProvider =
Provider<GetFriendListUsecase>((ref) {
  final resolutionRepository = ref.watch(friendRepositoryProvider);
  return GetFriendListUsecase(resolutionRepository);
});
