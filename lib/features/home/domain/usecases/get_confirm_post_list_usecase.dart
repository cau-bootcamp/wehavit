import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/home/domain/repositories/confirm_post_repository.dart';

class GetConfirmPostListUsecase
    implements UseCase<List<ConfirmPostModel>?, NoParams> {
  GetConfirmPostListUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  @override
  Future<Either<Failure, List<ConfirmPostModel>>> call(NoParams params) async {
    return _confirmPostRepository.getConfirmPostModelList();
  }
}
