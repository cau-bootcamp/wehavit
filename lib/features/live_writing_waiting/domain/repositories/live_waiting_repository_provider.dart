import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/features/live_writing_waiting/data/live_waiting_repository_impl.dart';
import 'package:wehavit/features/live_writing_waiting/domain/repositories/live_waiting_repository.dart';

part 'live_waiting_repository_provider.g.dart';

@riverpod
LiveWaitingRepository liveWaitingRepository(LiveWaitingRepositoryRef ref) =>
    LiveWaitingRepositoryImpl();
