import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/features/auth/data/entities/auth_result.dart';
import 'package:wehavit/features/auth/presentation/providers/auth_provider.dart';
import 'package:wehavit/features/auth/presentation/screens/auth_screen.dart';
import 'package:wehavit/features/home/presentation/screens/home_screen.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   static SplashScreen builder(
//     BuildContext context,
//     GoRouterState state,
//   ) =>
//       const SplashScreen();
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'Splash Screen',
//         ),
//       ),
//     );
//   }
// }

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static SplashScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const SplashScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    if (auth.authResult == AuthResult.none ||
        auth.authResult == AuthResult.failure) {
      return const AuthScreen();
    } else if (auth.authResult == AuthResult.success) {
      return const HomeScreen();
    } else {
      return const Scaffold(
        body: Center(
          child: Text(
            'Splash Screen',
          ),
        ),
      );
    }
  }
}
