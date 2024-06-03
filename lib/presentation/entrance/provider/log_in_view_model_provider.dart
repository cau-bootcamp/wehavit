import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class LogInViewModelProvider extends StateNotifier<LogInViewModel> {
  LogInViewModelProvider(this._logInWithEmailAndPasswordUsecase)
      : super(LogInViewModel());

  final LogInWithEmailAndPasswordUsecase _logInWithEmailAndPasswordUsecase;

  EitherFuture<void> logIn() async {
    return _logInWithEmailAndPasswordUsecase.call(
      state.emailEditingController.text,
      state.passwordEditingController.text,
    );
  }
}
