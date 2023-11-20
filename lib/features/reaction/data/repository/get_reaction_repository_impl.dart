import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/reaction/domain/repository/get_reaction_repository.dart';
import 'package:wehavit/features/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/features/swipe_view/data/datasource/reaction_datasource_provider.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

class ConfirmPostReactionRepositoryImpl extends ConfirmPostReactionRepository {
  ConfirmPostReactionRepositoryImpl(Ref ref) {
    _reactionDatasource = ref.watch(reactionDatasourceProvider);
  }

  late final ReactionDatasource _reactionDatasource;

  @override
  EitherFuture<List<ReactionModel>> getReactionUnreadFromLastConfirmPost() {
    return _reactionDatasource.getReactionUnreadFromLastConfirmPost();
  }
}
