import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class SignUpAuthDataViewModelProvider extends StateNotifier<SignUpAuthDataViewModel> {
  SignUpAuthDataViewModelProvider() : super(SignUpAuthDataViewModel());

  void checkEmailEntered() {
    state.isEmailEntered = state.emailInputController.text.isNotEmpty;
  }

  void checkPasswordValidity() {
    final inputText = state.passwordInputController.text;
    if (inputText == '') {
      state.isPasswordValid = null;
    } else {
      state.isPasswordValid = inputText.length >= 6;
    }
  }

  void matchPasswordAndValidator() {
    state.isPasswordMatched = state.passwordInputController.text.compareTo(
          state.passwordValidatorInputController.text,
        ) ==
        0;
  }
}
