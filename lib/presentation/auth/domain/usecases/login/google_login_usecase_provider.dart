import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/auth/domain/domain.dart';

final googleLogInUseCaseProvider = Provider<GoogleLogInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoogleLogInUseCase(authRepository);
});
