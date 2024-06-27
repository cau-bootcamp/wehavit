import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ResolutionListViewModel {
  ResolutionListViewModel({
    this.resolutionModelList,
    this.futureDoneCount,
    this.futureDoneRatio,
  });

  List<ResolutionListCellWidgetModel>? resolutionModelList;
  EitherFuture<int>? futureDoneCount;
  EitherFuture<int>? futureDoneRatio;

  bool isLoadingView = true;

  ResolutionListViewModel copyWith({
    List<ResolutionListCellWidgetModel>? newResolutionModelList,
  }) {
    return ResolutionListViewModel(
      resolutionModelList: newResolutionModelList,
      futureDoneCount: futureDoneCount,
      futureDoneRatio: futureDoneRatio,
    );
  }
}
