import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';
import 'package:wehavit/presentation/live_writing/data/repositories/confirm_post_repository_impl.dart';

final confirmPostRepositoryProvider = Provider<ConfirmPostRepository>((ref) {
  return ConfirmPostRepositoryImpl(ref);
});

abstract class ConfirmPostRepository {
  EitherFuture<List<HomeConfirmPostModel>> getConfirmPostModelList(
    int selectedIndex,
  );
}
