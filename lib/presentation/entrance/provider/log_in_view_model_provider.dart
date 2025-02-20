import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

final logInViewModelProvider = StateNotifierProvider.autoDispose<LogInViewModelProvider, LogInViewModel>((ref) {
  return LogInViewModelProvider(
    ref,
  );
});

class LogInViewModelProvider extends StateNotifier<LogInViewModel> {
  LogInViewModelProvider(
    this.ref,
  ) : super(LogInViewModel());

  final Ref ref;

  EitherFuture<void> logInWithEmail() async {
    return ref.read(logInWithEmailAndPasswordUsecaseProvider).call(
          state.emailEditingController.text,
          state.passwordEditingController.text,
        );
  }

  EitherFuture<(AuthResult, String?)> logInWithApple() async {
    return ref.read(logInWithAppleUsecaseProvider)();
  }

  EitherFuture<(AuthResult, String?)> logInWithGoogle() {
    return ref.read(logInWithGoogleUsecaseProvider)();
  }

  Future<void> logOut() async {
    return ref.read(logOutUseCaseProvider);
  }

  EitherFuture<String> getMyUserId() {
    return ref.read(getMyUserIdUsecaseProvider)();
  }

  EitherFuture<UserDataEntity> getUserDataEntity({required String id}) {
    return ref.read(getUserDataFromIdUsecaseProvider).call(id);
  }

  void setIsProcessing(bool value) {
    state.isProcessing = value;
    ref.notifyListeners();
  }
}
