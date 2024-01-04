import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';
import 'package:wehavit/domain/repositories/live_waiting_repository.dart';
import 'package:wehavit/presentation/live_writing_waiting/data/live_waiting_repository_impl.dart';

part 'live_waiting_repository_provider.g.dart';

@riverpod
LiveWaitingRepositoryImpl liveWaitingRepository(LiveWaitingRepositoryRef ref) {
// ignore: avoid_manual_providers_as_generated_provider_dependency
  final resolutionRepository = ref.watch(friendRepositoryProvider);
  ref.keepAlive();
  return LiveWaitingRepositoryImpl(resolutionRepository);
}
