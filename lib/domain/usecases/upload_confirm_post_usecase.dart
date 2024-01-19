import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadConfirmPostUseCase {
  UploadConfirmPostUseCase(this._repository);

  final ConfirmPostRepository _repository;

  EitherFuture<bool> call(ConfirmPostEntity confirmPost) async {
    return await _repository.createConfirmPost(confirmPost);
  }
}
