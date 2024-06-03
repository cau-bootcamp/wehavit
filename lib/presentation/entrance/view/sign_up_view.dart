import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';
import 'package:wehavit/presentation/main/main.dart';

class SignUpAuthDataView extends ConsumerStatefulWidget {
  const SignUpAuthDataView({super.key});

  @override
  ConsumerState<SignUpAuthDataView> createState() => _SignUpAuthDataViewState();
}

class _SignUpAuthDataViewState extends ConsumerState<SignUpAuthDataView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ref.watch(signUpAuthDataViewModelProvider).emailInputController.clear();
    ref.watch(signUpAuthDataViewModelProvider).passwordInputController.clear();
    ref
        .watch(signUpAuthDataViewModelProvider)
        .passwordValidatorInputController
        .clear();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(signUpAuthDataViewModelProvider);
    final provider = ref.read(signUpAuthDataViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '회원가입',
        leadingTitle: '',
        leadingIcon: Icons.chevron_left,
        leadingAction: () async {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '이메일',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  controller: viewmodel.emailInputController,
                  onChanged: (value) {
                    provider.checkEmailEntered();
                  },
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
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '비밀번호',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  controller: viewmodel.passwordInputController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9a-zA-Z!@#$%^&*(),.?":{}|<>]'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      provider.checkPasswordValidity();
                    });
                  },
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
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
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '6자리 이상의 알파벳, 숫자, 특수문자로 구성',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: viewmodel.isPasswordValid != null
                          ? (viewmodel.isPasswordValid!
                              ? PointColors.green
                              : PointColors.red)
                          : CustomColors.whPlaceholderGrey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '비밀번호 확인',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  controller: viewmodel.passwordValidatorInputController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  onChanged: (value) {
                    setState(() {
                      provider.matchPasswordAndValidator();
                    });
                  },
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '비밀번호 확인',
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
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    viewmodel.isPasswordMatched ? '일치합니다' : '비밀번호와 일치하지 않습니다',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: viewmodel.isPasswordMatched
                          ? PointColors.green
                          : PointColors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            WideColoredButton(
              isDiminished: !(viewmodel.isEmailEntered &
                      (viewmodel.isPasswordValid ?? false) &
                      viewmodel.isPasswordMatched) |
                  viewmodel.isProcessing,
              buttonTitle: viewmodel.isProcessing ? '처리 중' : '다음',
              backgroundColor: CustomColors.whYellow,
              foregroundColor: CustomColors.whBlack,
              onPressed: () async {
                setState(() {
                  viewmodel.isProcessing = true;
                });

                ref
                    .read(signUpWithEmailAndPasswordUsecaseProvider)
                    .call(
                      viewmodel.emailInputController.text,
                      viewmodel.passwordInputController.text,
                    )
                    .then((result) {
                  setState(() {
                    viewmodel.isProcessing = false;
                  });

                  return result.fold((failure) {
                    viewmodel.registerFailReason =
                        RegisterFailReasonConverter.fromExceptionCode(
                      failure.message,
                    );

                    String alertMessage;

                    switch (viewmodel.registerFailReason) {
                      case RegisterFailReason.emailFormatIsInvalid:
                        alertMessage = '이메일의 형식이 올바르지 않아요';
                      case RegisterFailReason.passwordIsWeak:
                        alertMessage = '비밀번호가 올바르지 않아요';
                      case RegisterFailReason.emailIsAlreadyTaken:
                        alertMessage = '이미 사용 중인 이메일이예요';
                      default:
                        alertMessage = '잠시 후 다시 시도해주세요';
                    }

                    showToastMessage(
                      context,
                      text: alertMessage,
                      icon: const Icon(
                        Icons.warning,
                        color: CustomColors.whYellow,
                      ),
                    );

                    return false;
                  }, (result) {
                    if (result == AuthResult.success) {
                      return true;
                    }

                    return false;
                  });
                }).then((canMoveToNextStep) {
                  if (canMoveToNextStep) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpUserDetailView();
                        },
                      ),
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpUserDetailView extends ConsumerStatefulWidget {
  const SignUpUserDetailView({super.key});

  @override
  ConsumerState<SignUpUserDetailView> createState() =>
      _SignUpUserDetailViewState();
}

class _SignUpUserDetailViewState extends ConsumerState<SignUpUserDetailView> {
  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(signUpUserDataViewModelProvider);
    final provider = ref.read(signUpUserDataViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '회원가입',
        leadingTitle: '',
        leadingIcon: Icons.chevron_left,
        leadingAction: () async {
          await provider.removeUserData();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                overlayColor: CustomColors.whYellow,
              ),
              onPressed: () async {
                provider.pickProfileImage().whenComplete(
                      () => setState(() {}),
                    );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 85,
                    height: 85,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColors.whGrey,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: viewmodel.profileImageFile != null
                        ? Image.file(
                            viewmodel.profileImageFile!,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -5,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.whWhite,
                      ),
                      child: const Icon(
                        Icons.photo_camera,
                        color: CustomColors.whBlack,
                        size: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '이름',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    provider.setName(value);
                    setState(() {});
                  },
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '친구들에게 보여지는 이름이예요',
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
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '사용자 ID',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    provider.setHandle(value);
                    setState(() {});
                  },
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9a-zA-Z!@#$%^&*(),.?":{}|<>]'),
                    ),
                  ],
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '친구가 나를 찾을 때 사용하는 ID예요',
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
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '한 줄 소개',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    provider.setAboutMe(value);
                    setState(() {});
                  },
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '나에 대해 소개해주세요',
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
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            WideColoredButton(
              onPressed: () async {
                setState(() {
                  viewmodel.isProcessing = true;
                });

                provider.registerUserData().then(
                      (result) => result.fold(
                        (failure) {
                          String toastMessage = '';
                          switch (failure.message) {
                            case 'handle-already-exist':
                              toastMessage = '이미 사용중인 ID예요';
                              break;
                            case 'no-image-file':
                              toastMessage = '프로필 이미지를 업로드해주세요';
                              break;
                            case 'no-handle':
                              toastMessage = '사용자 ID를 업로드해주세요';
                              break;
                            default:
                              toastMessage = '잠시 후 다시 시도해주세요';
                              break;
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
                        (success) async {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => const MainView(),
                            ),
                          );
                        },
                      ),
                    );
                setState(() {
                  viewmodel.isProcessing = false;
                });
              },
              isDiminished:
                  !((viewmodel.name.isNotEmpty & viewmodel.handle.isNotEmpty) &
                          (viewmodel.profileImageFile != null)) |
                      viewmodel.isProcessing,
              buttonTitle: viewmodel.isProcessing ? '처리 중' : '완료',
              backgroundColor: CustomColors.whYellow,
              foregroundColor: CustomColors.whBlack,
            ),
          ],
        ),
      ),
    );
  }
}
