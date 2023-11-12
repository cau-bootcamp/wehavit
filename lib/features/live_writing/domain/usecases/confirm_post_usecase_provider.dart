import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';

final getAllPostUseCaseProvider = Provider<GetAllPostUseCase>(
  (ref) => GetAllPostUseCase(
    ref.watch(confirmPostRepositoryProvider),
  ),
);

final createPostUseCaseProvider = Provider<CreatePostUseCase>(
  (ref) => CreatePostUseCase(
    ref.watch(confirmPostRepositoryProvider),
  ),
);
