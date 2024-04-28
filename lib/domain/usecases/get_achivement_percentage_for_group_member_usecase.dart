import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class GetAchievementPercentageForGroupMemberUsecase {
  GetAchievementPercentageForGroupMemberUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  EitherFuture<double> call({
    required String groupId,
    required String userId,
  }) async {
    return _groupRepository.getAchievementPercentageForGroupMember(
      groupId: groupId,
      userId: userId,
    );
  }
}
