import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/repositories/auth_repository_impl.dart';
import 'package:wehavit/domain/usecases/logout/logout_usecase.dart';

final logOutUseCaseProvider = Provider<LogOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogOutUseCase(authRepository);
});

final googleLogOutUseCaseProvider = Provider<GoogleLogOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoogleLogOutUseCase(authRepository);
});
