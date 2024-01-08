import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/repositories/reaction_repository.dart';
import 'package:wehavit/legacy/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/legacy/swipe_view/data/datasource/reaction_datasource_provider.dart';

class ReactionRepositoryImpl extends ReactionRepository {
  ReactionRepositoryImpl(Ref ref) {
    _reactionDatasource = ref.watch(reactionDatasourceProvider);
  }

  late final ReactionDatasource _reactionDatasource;

  @override
  EitherFuture<List<ReactionEntity>> getUnreadReactionFromLastConfirmPost() {
    return _reactionDatasource.getReactionUnreadFromLastConfirmPost();
  }

  @override
  EitherFuture<bool> addReactionToConfirmPost(
      String targetConfirmPostId, ReactionEntity reactionModel) {
    // TODO: implement addReactionToConfirmPost
    throw UnimplementedError();
  }
}
