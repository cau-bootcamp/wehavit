import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';

final googleAuthDatasourceProvider = Provider<AuthSocialDataSource>((ref) {
  return AuthSocialDataSourceImpl();
});

class AuthSocialDataSourceImpl implements AuthSocialDataSource {
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
    } on FirebaseAuthException catch (exception) {
      return left(Failure(exception.code));
    }
  }

  @override
  Future<void> googleLogOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  EitherFuture<(AuthResult, String?)> appleLogInAndSignUp() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return right((AuthResult.success, appleCredential.givenName));
    } on FirebaseAuthException catch (exception) {
      return left(Failure(exception.code));
    } on Exception catch (exception) {
      return left(Failure(exception.toString()));
    }
  }

  @override
  Future<void> appleLogOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  EitherFuture<void> revokeSignInWithApple() async {
    try {
      const privateKey1 = String.fromEnvironment('APPLE_PRIVATE_KEY_LINE1');
      const privateKey2 = String.fromEnvironment('APPLE_PRIVATE_KEY_LINE2');
      const privateKey3 = String.fromEnvironment('APPLE_PRIVATE_KEY_LINE3');
      const privateKey4 = String.fromEnvironment('APPLE_PRIVATE_KEY_LINE4');
      const privateKey5 = String.fromEnvironment('APPLE_PRIVATE_KEY_LINE5');
      const privateKey6 = String.fromEnvironment('APPLE_PRIVATE_KEY_LINE6');

      final String privateKey = [
        privateKey1,
        privateKey2,
        privateKey3,
        privateKey4,
        privateKey5,
        privateKey6,
      ].join('\n');

      const String teamId = 'JPL38XBHJ4';
      const String clientId = 'com.bootcamp.wehavit';
      const String keyId = '67F4G5H6JW';

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // 사용자 재인증
      try {
        await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(oauthCredential);
      } on Exception catch (e) {
        return left(
          Failure(
            'fail to reauthenticate firebase auth - ${e.toString()}',
          ),
        );
      }

      final String authCode = appleCredential.authorizationCode;
      final String clientSecret = createJwt(
        teamId: teamId,
        clientId: clientId,
        keyId: keyId,
        privateKey: privateKey,
      );

      final accessToken = (await requestAppleTokens(
        authCode,
        clientSecret,
        clientId,
      ))['access_token'] as String;

      const String tokenTypeHint = 'access_token';

      return revokeAppleToken(
        clientId: clientId,
        clientSecret: clientSecret,
        token: accessToken,
        tokenTypeHint: tokenTypeHint,
      );
    } on Exception catch (e) {
      return left(Failure('사용자 계정 삭제 중 오류 발생: $e'));
    }
  }

// JWT 생성 함수
  String createJwt({
    required String teamId,
    required String clientId,
    required String keyId,
    required String privateKey,
  }) {
    final jwt = JWT(
      {
        'iss': teamId,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp': (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600,
        'aud': 'https://appleid.apple.com',
        'sub': clientId,
      },
      header: {
        'kid': keyId,
        'alg': 'ES256',
      },
    );

    final key = ECPrivateKey(privateKey);
    return jwt.sign(key, algorithm: JWTAlgorithm.ES256);
  }

// 사용자 토큰 취소 함수
  EitherFuture<void> revokeAppleToken({
    required String clientId,
    required String clientSecret,
    required String token,
    required String tokenTypeHint,
  }) async {
    final url = Uri.parse('https://appleid.apple.com/auth/revoke');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'token': token,
        'token_type_hint': tokenTypeHint,
      },
    );

    if (response.statusCode == 200) {
      // 토큰이 성공적으로 취소됨
      return right(null);
    } else {
      return left(Failure('토큰 취소 중 오류 발생 : ${response.body}'));
    }
  }

  Future<Map<String, dynamic>> requestAppleTokens(
    String authorizationCode,
    String clientSecret,
    String clientId,
  ) async {
    final response = await http.post(
      Uri.parse('https://appleid.apple.com/auth/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': authorizationCode,
        'grant_type': 'authorization_code',
        'redirect_uri': 'YOUR_REDIRECT_URI', // 필요시 설정
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('토큰 요청 실패: ${response.body}');
    }
  }
}
