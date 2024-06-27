import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class EntranceView extends StatefulHookConsumerWidget {
  const EntranceView({super.key});

  static EntranceView builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const EntranceView();

  @override
  ConsumerState<EntranceView> createState() => _EntranceViewState();
}

class _EntranceViewState extends ConsumerState<EntranceView> {
  AutoEmojiFireworkView? fireworkWidget = const AutoEmojiFireworkView();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    unawaited(checkLoginState());
  }

  @override
  Widget build(BuildContext context) {
    // final textTheme = context.textTheme;
    // final emailTextFieldController = useTextEditingController();
    // final passwordTextFieldController = useTextEditingController();

    ref.listen(authProvider, (previous, next) {
      if (next.authResult == AuthResult.success) {
        context.go(RouteLocation.main);
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
          SafeArea(
            minimum: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Stack(
              children: [
                fireworkWidget ?? Container(),
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
                      onPressed: () async {
                        // view 이동하기
                        setState(() {
                          fireworkWidget = null;
                        });

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LogInView();
                            },
                          ),
                        ).whenComplete(() {
                          setState(() {
                            fireworkWidget = const AutoEmojiFireworkView();
                          });
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      User? user = _auth.currentUser;

      if (user != null) {
        setState(() {
          Navigator.pushReplacementNamed(context, '/main');
        });
      }
    }

    ref.invalidate(mainViewModelProvider);
    ref.invalidate(friendListViewModelProvider);
  }
}

class AutoEmojiFireworkView extends StatefulWidget {
  const AutoEmojiFireworkView({
    super.key,
  });

  @override
  State<AutoEmojiFireworkView> createState() => _AutoEmojiFireworkViewState();
}

class _AutoEmojiFireworkViewState extends State<AutoEmojiFireworkView> {
  EmojiFireWorkManager emojiFireWorkManager = EmojiFireWorkManager();
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        addRandomFireworkShoot();
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();

    addRandomFireworkShoot();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
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
