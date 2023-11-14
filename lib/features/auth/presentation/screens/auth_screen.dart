import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/features.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  static AuthScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const AuthScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final emailTextFieldController = useTextEditingController();
    final passwordTextFieldController = useTextEditingController();

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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                appTitle,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fade(duration: 1500.ms).fadeIn(),
              Dimensions.kVerticalSpaceLarge,
              AuthField(
                hintText: 'Username',
                controller: emailTextFieldController,
              ),
              Dimensions.kVerticalSpaceSmall,
              AuthField(
                hintText: 'Password',
                hasObscureText: true,
                controller: passwordTextFieldController,
              ),
              Dimensions.kVerticalSpaceSmall,
              LogInWithGoogleButton(textTheme: textTheme),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await ref
                          .read(emailAndPasswordAuthProvider)
                          .logInWithEmailAndPassword(
                            emailTextFieldController.text,
                            passwordTextFieldController.text,
                          );
                      result.isRight() ? debugPrint('Failed to login') : null;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.arrowRightToBracket,
                          color: context.colorScheme.error,
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        Text(
                          '로그인',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await ref
                          .read(emailAndPasswordAuthProvider)
                          .registerWithEmailAndPassword(
                            emailTextFieldController.text,
                            passwordTextFieldController.text,
                          );
                      result.isRight()
                          ? debugPrint('Failed to Register')
                          : null;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: context.colorScheme.error,
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        Text(
                          '회원가입',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LogInWithGoogleButton extends HookConsumerWidget {
  const LogInWithGoogleButton({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
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
    );
  }
}

class AuthField extends HookConsumerWidget {
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.hasObscureText = false,
  });

  final String hintText;
  final bool hasObscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      obscureText: hasObscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
