import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';

abstract class ConfirmPostRepository {
  EitherFuture<List<HomeConfirmPostModel>> getConfirmPostModelList(
    int selectedIndex,
  );
}
