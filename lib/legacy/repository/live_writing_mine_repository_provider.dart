import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/legacy/live_writing/data/repositories/live_writing_mine_repository_impl.dart';
import 'package:wehavit/legacy/repository/live_writing_mine_repository.dart';

part 'live_writing_mine_repository_provider.g.dart';

@riverpod
MyLiveWritingRepository liveWritingPostRepository(
        LiveWritingPostRepositoryRef ref) =>
    LiveWritingPostRepositoryImpl();
