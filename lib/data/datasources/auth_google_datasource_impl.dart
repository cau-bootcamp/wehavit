import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/constants.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';

final googleAuthDatasourceProvider = Provider<AuthGoogleDatasource>((ref) {
  return AuthGoogleDatasourceImpl();
});

class AuthGoogleDatasourceImpl implements AuthGoogleDatasource {
  @override
  EitherFuture<AuthResult> googleLogInAndSignUp() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        AppKeys.emailScope,
      ],
    );

    // 로그인 통해서 유저 정보 받아옴
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return left(Failure(AuthResult.aborted.name));
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      // 여기에서 firebase Auth에 사용자 데이터 추가됨
      // authState 상태 변경까지 진행하는 코드
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );

      return right(AuthResult.success);
    } on FirebaseAuthException {
      return left(Failure(AuthResult.failure.name));
    }
  }

  @override
  Future<void> googleLogOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
