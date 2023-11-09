import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';

class GetAllPostUseCase {
  GetAllPostUseCase(this._repository);

  final ConfirmPostRepository _repository;

  EitherFuture<List<ConfirmPostModel>> call() async {
    return await _repository.getAllConfirmPosts();
  }
}

class CreatePostUseCase {
  CreatePostUseCase(this._repository);

  final ConfirmPostRepository _repository;

  EitherFuture<bool> call(ConfirmPostModel confirmPost) async {
    return await _repository.createConfirmPost(confirmPost);
  }
}

// provider
final getAllPostUseCaseProvider = Provider<GetAllPostUseCase>(
  (ref) => GetAllPostUseCase(
    ref.watch(confirmPostRepositoryProvider),
  ),
);
