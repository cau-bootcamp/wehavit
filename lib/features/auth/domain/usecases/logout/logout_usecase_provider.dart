import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/auth/domain/domain.dart';

final logOutUseCaseProvider = Provider<LogOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogOutUseCase(authRepository);
});

final googleLogOutUseCaseProvider = Provider<GoogleLogOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoogleLogOutUseCase(authRepository);
});
