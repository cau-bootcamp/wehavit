import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/auth/auth.dart';
import 'package:wehavit/presentation/auth/domain/usecases/login/email_and_password_register_usecase.dart';

final emailAndPasswordRegisterUseCaseProvider =
    Provider<EmailAndPasswordRegisterUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailAndPasswordRegisterUseCase(authRepository);
});
