import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/my_page/model/model.dart';

class MyPageViewModelProvider extends StateNotifier<MyPageViewModel> {
  MyPageViewModelProvider(
    this.getMyResolutionListUsecase,
    this.getMyUserDataUsecase,
    this.revokeAppleSignInUsecase,
    this.setResolutionDeactiveUsecase,
  ) : super(MyPageViewModel());

  final GetMyResolutionListUsecase getMyResolutionListUsecase;
  final GetMyUserDataUsecase getMyUserDataUsecase;
  final RevokeAppleSignInUsecase revokeAppleSignInUsecase;
  final SetResolutionDeactiveUsecase setResolutionDeactiveUsecase;

  Future<void> loadData() async {
    getResolutionList();
    getMyUserData();
  }

  Future<void> getResolutionList() async {
    state.futureMyyResolutionList = getMyResolutionListUsecase();
  }

  Future<void> getMyUserData() async {
    state.futureMyUserDataEntity = getMyUserDataUsecase();
  }

  Future<bool> revokeAppleSignIn() async {
    return await revokeAppleSignInUsecase().then(
      (result) => result.fold(
        (failure) => false,
        (success) => true,
      ),
    );
  }

  Future<bool> deleteAccount(BuildContext context) async {
    final isAppleLogin = FirebaseAuth.instance.currentUser?.providerData.any(
      (info) => info.providerId == 'apple.com',
    );

    bool isRevokable;

    try {
      if (isAppleLogin == true) {
        isRevokable = await revokeAppleSignIn();
      } else {
        isRevokable = true;
      }

      // 계정을 삭제할 준비가 완료됨
      if (isRevokable == true) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.delete();

          // ignore: avoid_print
          print('사용자 계정이 성공적으로 삭제되었습니다.');
        }

        // // 창 닫기
        if (mounted) {
          Navigator.pushReplacementNamed(
            // ignore: use_build_context_synchronously
            context,
            '/entrance',
          );
        }

        return true;
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print('DEBUG : 사용자 계정 삭제 중 exception : ${e.toString()}');
      return false;
    }
    if (mounted) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, false);
    }
    return false;
  }

  Future<void> deactiveResolution({
    required ResolutionEntity targetResolutionEntity,
  }) async {
    await setResolutionDeactiveUsecase.call(
      resolutionId: targetResolutionEntity.resolutionId,
      entity: targetResolutionEntity,
    );
  }
}
