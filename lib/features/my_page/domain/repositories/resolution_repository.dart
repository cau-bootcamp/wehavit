import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

abstract class ResolutionRepository {
  Future<Either<Failure, List<ResolutionModel>>> getActiveResolutionModelList();
}
