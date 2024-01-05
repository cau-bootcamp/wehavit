import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';

final getAllPostUseCaseProvider = Provider<GetAllPostUseCase>(
  (ref) => GetAllPostUseCase(
    ref.watch(confirmPostRepositoryProvider),
  ),
);

class GetAllPostUseCase {
  GetAllPostUseCase(this._repository);

  final ConfirmPostRepository _repository;

  EitherFuture<List<ConfirmPostEntity>> call() async {
    // return await _repository.getAllConfirmPosts();
    throw UnimplementedError();
  }
}
