import 'package:wehavit/common/utils/utils.dart';
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
