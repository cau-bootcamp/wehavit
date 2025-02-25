class SignUpAuthDataViewModel {
  String email = '';
  String password = '';
  String passwordValidator = '';

  bool get isEmailValid => email.isNotEmpty;
  bool get isPasswordValid => password.isNotEmpty && (password.length >= 6 && password.length <= 20);
  bool get isValidatorValid => password.compareTo(passwordValidator) == 0;

  RegisterFailReason? registerFailReason;
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
