import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/usecases/get_unread_reaction_from_last_confirm_post_usecase.dart';

final reactionAnimationWidgetManagerProvider =
    StateNotifierProvider<ReactionAnimationWidgetManager, void>((ref) {
  return ReactionAnimationWidgetManager(ref);
});

class ReactionAnimationWidgetManager extends StateNotifier<void> {
  ReactionAnimationWidgetManager(Ref ref) : super([]) {
    _getReactionUnreadFromLastConfirmPostUsecase =
        ref.watch(getUnreadReactionListFromLastConfirmPostUsecaseProvider);
  }

  late GetUnreadReactionListFromLastConfirmPostUsecase
      _getReactionUnreadFromLastConfirmPostUsecase;

  Future<List<ReactionGroupModel>>
      getUnreadReactionModelGroupListFromLastConfirmPost() async {
    final fetchResult = await _getReactionUnreadFromLastConfirmPostUsecase(
      NoParams(),
    );

    final reactionModelList = fetchResult.fold(
      (failure) {
        return [];
      },
      (result) {
        result.sort((a, b) => a.complimenterUid.compareTo(b.complimenterUid));
        return result;
      },
    );

    final complimenterList =
        reactionModelList.map((e) => e.complimenterUid).toSet().toList();

    final reactionGroupModelList = complimenterList
        .map(
          (complimenterUid) =>
              ReactionGroupModel(complimenterUid: complimenterUid),
        )
        .toList();

    reactionModelList.map((reaction) {
      final index = reactionGroupModelList.indexWhere(
        (modelGroup) => modelGroup.complimenterUid == reaction.complimenterUid,
      );
      switch (ReactionType.values[reaction.reactionType]) {
        case ReactionType.comment:
          reactionGroupModelList[index].textReactionModel = reaction;
          break;
        case ReactionType.emoji:
          if (reactionGroupModelList[index].emojiReacionModelList == null) {
            reactionGroupModelList[index].emojiReacionModelList = [];
          }
          reactionGroupModelList[index].emojiReacionModelList!.add(reaction);
          break;
        case ReactionType.instantPhoto:
          reactionGroupModelList[index].imageReacionModel = reaction;
          break;
      }
    }).toList();

    return Future(() => reactionGroupModelList);
  }
}

class ReactionGroupModel {
  ReactionGroupModel({
    required this.complimenterUid,
  });

  String complimenterUid;
  List<ReactionEntity>? emojiReacionModelList;
  ReactionEntity? imageReacionModel;
  ReactionEntity? textReactionModel;
}
