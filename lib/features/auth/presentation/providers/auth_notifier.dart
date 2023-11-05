import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/features/auth/auth.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(
    this._googleLogInUseCase,
    this._logOut,
  ) : super(const AuthState.initial());
  final GoogleLogInUseCase _googleLogInUseCase;
  final LogOutUseCase _logOut;

  Future<void> googleLogIn() async {
    state.copyWith(isLoading: true);
    final result = await _googleLogInUseCase(NoParams());
    // print('googleLogIn');
    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        authResult: AuthResult.failure,
      ),
      (authResult) {
        return state.copyWith(
          authResult: authResult,
          isLoading: false,
        );
      },
    );
  }

  Future<void> logOut() async {
    state.copyWith(isLoading: true);
    await _logOut().then((value) {
      state = state.copyWith(
        authResult: AuthResult.none,
        isLoading: false,
      );
    });
  }
}
