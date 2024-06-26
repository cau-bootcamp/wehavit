import 'dart:async';
import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyPageView extends ConsumerStatefulWidget {
  const MyPageView(this.index, this.tabController, {super.key});

  final int index;
  final TabController tabController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageView>
    with AutomaticKeepAliveClientMixin<MyPageView> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabChange);

    unawaited(ref.read(myPageViewModelProvider.notifier).loadData());
  }

  @override
  void dispose() {
    // 리스너 제거
    widget.tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (widget.tabController.index == widget.index) {
      // 탭바에서 화면이 MainView로 전환되면 setState를 호출
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = ref.watch(myPageViewModelProvider);
    final provider = ref.watch(myPageViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '내 정보',
        trailingTitle: '',
        trailingIcon: Icons.menu,
        trailingAction: () async {
          // 변경사항을 TabBar에 알리기 위해 mainViewState를 참조
          MainViewState? mainViewState =
              context.findAncestorStateOfType<MainViewState>();
          showMyPageMenuBottomSheet(context, mainViewState);
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            provider.loadData().whenComplete(() {
              setState(() {});
            });
          },
          child: ListView(
            padding: const EdgeInsets.only(bottom: 64.0),
            children: [
              // 내 프로필
              MyPageWehavitSummaryWidget(
                futureUserEntity: viewModel.futureMyUserDataEntity,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                '도전중인 목표',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              EitherFutureBuilder<List<ResolutionEntity>>(
                target: viewModel.futureMyyResolutionList,
                forWaiting: Container(),
                forFail: Container(),
                mainWidgetCallback: (resolutionList) {
                  return Visibility(
                    replacement: ResolutionListPlaceholderWidget(),
                    visible: resolutionList.isNotEmpty,
                    child: Column(
                      children: List<Widget>.generate(
                        resolutionList.length,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: CustomColors.whSemiBlack,
                              shadowColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              overlayColor: PointColors.colorList[
                                  resolutionList[index].colorIndex ?? 0],
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            onPressed: () {
                              showToastMessage(
                                context,
                                text: '현재 개발중인 기능입니다!',
                                icon: const Icon(
                                  Icons.warning,
                                  color: CustomColors.whYellow,
                                ),
                              );
                            },
                            child: ResolutionListCellWidget(
                              resolutionEntity: resolutionList[index],
                              showDetails: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showMyPageMenuBottomSheet(
    BuildContext context,
    MainViewState? mainViewState,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return GradientBottomSheet(
          Column(
            children: [
              WideColoredButton(
                buttonTitle: '내 정보 수정하기',
                buttonIcon: Icons.person,
                onPressed: () async {
                  final userEntity = await ref
                      .read(getMyUserDataUsecaseProvider)
                      .call()
                      .then((result) {
                    return result.fold((failure) {
                      return null;
                    }, (entity) {
                      return entity;
                    });
                  });
                  if (userEntity != null) {
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditUserDetailView(
                            isModifying: true,
                            uid: userEntity.userId,
                            profileImageUrl: userEntity.userImageUrl,
                            name: userEntity.userName,
                            handle: userEntity.handle,
                            aboutMe: userEntity.aboutMe,
                          );
                        },
                      ),
                    ).then((result) {
                      if (result == true) {
                        mainViewState?.loadUserData();

                        ref
                            .read(myPageViewModelProvider.notifier)
                            .getMyUserData()
                            .whenComplete(() {
                          setState(() {});
                        });
                      }

                      Navigator.pop(context);
                    });
                  }
                },
                // isDiminished: true,
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '로그아웃',
                buttonIcon: Icons.person_off_outlined,
                onPressed: () async {
                  await ref.read(logOutUseCaseProvider).call();
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/entrance');
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '회원탈퇴',
                buttonIcon: Icons.no_accounts_outlined,
                foregroundColor: PointColors.red,
                onPressed: () async {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text('정말 탈퇴하시겠어요?'),
                          content: const Text('작성하신 인증글의 복구가 불가능합니다'),
                          actions: [
                            CupertinoDialogAction(
                              textStyle: const TextStyle(
                                color: PointColors.blue,
                              ),
                              isDefaultAction: true,
                              child: const Text('취소'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              child: const Text('탈퇴하기'),
                              onPressed: () async {
                                final isAppleLogin = FirebaseAuth
                                    .instance.currentUser?.providerData
                                    .any(
                                  (info) => info.providerId == 'apple.com',
                                );
                                if (isAppleLogin == true) {
                                  try {
                                    final appleCredential =
                                        await SignInWithApple
                                            .getAppleIDCredential(
                                      scopes: [
                                        AppleIDAuthorizationScopes.email,
                                        AppleIDAuthorizationScopes.fullName,
                                      ],
                                    );

                                    final String privateKey = [
                                      dotenv.env['APPLE_PRIVATE_KEY_LINE1']!,
                                      dotenv.env['APPLE_PRIVATE_KEY_LINE2']!,
                                      dotenv.env['APPLE_PRIVATE_KEY_LINE3']!,
                                      dotenv.env['APPLE_PRIVATE_KEY_LINE4']!,
                                      dotenv.env['APPLE_PRIVATE_KEY_LINE5']!,
                                      dotenv.env['APPLE_PRIVATE_KEY_LINE6']!
                                    ].join('\n');

                                    const String teamId = 'JPL38XBHJ4';
                                    const String clientId =
                                        'com.bootcamp.wehavit';
                                    const String keyId = '67F4G5H6JW';
                                    // 'USER_ID_TOKEN_OR_REFRESH_TOKEN';
                                    final String authCode =
                                        appleCredential.authorizationCode!;

                                    final String clientSecret = createJwt(
                                      teamId: teamId,
                                      clientId: clientId,
                                      keyId: keyId,
                                      privateKey: privateKey,
                                    );

                                    final access_token =
                                        (await requestAppleTokens(
                                      authCode,
                                      clientSecret,
                                    ))['access_token'] as String;

                                    const String tokenTypeHint = 'access_token';
                                    await revokeAppleToken(
                                      clientId: clientId,
                                      clientSecret: clientSecret,
                                      token: access_token,
                                      tokenTypeHint: tokenTypeHint,
                                    ).then((_) => print("DEBUG : DONE"));
                                  } catch (e, stack) {
                                    print(stack);
                                    print("사용자 계정 삭제 중 오류 발생: $e");
                                  }
                                }

                                User? user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  await user.delete();
                                  print("사용자 계정이 성공적으로 삭제되었습니다.");
                                }

                                if (mounted) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/entrance',
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '돌아가기',
                backgroundColor: Colors.transparent,
                foregroundColor: CustomColors.whPlaceholderGrey,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// JWT 생성 함수
String createJwt({
  required String teamId,
  required String clientId,
  required String keyId,
  required String privateKey,
}) {
  final jwt = JWT(
    {
      'iss': teamId,
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp': (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600,
      'aud': 'https://appleid.apple.com',
      'sub': clientId,
    },
    header: {
      'kid': keyId,
      'alg': 'ES256',
    },
  );

  final key = ECPrivateKey(privateKey);
  return jwt.sign(key, algorithm: JWTAlgorithm.ES256);
}

// 사용자 토큰 취소 함수
Future<void> revokeAppleToken({
  required String clientId,
  required String clientSecret,
  required String token,
  required String tokenTypeHint,
}) async {
  final url = Uri.parse('https://appleid.apple.com/auth/revoke');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'client_id': clientId,
      'client_secret': clientSecret,
      'token': token,
      'token_type_hint': tokenTypeHint,
    },
  );

  if (response.statusCode == 200) {
    print('토큰이 성공적으로 취소되었습니다.');
  } else {
    print('토큰 취소 중 오류 발생: ${response.statusCode}');
  }
}

Future<Map<String, dynamic>> requestAppleTokens(
  String authorizationCode,
  String clientSecret,
) async {
  final response = await http.post(
    Uri.parse('https://appleid.apple.com/auth/token'),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'client_id': 'com.bootcamp.wehavit',
      'client_secret': clientSecret,
      'code': authorizationCode,
      'grant_type': 'authorization_code',
      'redirect_uri': 'YOUR_REDIRECT_URI', // 필요시 설정
    },
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    throw Exception('토큰 요청 실패: ${response.body}');
  }
}
