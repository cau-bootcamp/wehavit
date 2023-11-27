import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/live_writing/domain/repositories/confirm_post_repository.dart';

class PostLateConfirmPostUsecase extends UseCase<bool, ConfirmPostModel> {
  PostLateConfirmPostUsecase(this._repository);

  final ConfirmPostRepository _repository;
  @override
  EitherFuture<bool> call(ConfirmPostModel params) async {
    return await _repository.createConfirmPost(params);
  }
}
