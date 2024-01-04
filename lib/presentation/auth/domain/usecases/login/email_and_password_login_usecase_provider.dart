import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/auth/auth.dart';

final emailAndPasswordLogInUseCaseProvider =
    Provider<EmailAndPasswordLogInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailAndPasswordLogInUseCase(authRepository);
});
