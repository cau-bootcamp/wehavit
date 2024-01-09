import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/repositories/auth_repository_impl.dart';
import 'package:wehavit/domain/usecases/auth_state_changes/auth_state_changes_usecase.dart';

final authStateChangesUseCaseProvider = Provider<AuthStateChangesUseCase>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthStateChangesUseCase(authRepository);
  },
);
