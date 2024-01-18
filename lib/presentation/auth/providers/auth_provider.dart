import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/auth/auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final usecaseGoogleLogIn = ref.watch(googleLogInUseCaseProvider);
  final emailAndPasswordRegister =
      ref.watch(emailAndPasswordRegisterUseCaseProvider);
  final emailAndPasswordLogIn = ref.watch(emailAndPasswordLogInUseCaseProvider);
  final googleLogOut = ref.watch(googleLogOutUseCaseProvider);
  final usecaseLogOut = ref.watch(logOutUseCaseProvider);

  return AuthNotifier(
    usecaseGoogleLogIn,
    emailAndPasswordRegister,
    emailAndPasswordLogIn,
    googleLogOut,
    usecaseLogOut,
  );
});
