import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/features/live_writing/data/repositories/live_writing_friend_repository_impl.dart';
import 'package:wehavit/features/live_writing/domain/repositories/live_writing_friend_repository.dart';

part 'live_writing_friend_repository_provider.g.dart';

@riverpod
LiveWritingFriendRepository liveWritingFriendRepository(
        LiveWritingFriendRepositoryRef ref) =>
    LiveWritingFriendRepositoryImpl();
