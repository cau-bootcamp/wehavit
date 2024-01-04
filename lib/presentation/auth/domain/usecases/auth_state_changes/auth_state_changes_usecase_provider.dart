import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/auth/domain/domain.dart';

final authStateChangesUseCaseProvider = Provider<AuthStateChangesUseCase>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthStateChangesUseCase(authRepository);
  },
);
