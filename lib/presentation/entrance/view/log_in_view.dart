import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';
import 'package:wehavit/presentation/main/main.dart';

class LogInView extends ConsumerStatefulWidget {
  const LogInView({super.key});

  @override
  ConsumerState<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends ConsumerState<LogInView> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(logInViewModelProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        titleLabel: 'WeHavit',
        leadingIconString: WHIcons.back,
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '로그인',
                        style: context.titleSmall,
                      ),
                    ),
                    Container(
                      height: 16.0,
                    ),
                    InputFormField(
                      textEditingController: emailEditingController,
                      textInputType: TextInputType.emailAddress,
                      placeholder: '이메일',
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InputFormField(
                      textEditingController: passwordEditingController,
                      isObscure: true,
                      placeholder: '비밀번호',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                WideColoredButton(
                  onPressed: () async {
                    ref.read(logInViewModelProvider.notifier).setIsProcessing(true);
                    ref
                        .read(logInViewModelProvider.notifier)
                        .logInWithEmail(email: emailEditingController.text, password: passwordEditingController.text)
                        .then((result) {
                      result.fold(
                        (failure) {
                          String toastMessage = '';
                          switch (failure.message) {
                            case 'invalid-email':
                              toastMessage = '이메일의 형식이 올바르지 않아요';
                              break;
                            case 'user-disabled':
                              toastMessage = '비활성화된 계정이예요';
                              break;
                            case 'user-not-found':
                              toastMessage = '사용자 정보를 찾을 수 없어요';
                              break;
                            case 'wrong-password':
                              toastMessage = '이메일과 비밀번호를 잘못 입력했어요';
                              break;
                            case 'invalid-credential':
                              toastMessage = '이메일과 비밀번호를 잘못 입력했어요';
                              break;
                            default:
                              toastMessage = '잠시 후 다시 시도해주세요';
                          }
                          showToastMessage(
                            context,
                            text: toastMessage,
                          );
                        },
                        (success) => navigateToMainView(),
                      );
                    }).whenComplete(() {
                      ref.read(logInViewModelProvider.notifier).setIsProcessing(false);
                    });
                  },
                  buttonTitle: viewmodel.isProcessing ? '처리중' : '로그인하기',
                  isDiminished: viewmodel.isProcessing,
                  foregroundColor: CustomColors.whBlack,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpAuthDataView();
                              },
                            ),
                          ).whenComplete(() {
                            emailEditingController.clear();
                            passwordEditingController.clear();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '회원가입',
                            style: context.labelMedium?.copyWith(color: CustomColors.whGrey800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 160),
                child: Column(
                  children: [
                    Text(
                      '다른 방법으로 로그인',
                      style: context.bodyMedium?.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SNSLoginButton(
                          onPressed: () async {
                            await loginWithGoogle();
                          },
                          snsAuthType: SNSAuthType.google,
                        ),
                        const SizedBox(width: 16),
                        if (Platform.isIOS)
                          SNSLoginButton(
                            onPressed: () async {
                              loginWithApple();
                            },
                            snsAuthType: SNSAuthType.apple,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginWithGoogle() async {
    ref.read(logInViewModelProvider.notifier).setIsProcessing(true);

    await ref.read(logInViewModelProvider.notifier).logInWithGoogle().then((result) {
      return getUserIdFromAuthResult(
        result,
      );
    }).then((userInfo) {
      if (userInfo.$1 != null) {
        navigateBasedOnUserState(
          userInfo.$1!,
          userInfo.$2,
        );
      }
    });

    ref.read(logInViewModelProvider.notifier).setIsProcessing(false);
  }

  Future<void> loginWithApple() async {
    ref.read(logInViewModelProvider.notifier).setIsProcessing(true);

    await ref.read(logInViewModelProvider.notifier).logInWithApple().then((result) {
      return getUserIdFromAuthResult(
        result,
      );
    }).then((userInfo) {
      if (userInfo.$1 != null) {
        navigateBasedOnUserState(
          userInfo.$1!,
          userInfo.$2,
        );
      }
    });

    ref.read(logInViewModelProvider.notifier).setIsProcessing(false);
  }

  Future<(String?, String?)> getUserIdFromAuthResult(
    Either<Failure, (AuthResult, String?)> result,
  ) {
    return result.fold(
      (failure) {
        return Future(() => (null, null));
      },
      (authResult) async {
        if (authResult.$1 != AuthResult.success) {
          return Future(() => (null, null));
        }
        return ref.read(logInViewModelProvider.notifier).getMyUserId().then((result) {
          return result.fold(
            (failure) => (null, authResult.$2),
            (uid) => (uid, authResult.$2),
          );
        });
      },
    );
  }

  Future<void> navigateBasedOnUserState(
    String userId,
    String? userName,
  ) async {
    ref.read(logInViewModelProvider.notifier).getUserDataEntity(id: userId).then((result) {
      result.fold(
        // 기존에 사용자에 대한 데이터가 없는 경우에는
        // 회원가입으로 이동
        (failure) => navigateToSignUpUserDetailView(name: userName),
        // 데이터가 있으면
        // 메인으로 이동
        (userData) => navigateToMainView(),
      );
    });
  }

  Future<void> navigateToSignUpUserDetailView({
    String? name,
    String? profileImageUrl,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return EditUserDetailView(
            isModifying: false,
            name: name,
          );
        },
      ),
    );
  }

  Future<void> navigateToMainView() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return const MainView();
        },
      ),
    );
  }
}
