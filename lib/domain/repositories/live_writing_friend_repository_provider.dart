import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/domain/repositories/live_writing_friend_repository.dart';
import 'package:wehavit/presentation/live_writing/data/repositories/live_writing_friend_repository_impl.dart';

part 'live_writing_friend_repository_provider.g.dart';

@riverpod
LiveWritingFriendRepositoryImpl liveWritingFriendRepository(
        LiveWritingFriendRepositoryRef ref) =>
    LiveWritingFriendRepositoryImpl();
