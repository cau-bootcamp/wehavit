import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/reaction_model.dart';
import 'package:wehavit/domain/repositories/swipe_view_repository.dart';
import 'package:wehavit/presentation/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/presentation/swipe_view/data/datasource/reaction_datasource_provider.dart';

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
