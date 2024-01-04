import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/domain/repositories/live_writing_mine_repository.dart';
import 'package:wehavit/presentation/live_writing/data/repositories/live_writing_mine_repository_impl.dart';

part 'live_writing_mine_repository_provider.g.dart';

@riverpod
MyLiveWritingRepository liveWritingPostRepository(
        LiveWritingPostRepositoryRef ref) =>
    LiveWritingPostRepositoryImpl();
