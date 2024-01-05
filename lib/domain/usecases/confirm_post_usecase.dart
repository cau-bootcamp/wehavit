import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_model.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';

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

class GetAllPostUseCase {
  GetAllPostUseCase(this._repository);

  final ConfirmPostRepository _repository;

  EitherFuture<List<ConfirmPostModel>> call() async {
    // return await _repository.getAllConfirmPosts();
    throw UnimplementedError();
  }
}

class CreatePostUseCase {
  CreatePostUseCase(this._repository);

  final ConfirmPostRepository _repository;

  EitherFuture<bool> call(ConfirmPostModel confirmPost) async {
    // return await _repository.createConfirmPost(confirmPost);
    throw UnimplementedError();
  }
}
