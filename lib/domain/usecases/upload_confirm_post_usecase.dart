import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/repositories/repositories.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final uploadConfirmPostUseCaseProvider = Provider<UploadConfirmPostUseCase>(
  (ref) => UploadConfirmPostUseCase(
    ref.watch(confirmPostRepositoryProvider),
  ),
);

class UploadConfirmPostUseCase {
  UploadConfirmPostUseCase(this._repository);

  final ConfirmPostRepository _repository;

  EitherFuture<bool> call(ConfirmPostEntity confirmPost) async {
    return await _repository.createConfirmPost(confirmPost);
  }
}
