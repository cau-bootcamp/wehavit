import 'package:fpdart/src/either.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

class ResolutionRepositoryImpl implements ResolutionRepository {
  @override
  Future<Either<Failure, List<ResolutionModel>>> getResolutionModelList() {
    // TODO: implement getResolutionModelList
    throw UnimplementedError();
  }
}
