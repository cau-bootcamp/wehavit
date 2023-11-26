import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/home/data/entities/confirm_post_entity.dart';

abstract class ConfirmPostDatasource {
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityList(
    int selectedIndex,
  );
}
