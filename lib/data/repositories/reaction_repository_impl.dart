import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/repositories/reaction_repository.dart';

final reactionRepositoryProvider = Provider<ReactionRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return ReactionRepositoryImpl(wehavitDatasource);
});

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
  EitherFuture<List<ReactionEntity>> getUnreadReactionList() async {
    return _wehavitDatasource.getUnreadReactions();
  }
}
