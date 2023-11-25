import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/home/data/entities/confirm_post_entity.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';

abstract class ConfirmPostDatasource {
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityList();
}
