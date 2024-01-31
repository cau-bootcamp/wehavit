import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/group_announcement_entity/group_announcement_entity.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetGroupAnnouncementListUsecase {
  GetGroupAnnouncementListUsecase(
    this._groupRepository,
  );

  final GroupRepository _groupRepository;

  EitherFuture<List<GroupAnnouncementEntity>> call({
    required String groupId,
  }) {
    return _groupRepository.getGroupAnnouncementEntityList(groupId);
  }
}
