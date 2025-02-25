import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/entrance/entrance.dart';

class SignUpAuthDataViewModelProvider extends StateNotifier<SignUpAuthDataViewModel> {
  SignUpAuthDataViewModelProvider(this.ref) : super(SignUpAuthDataViewModel());

  final Ref ref;

  void setEmail(String email) {
    state.email = email;
    ref.notifyListeners();
  }

  void setPassword(String password) {
    state.password = password;
    ref.notifyListeners();
  }

  void setPasswordValidator(String validator) {
    state.passwordValidator = validator;
    ref.notifyListeners();
  }
}
