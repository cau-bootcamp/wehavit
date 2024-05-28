import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/effects/effects.dart';

class AuthenticationView extends HookConsumerWidget {
  const AuthenticationView({super.key});

  static AuthenticationView builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const AuthenticationView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    // final emailTextFieldController = useTextEditingController();
    // final passwordTextFieldController = useTextEditingController();

    ref.listen(authProvider, (previous, next) {
      if (next.authResult == AuthResult.success) {
        context.go(RouteLocation.myPage);
      } else {
        context.go(RouteLocation.auth);
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            child: const Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/logo/login_background.png'),
            ),
          ),
          Padding(
            padding: Dimensions.kPaddingAllLarge,
            child: SafeArea(
              child: Stack(
                children: [
                  const AutoEmojiFireworkView(),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 100.0,
                        left: 40,
                        right: 40,
                      ),
                      child: Image(
                        image: AssetImage(
                          'assets/logo/wehavit_text_image.png',
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WideColoredButton(
                        buttonTitle: '시작하기',
                        foregroundColor: CustomColors.whBlack,
                        backgroundColor: CustomColors.whYellow,
                        onPressed: () {
                          // view 이동하기
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailRegisterButton extends HookConsumerWidget {
  const EmailRegisterButton({
    super.key,
    required this.emailTextFieldController,
    required this.passwordTextFieldController,
    required this.textTheme,
  });

  final TextEditingController emailTextFieldController;
  final TextEditingController passwordTextFieldController;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.whSemiWhite,
      ),
      onPressed: () async {
        await ref.read(authProvider.notifier).emailAndPasswordRegister(
              emailTextFieldController.text,
              passwordTextFieldController.text,
            );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            Icons.app_registration,
            color: context.colorScheme.error,
          ),
          Dimensions.kHorizontalSpaceSmall,
          Text(
            '회원가입',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class EmailLogInButton extends HookConsumerWidget {
  const EmailLogInButton({
    super.key,
    required this.emailTextFieldController,
    required this.passwordTextFieldController,
    required this.textTheme,
  });

  final TextEditingController emailTextFieldController;
  final TextEditingController passwordTextFieldController;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.whYellow,
      ),
      onPressed: () async {
        await ref.read(authProvider.notifier).emailAndPasswordLogIn(
              emailTextFieldController.text,
              passwordTextFieldController.text,
            );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            Icons.login,
            color: context.colorScheme.error,
          ),
          Dimensions.kHorizontalSpaceSmall,
          Text(
            '로그인',
            style: textTheme.bodyMedium,
          ),
        ],
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
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.whSemiWhite,
      ),
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
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: CustomColors.whWhite,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: CustomColors.whGrey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors.whYellow,
            width: 3.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors.whWhite,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}

class AutoEmojiFireworkView extends ConsumerStatefulWidget {
  const AutoEmojiFireworkView({super.key});

  @override
  ConsumerState<AutoEmojiFireworkView> createState() =>
      _AutoEmojiFireworkViewState();
}

class _AutoEmojiFireworkViewState extends ConsumerState<AutoEmojiFireworkView> {
  EmojiFireWorkManager emojiFireWorkManager = EmojiFireWorkManager();

  @override
  void initState() {
    super.initState();

    addRandomFireworkShoot();

    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        addRandomFireworkShoot();
      });
    });
  }

  void addRandomFireworkShoot() {
    List<int> emojiCountList = List.generate(
      Emojis.emojiList.length,
      (index) => 0,
    );

    for (int i = 0; i < 3; i++) {
      int randomIndex = Random().nextInt(Emojis.emojiList.length);
      emojiCountList[randomIndex] += 3;
    }

    emojiFireWorkManager.addFireworkWidget(
      offset: Offset(
        50 + Random().nextDouble() * 200,
        250 + Random().nextDouble() * 200,
      ),
      emojiReactionCountList: emojiCountList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 100,
            child: Container(
              color: Colors.black26,
            ),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IgnorePointer(
                  child: Stack(
                    children:
                        emojiFireWorkManager.fireworkWidgets.values.toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
