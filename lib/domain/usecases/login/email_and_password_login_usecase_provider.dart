import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/repositories/repositories.dart';
import 'package:wehavit/domain/usecases/login/email_and_password_login_usecase.dart';

final emailAndPasswordLogInUseCaseProvider =
    Provider<EmailAndPasswordLogInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailAndPasswordLogInUseCase(authRepository);
});
