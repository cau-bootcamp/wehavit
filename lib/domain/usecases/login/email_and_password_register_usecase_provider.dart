import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/repositories/repositories.dart';
import 'package:wehavit/domain/usecases/login/email_and_password_register_usecase.dart';

final emailAndPasswordRegisterUseCaseProvider =
    Provider<EmailAndPasswordRegisterUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailAndPasswordRegisterUseCase(authRepository);
});
