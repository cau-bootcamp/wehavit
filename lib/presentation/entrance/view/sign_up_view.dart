import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

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
    ref.watch(signUpAuthDataViewModelProvider).passwordValidatorInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(signUpAuthDataViewModelProvider);
    final provider = ref.read(signUpAuthDataViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        titleLabel: '회원가입',
        leadingIconString: WHIcons.back,
        leadingAction: () async {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SafeArea(
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
                      keyboardType: TextInputType.emailAddress,
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
                          RegExp(r'[0-9a-zA-Z!@#$%^&*(),.?":{}<>]'),
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
                              ? (viewmodel.isPasswordValid! ? CustomColors.pointGreen : CustomColors.pointRed)
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
                      child: Visibility(
                        visible: viewmodel.passwordValidatorInputController.text.isNotEmpty,
                        child: Text(
                          viewmodel.isPasswordMatched ? '일치합니다' : '비밀번호와 일치하지 않습니다',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: viewmodel.isPasswordMatched ? CustomColors.pointGreen : CustomColors.pointRed,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                WideColoredButton(
                  isDiminished:
                      !(viewmodel.isEmailEntered & (viewmodel.isPasswordValid ?? false) & viewmodel.isPasswordMatched) |
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
                        viewmodel.registerFailReason = RegisterFailReasonConverter.fromExceptionCode(
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
                              return const EditUserDetailView(
                                isModifying: false,
                              );
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
          Visibility(
            visible: viewmodel.isProcessing,
            child: Container(
              constraints: const BoxConstraints.expand(),
              alignment: Alignment.center,
              color: CustomColors.whDarkBlack.withAlpha(130),
              child: const CircularProgressIndicator(
                color: CustomColors.whYellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
