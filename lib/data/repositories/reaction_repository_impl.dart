import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class ReactionRepositoryImpl implements ReactionRepository {
  ReactionRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionEntity,
  ) {
    return _wehavitDatasource.sendReactionToTargetConfirmPost(
      targetConfirmPostId,
      reactionEntity,
    );
  }

  @override
  EitherFuture<List<ReactionEntity>> getUnreadReactionListAndDelete() async {
    return _wehavitDatasource.getUnreadReactionsAndDelete();
  }

  @override
  EitherFuture<List<ReactionEntity>> getReactionListFromConfirmPost({
    required ConfirmPostEntity entity,
  }) {
    return _wehavitDatasource.getReactionsFromConfirmPost(entity);
  }
}
