import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/login/email_and_password_login_usecase_provider.dart';
import 'package:wehavit/domain/usecases/login/email_and_password_register_usecase_provider.dart';
import 'package:wehavit/domain/usecases/login/google_login_usecase_provider.dart';
import 'package:wehavit/domain/usecases/logout/logout_usecase_provider.dart';
import 'package:wehavit/presentation/auth/presentation.dart';

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
