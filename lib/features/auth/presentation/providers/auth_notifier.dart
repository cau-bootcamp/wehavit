import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/features/auth/auth.dart';
import 'package:wehavit/features/auth/domain/usecases/login/email_and_password_register_usecase.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(
    this._googleLogInUseCase,
    this._emailAndPasswordRegisterUseCase,
    this._emailAndPasswordLogInUseCase,
    this._googleLogOut,
    this._logOut,
  ) : super(const AuthState.initial());
  final GoogleLogInUseCase _googleLogInUseCase;
  final EmailAndPasswordRegisterUseCase _emailAndPasswordRegisterUseCase;
  final EmailAndPasswordLogInUseCase _emailAndPasswordLogInUseCase;
  final GoogleLogOutUseCase _googleLogOut;
  final LogOutUseCase _logOut;

  Future<void> googleLogIn() async {
    state.copyWith(isLoading: true);
    final result = await _googleLogInUseCase(NoParams());
    // print('googleLogIn');
    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        authResult: AuthResult.failure,
        authType: AuthType.google,
      ),
      (authResult) {
        return state.copyWith(
          isLoading: false,
          authResult: authResult,
          authType: AuthType.google,
        );
      },
    );
  }

  Future<void> emailAndPasswordRegister(String email, String password) async {
    state.copyWith(isLoading: true);
    final result = await _emailAndPasswordRegisterUseCase(email, password);
    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        authResult: AuthResult.failure,
        authType: AuthType.emailAndPassword,
      ),
      (authResult) {
        return state.copyWith(
          isLoading: false,
          authResult: authResult,
          authType: AuthType.emailAndPassword,
        );
      },
    );
  }

  Future<void> emailAndPasswordLogIn(String email, String password) async {
    state.copyWith(isLoading: true);
    final result = await _emailAndPasswordLogInUseCase(email, password);
    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        authResult: AuthResult.failure,
        authType: AuthType.emailAndPassword,
      ),
      (authResult) {
        return state.copyWith(
          isLoading: false,
          authResult: authResult,
          authType: AuthType.emailAndPassword,
        );
      },
    );
  }

  Future<void> logOut() async {
    state.copyWith(isLoading: true);
    if (state.authType == AuthType.emailAndPassword) {
      await _logOut().then((value) {
        state = state.copyWith(
          authResult: AuthResult.none,
          authType: AuthType.none,
          isLoading: false,
        );
      });
    } else if (state.authType == AuthType.google) {
      await _googleLogOut().then((value) {
        state = state.copyWith(
          authResult: AuthResult.none,
          authType: AuthType.none,
          isLoading: false,
        );
      });
    }
  }
}
