import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class SignUpAuthDataView extends ConsumerStatefulWidget {
  const SignUpAuthDataView({super.key});

  @override
  ConsumerState<SignUpAuthDataView> createState() => _SignUpAuthDataViewState();
}

class _SignUpAuthDataViewState extends ConsumerState<SignUpAuthDataView> {
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordValidatorInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailInputController.addListener(() {
      ref.read(signUpAuthDataViewModelProvider.notifier).setEmail(emailInputController.text);
    });
    passwordInputController.addListener(() {
      ref.read(signUpAuthDataViewModelProvider.notifier).setPassword(passwordInputController.text);
    });
    passwordValidatorInputController.addListener(() {
      ref.read(signUpAuthDataViewModelProvider.notifier).setPasswordValidator(passwordValidatorInputController.text);
    });

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
            child: Consumer(
              builder: (context, ref, child) {
                final viewmodel = ref.watch(signUpAuthDataViewModelProvider);

                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '이메일',
                          style: context.titleSmall,
                        ),
                        Container(height: 16.0),
                        InputFormField(
                          textEditingController: emailInputController,
                          textInputType: TextInputType.emailAddress,
                          placeholder: '이메일',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '비밀번호',
                          style: context.titleSmall,
                        ),
                        Container(height: 16.0),
                        InputFormField(
                          textEditingController: passwordInputController,
                          textInputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9a-zA-Z!@#$%^&*(),.?":{}|<>_]'),
                            ),
                          ],
                          descrptionHandler: (text) {
                            switch (text.length) {
                              case == 0:
                                return ('6자리 이상, 20자리 이하의 알파벳, 숫자, 특수문자로 구성', FormFieldDescriptionType.normal);
                              case >= 6 && <= 20:
                                return ('6자리 이상, 20자리 이하의 알파벳, 숫자, 특수문자로 구성', FormFieldDescriptionType.clear);
                              default:
                                return ('6자리 이상, 20자리 이하의 알파벳, 숫자, 특수문자로 구성', FormFieldDescriptionType.warning);
                            }
                          },
                          placeholder: '비밀번호',
                        ),
                        Container(height: 16.0),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '비밀번호 확인',
                          style: context.titleSmall,
                        ),
                        const SizedBox(height: 16),
                        InputFormField(
                          textEditingController: passwordValidatorInputController,
                          // TODO: 비밀번호와 일치함 메시지 보여주기
                          placeholder: '비밀번호 확인',
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    WideColoredButton(
                      isDiminished:
                          !(viewmodel.isEmailValid & (viewmodel.isPasswordValid) & viewmodel.isValidatorValid) |
                              viewmodel.isProcessing,
                      buttonTitle: viewmodel.isProcessing ? '처리 중' : '다음',
                      foregroundColor: CustomColors.whBlack,
                      onPressed: () async {
                        await ref
                            .read(signUpWithEmailAndPasswordUsecaseProvider)
                            .call(
                              emailInputController.text,
                              passwordInputController.text,
                            )
                            .then((result) {
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

                            return '';
                          }, (result) {
                            return result;
                          });
                        }).then((userId) async {
                          final canMoveToNextStep = userId.isNotEmpty;
                          if (canMoveToNextStep && context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditUserDetailView(
                                    userId: userId,
                                    // isModifying: false,
                                  );
                                },
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
