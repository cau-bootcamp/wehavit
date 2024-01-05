import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';

final createConfirmPostUseCaseProvider = Provider<CreateConfirmPostUseCase>(
  (ref) => CreateConfirmPostUseCase(
    ref.watch(confirmPostRepositoryProvider),
  ),
);

class CreateConfirmPostUseCase {
  CreateConfirmPostUseCase(this._repository);

  final ConfirmPostRepository _repository;

  EitherFuture<bool> call(ConfirmPostEntity confirmPost) async {
    return await _repository.createConfirmPost(confirmPost);
  }
}
