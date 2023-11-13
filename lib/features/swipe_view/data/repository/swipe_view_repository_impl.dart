import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/features/swipe_view/data/datasource/reaction_datasource_provider.dart';
import 'package:wehavit/features/swipe_view/data/datasource/swipe_view_datasource.dart';
import 'package:wehavit/features/swipe_view/data/datasource/swipe_view_datasource_provider.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';
import 'package:wehavit/features/swipe_view/domain/repository/swipe_view_repository.dart';

class SwipeViewRepositoryImpl implements SwipeViewRepository {
  SwipeViewRepositoryImpl(Ref ref) {
    _reactionDatasource = ref.watch(reactionDatasourceProvider);
  }

  late final SwipeViewDatasource _swipeViewDatasource;
  late final ReactionDatasource _reactionDatasource;

  @override
  EitherFuture<List<ConfirmPostModel>> getLiveWrittenConformPostList() async {
    // TODO: implement getLiveWrittenConformPostList
    final fetchResult =
        await _swipeViewDatasource.fetchLiveWrittenConfirmPostList();
    if (fetchResult.isRight()) {
      return Future(
        () => right(fetchResult.getRight() as List<ConfirmPostModel>),
      );
    } else {
      return Future(() => left(fetchResult.getRight() as Failure));
    }
  }

  @override
  EitherFuture<List<ConfirmPostModel>> getTodayConfrmPostList() async {
    return _swipeViewDatasource.fetchTodayConfirmPostList();
  }

  @override
  EitherFuture<bool> addReactionToConfirmPost(
      String targetConfirmPostId, ReactionModel reactionModel) {
    return _reactionDatasource.sendReactionToTargetConfirmPost(
      targetConfirmPostId,
      reactionModel,
    );
    // TODO: implement addReactionToConfirmPost
  }
}
