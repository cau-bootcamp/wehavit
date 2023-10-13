import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/auth/auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final usecaseLogIn = ref.watch(googleLogInUseCaseProvider);
  final usecaseLogOut = ref.watch(logOutUseCaseProvider);

  return AuthNotifier(usecaseLogIn, usecaseLogOut);
});
