import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/update_FCM_token_usecase.dart';
import 'package:wehavit/presentation/main/main.dart';

class MainViewModelProvider extends StateNotifier<MainViewModel> {
  MainViewModelProvider(
    this._updateFCMTokenUsecase,
  ) : super(MainViewModel());

  final UpdateFCMTokenUsecase _updateFCMTokenUsecase;

  Future<void> updateFCMToken() async {
    _updateFCMTokenUsecase();
  }
}
