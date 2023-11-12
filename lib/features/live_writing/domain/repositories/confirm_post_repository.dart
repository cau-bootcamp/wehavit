import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/models.dart';

abstract class ConfirmPostRepository {
  EitherFuture<List<ConfirmPostModel>> getAllConfirmPosts();

  void getConfirmPostByUserId();

  void createConfirmPost();

  void updateConfirmPost();

  void deleteConfirmPost();
}
