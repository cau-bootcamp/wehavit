import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';
import 'package:wehavit/presentation/home/domain/models/confirm_post_model.dart';

abstract class ConfirmPostDatasource {
  EitherFuture<List<HomeConfirmPostModel>> getConfirmPostEntityList(
    int selectedIndex,
  );
}
