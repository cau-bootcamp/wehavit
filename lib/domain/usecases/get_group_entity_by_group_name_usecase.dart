import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetGroupEntityByGroupNameUsecase {
  GetGroupEntityByGroupNameUsecase(
    this._groupRepository,
  );

  final GroupRepository _groupRepository;
  EitherFuture<GroupEntity> call({
    required String groupname,
  }) async {
    return _groupRepository.getGroupEntityByName(groupName: groupname);
  }
}
