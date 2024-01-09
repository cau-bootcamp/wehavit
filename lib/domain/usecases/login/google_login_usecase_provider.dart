import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/repositories/auth_repository_impl.dart';
import 'package:wehavit/domain/usecases/login/google_login_usecase.dart';

final googleLogInUseCaseProvider = Provider<GoogleLogInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoogleLogInUseCase(authRepository);
});
