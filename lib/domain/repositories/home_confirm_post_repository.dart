import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_model.dart';
import 'package:wehavit/presentation/live_writing/data/repositories/confirm_post_repository_impl.dart';

final confirmPostRepositoryProvider =
    Provider<HomeConfirmPostRepository>((ref) {
  return ConfirmPostRepositoryImpl(ref);
});

abstract class HomeConfirmPostRepository {
  EitherFuture<List<HomeConfirmPostModel>> getConfirmPostModelList(
    int selectedIndex,
  );
}
