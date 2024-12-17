import 'package:flutter/material.dart';

class SignUpAuthDataViewModel {
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordValidatorInputController = TextEditingController();

  RegisterFailReason? registerFailReason;
  bool isEmailEntered = false;
  bool? isPasswordValid;
  bool isPasswordMatched = false;

  bool isProcessing = false;
}

enum RegisterFailReason {
  emailIsAlreadyTaken,
  emailFormatIsInvalid,
  passwordIsWeak,
  etc,
}

extension RegisterFailReasonConverter on RegisterFailReason {
  // FirebaseAuthException을 RegisterFailReason으로 변환하는 메소드
  static RegisterFailReason fromExceptionCode(String exceptionCode) {
    switch (exceptionCode) {
      case 'email-already-in-use':
        return RegisterFailReason.emailIsAlreadyTaken;
      case 'invalid-email':
        return RegisterFailReason.emailFormatIsInvalid;
      case 'weak-password':
        return RegisterFailReason.passwordIsWeak;
      default:
        return RegisterFailReason.etc;
    }
  }
}
