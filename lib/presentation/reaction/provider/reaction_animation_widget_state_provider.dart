import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

class ReactionAnimationWidgetManager extends StateNotifier<void> {
  ReactionAnimationWidgetManager(Ref ref) : super([]) {
    getUnreadReactionListUsecase = ref.watch(getUnreadReactionListUsecaseProvider);
  }

  late GetUnreadReactionListUsecase getUnreadReactionListUsecase;

  Future<List<ReactionGroupModel>> getUnreadReactionGroupList() async {
    final fetchResult = await getUnreadReactionListUsecase(
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

    final complimenterList = reactionModelList.map((e) => e.complimenterUid).toSet().toList();

    final reactionGroupModelList = complimenterList
        .map(
          (complimenterUid) => ReactionGroupModel(complimenterUid: complimenterUid),
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
        case ReactionType.quickShot:
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
