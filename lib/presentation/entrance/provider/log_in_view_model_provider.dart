import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class LogInViewModelProvider extends StateNotifier<LogInViewModel> {
  LogInViewModelProvider(
    this._logInWithEmailAndPasswordUsecase,
    this._logInWithAppleUsecase,
    this._logInWithGoogleUsecase,
    this._logOutUsecase,
    this._getMyUserIdUsecase,
    this._getUserDataFromIdUsecase,
  ) : super(LogInViewModel());

  final LogInWithEmailUsecase _logInWithEmailAndPasswordUsecase;
  final LogInWithAppleUsecase _logInWithAppleUsecase;
  final LogInWithGoogleUsecase _logInWithGoogleUsecase;
  final LogOutUsecase _logOutUsecase;
  final GetMyUserIdUsecase _getMyUserIdUsecase;
  final GetUserDataFromIdUsecase _getUserDataFromIdUsecase;

  EitherFuture<void> logInWithEmail() async {
    return _logInWithEmailAndPasswordUsecase.call(
      state.emailEditingController.text,
      state.passwordEditingController.text,
    );
  }

  EitherFuture<(AuthResult, String?)> logInWithApple() async {
    return _logInWithAppleUsecase();
  }

  EitherFuture<(AuthResult, String?)> logInWithGoogle() {
    return _logInWithGoogleUsecase();
  }

  Future<void> logOut() async {
    _logOutUsecase();
  }

  EitherFuture<String> getMyUserId() {
    return _getMyUserIdUsecase.call();
  }

  EitherFuture<UserDataEntity> getUserDataEntity({required String id}) {
    return _getUserDataFromIdUsecase.call(id);
  }

  void setIsProcessing(bool value) {
    state.isProcessing = value;
  }
}
