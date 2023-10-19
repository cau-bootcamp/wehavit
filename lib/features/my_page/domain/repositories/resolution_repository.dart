import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/my_page/domain/models/add_resolution_model.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionModel>> getActiveResolutionModelList();
  EitherFuture<bool> uploadResolutionModel(AddResolutionModel model);
}
