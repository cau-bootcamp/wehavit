import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetGroupEntityByIdUsecase {
  GetGroupEntityByIdUsecase(
    this._groupRepository,
  );

  final GroupRepository _groupRepository;
  EitherFuture<GroupEntity> call({
    required String groupId,
  }) async {
    return _groupRepository.getGroupEntityById(groupId: groupId);
  }
}
