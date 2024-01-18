import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class PostLateConfirmPostUsecase
    extends FutureUseCase<bool, ConfirmPostEntity> {
  PostLateConfirmPostUsecase(this._repository);

  final ConfirmPostRepository _repository;
  @override
  EitherFuture<bool> call(ConfirmPostEntity params) async {
    return await _repository.createConfirmPost(params);
  }
}
