import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/features/swipe_view/data/datasource/reaction_datasource_provider.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';
import 'package:wehavit/features/swipe_view/domain/repository/swipe_view_repository.dart';

class SwipeViewRepositoryImpl implements SwipeViewRepository {
  SwipeViewRepositoryImpl(Ref ref) {
    _reactionDatasource = ref.watch(reactionDatasourceProvider);
  }

  late final ReactionDatasource _reactionDatasource;

  @override
  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionModel reactionModel,
  ) {
    return _reactionDatasource.sendReactionToTargetConfirmPost(
      targetConfirmPostId,
      reactionModel,
    );
    // TODO: implement addReactionToConfirmPost
  }
}
