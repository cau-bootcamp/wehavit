import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/my_page/model/model.dart';

class MyPageViewModelProvider extends StateNotifier<MyPageViewModel> {
  MyPageViewModelProvider(
    this.getMyResolutionListUsecase,
    this.getMyUserDataUsecase,
    this.revokeAppleSignInUsecase,
  ) : super(MyPageViewModel());

  final GetMyResolutionListUsecase getMyResolutionListUsecase;
  final GetMyUserDataUsecase getMyUserDataUsecase;
  final RevokeAppleSignInUsecase revokeAppleSignInUsecase;

  Future<void> loadData() async {
    getResolutionList();
    getMyUserData();
  }

  Future<void> getResolutionList() async {
    state.futureMyyResolutionList = getMyResolutionListUsecase();
  }

  Future<void> getMyUserData() async {
    state.futureMyUserDataEntity = getMyUserDataUsecase();
  }

  Future<bool> revokeAppleSignIn() async {
    return await revokeAppleSignInUsecase.call().then(
          (result) => result.fold(
            (failure) => false,
            (success) => true,
          ),
        );
  }
}
