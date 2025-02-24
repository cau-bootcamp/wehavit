import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(
    this._googleLogInUseCase,
    this._emailAndPasswordRegisterUseCase,
    this._emailAndPasswordLogInUseCase,
    this._googleLogOut,
    this._logOut,
  ) : super(const AuthState.initial());
  final LogInWithGoogleUsecase _googleLogInUseCase;
  final SignUpWithEmailAndPasswordUsecase _emailAndPasswordRegisterUseCase;
  final LogInWithEmailUsecase _emailAndPasswordLogInUseCase;
  final GoogleLogOutUseCase _googleLogOut;
  final LogOutUsecase _logOut;

  EitherFuture<(String, String?)> googleLogIn() async {
    return _googleLogInUseCase();
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
      (result) {
        return state.copyWith(
          isLoading: false,
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
