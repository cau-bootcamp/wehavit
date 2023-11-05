import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/features.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static AuthScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const AuthScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;

    ref.listen(authProvider, (previous, next) {
      if (next.authResult == AuthResult.success) {
        context.go(RouteLocation.myPage);
      } else {
        context.go(RouteLocation.auth);
      }
    });

    return Scaffold(
      body: Padding(
        padding: Dimensions.kPaddingAllLarge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(appTitle).animate().fade(duration: 1500.ms).fadeIn(),
            Dimensions.kVerticalSpaceLarge,
            ElevatedButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).googleLogIn();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.google,
                    color: context.colorScheme.error,
                  ),
                  Dimensions.kHorizontalSpaceSmall,
                  Text(
                    'Log in with Google',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
