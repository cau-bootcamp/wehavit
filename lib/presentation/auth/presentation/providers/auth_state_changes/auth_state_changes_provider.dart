import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/auth/auth.dart';

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final authStateChanges = AuthStateChangesUseCase(repository);
  return authStateChanges();
});
