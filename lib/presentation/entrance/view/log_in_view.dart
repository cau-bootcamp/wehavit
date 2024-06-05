// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/data/repository_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/entrance/auth.dart';
import 'package:wehavit/presentation/main/view/main_view.dart';

class LogInView extends ConsumerStatefulWidget {
  const LogInView({super.key});

  @override
  ConsumerState<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends ConsumerState<LogInView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ref.watch(logInViewModelProvider).emailEditingController.clear();
    ref.watch(logInViewModelProvider).passwordEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(logInViewModelProvider);
    final provider = ref.read(logInViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: 'WeHavit',
        leadingTitle: '',
        leadingIcon: Icons.chevron_left,
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
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.whWhite,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: viewmodel.emailEditingController,
                      cursorColor: CustomColors.whWhite,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        color: CustomColors.whWhite,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        hintText: '이메일',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: CustomColors.whPlaceholderGrey,
                        ),
                        filled: true,
                        fillColor: CustomColors.whGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      controller: viewmodel.passwordEditingController,
                      cursorColor: CustomColors.whWhite,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        color: CustomColors.whWhite,
                        fontSize: 16.0,
                      ),
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: '비밀번호',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: CustomColors.whPlaceholderGrey,
                        ),
                        filled: true,
                        fillColor: CustomColors.whGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                WideColoredButton(
                  onPressed: () async {
                    provider.logIn().then((result) {
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
                              toastMessage = '비밀번호를 잘못 입력했어요';
                              break;
                            case 'invalid-credential':
                              toastMessage = '비밀번호를 잘못 입력했어요';
                              break;
                            default:
                              toastMessage = '잠시 후 다시 시도해주세요';
                          }
                          showToastMessage(
                            context,
                            text: toastMessage,
                            icon: const Icon(
                              Icons.not_interested,
                              color: PointColors.red,
                            ),
                          );
                        },
                        (success) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return const MainView();
                            },
                          ),
                        ),
                      );
                    });
                  },
                  buttonTitle: '로그인하기',
                  backgroundColor: CustomColors.whYellow,
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
                            viewmodel.emailEditingController.clear();
                            viewmodel.passwordEditingController.clear();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '회원가입',
                            style: TextStyle(
                              color: CustomColors.whWhite,
                            ),
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
                    const Text(
                      '다른 방법으로 로그인',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whWhite,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.whDarkBlack,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              ref.read(authRepositoryProvider).logOut();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.all(0),
                            ),
                            child: Image.asset(
                              CustomIconImage.kakaoLogInLogoIcon,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.whDarkBlack,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.all(0),
                            ),
                            onPressed: () async {
                              final String? userId = await ref
                                  .read(authProvider.notifier)
                                  .googleLogIn()
                                  .then((result) {
                                return result.fold(
                                  (failure) {
                                    return null;
                                  },
                                  (authResult) async {
                                    if (authResult == AuthResult.aborted) {
                                      return null;
                                    }

                                    return await ref
                                        .read(userModelRepositoryProvider)
                                        .getMyUserId()
                                        .then((result) {
                                      return result.fold(
                                        (failure) => null,
                                        (uid) => uid,
                                      );
                                    });
                                  },
                                );
                              });

                              if (userId != null) {
                                ref
                                    .read(userModelRepositoryProvider)
                                    .getUserDataEntityById(userId)
                                    .then((result) {
                                  result.fold(
                                    // 기존에 사용자에 대한 데이터가 없는 경우에는
                                    // 회원가입으로 이동
                                    (failure) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const SignUpUserDetailView();
                                        },
                                      ),
                                    ),
                                    // 사용자가 이미 가입을 했으면
                                    // 메인 뷰로 이동
                                    (userData) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) {
                                          return const MainView();
                                        },
                                      ),
                                    ),
                                  );
                                });
                              }
                            },
                            child: Image.asset(
                              CustomIconImage.googleLogInLogoIcon,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.whPlaceholderGrey,
                          ),
                          child: Image.asset(
                            CustomIconImage.appleLogInLogoIcon,
                          ),
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
}
