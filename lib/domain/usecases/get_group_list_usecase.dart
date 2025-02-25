import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class GetGroupListUsecase implements FutureUseCase<List<GroupEntity>, NoParams> {
  GetGroupListUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  @override
  EitherFuture<List<GroupEntity>> call(NoParams params) async {
    return _groupRepository.getGroupEntityList();
  }
}
