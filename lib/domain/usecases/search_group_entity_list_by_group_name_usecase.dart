import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class SearchGroupEntityListByGroupNameUsecase {
  SearchGroupEntityListByGroupNameUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  EitherFuture<List<EitherFuture<GroupEntity>>> call({
    required String searchKeyword,
  }) async {
    return _groupRepository.getGroupEntityListByGroupName(
      keyword: searchKeyword,
    );
  }
}
