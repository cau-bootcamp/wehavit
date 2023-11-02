import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/friend_list/domain/repositories/friend_repository_provider.dart';
import 'package:wehavit/features/friend_list/domain/usecases/upload_friend_list_usecase.dart';

final uploadResolutionUsecaseProvider =
Provider<UploadFriendUseCase>((ref) {
  final friendRepository = ref.watch(friendRepositoryProvider);
  return UploadFriendUseCase(friendRepository);
});
