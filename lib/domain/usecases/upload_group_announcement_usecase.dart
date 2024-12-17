import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/group_announcement_entity/group_announcement_entity.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadGroupAnnouncementUsecase {
  UploadGroupAnnouncementUsecase(
    this._groupRepository,
    this._userModelRepository,
  );

  final GroupRepository _groupRepository;
  final UserModelRepository _userModelRepository;

  EitherFuture<void> call({
    required String groupId,
    required String title,
    required String content,
  }) async {
    final uid = await _userModelRepository.getMyUserId().then((value) => value.fold((l) => null, (uid) => uid));

    if (uid == null) {
      return Future(() => left(const Failure('cannot get uid')));
    }

    GroupAnnouncementEntity entity = GroupAnnouncementEntity(
      groupId: groupId,
      writerUid: uid,
      title: title,
      content: content,
      createdAt: DateTime.now(),
      readByUidList: [],
      groupAnnouncementId: '',
    );

    return _groupRepository.uploadGroupAnnouncementEntity(entity);
  }
}
