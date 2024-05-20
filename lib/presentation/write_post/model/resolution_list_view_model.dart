import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ResolutionListViewModel {
  List<ResolutionListCellWidgetModel>? resolutionModelList;
  EitherFuture<int>? futureDoneCount;
  EitherFuture<int>? futureDoneRatio;
}
