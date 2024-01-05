import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/repositories/get_reaction_repository.dart';
import 'package:wehavit/presentation/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/presentation/swipe_view/data/datasource/reaction_datasource_provider.dart';

class ConfirmPostReactionRepositoryImpl extends ConfirmPostReactionRepository {
  ConfirmPostReactionRepositoryImpl(Ref ref) {
    _reactionDatasource = ref.watch(reactionDatasourceProvider);
  }

  late final ReactionDatasource _reactionDatasource;

  @override
  EitherFuture<List<ReactionEntity>> getReactionUnreadFromLastConfirmPost() {
    return _reactionDatasource.getReactionUnreadFromLastConfirmPost();
  }
}
