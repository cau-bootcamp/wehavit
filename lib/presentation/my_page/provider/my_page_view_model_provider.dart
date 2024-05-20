import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/my_page/model/model.dart';

class MyPageViewModelProvider extends StateNotifier<MyPageViewModel> {
  MyPageViewModelProvider(
    this.getMyResolutionListUsecase,
    this.getMyUserDataUsecase,
  ) : super(MyPageViewModel());

  final GetMyResolutionListUsecase getMyResolutionListUsecase;
  final GetMyUserDataUsecase getMyUserDataUsecase;

  Future<void> loadData() async {
    state.futureMyyResolutionList = getMyResolutionListUsecase();
    state.futureMyUserDataEntity = getMyUserDataUsecase();
  }
}
