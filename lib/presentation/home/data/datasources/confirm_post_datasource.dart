import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_model.dart';

abstract class ConfirmPostDatasource {
  EitherFuture<List<ConfirmPostModel>> getConfirmPostEntityList(
    int selectedIndex,
  );

  void getAllFanMarkedConfirmPosts() {}
}
