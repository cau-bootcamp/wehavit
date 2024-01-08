import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/legacy/repository/swipe_view_repository.dart';
import 'package:wehavit/legacy/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/legacy/swipe_view/data/datasource/reaction_datasource_provider.dart';

class SwipeViewRepositoryImpl implements SwipeViewRepository {
  SwipeViewRepositoryImpl(Ref ref) {
    _reactionDatasource = ref.watch(reactionDatasourceProvider);
  }

  late final ReactionDatasource _reactionDatasource;

  @override
  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionModel,
  ) {
    return _reactionDatasource.sendReactionToTargetConfirmPost(
      targetConfirmPostId,
      reactionModel,
    );
    // TODO: implement addReactionToConfirmPost
  }
}
