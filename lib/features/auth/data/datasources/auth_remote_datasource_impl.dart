import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wehavit/common/constants.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/auth/auth.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Stream<User?> authStateChanges() async* {
    yield* FirebaseAuth.instance.authStateChanges();
  }

  @override
  Future<AuthResult> googleLogIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        AppKeys.emailScope,
      ],
    );

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      final result = await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );

      await _usersCollectionRef().doc(result.user?.uid).set({
        FirebaseUserFieldName.displayName: result.user?.displayName,
        FirebaseUserFieldName.email: result.user?.email,
        FirebaseUserFieldName.imageUrl: result.user?.photoURL,
      });

      return AuthResult.success;
    } on FirebaseAuthException {
      return AuthResult.failure;
    }
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  CollectionReference _usersCollectionRef() {
    return FirebaseFirestore.instance.collection(
      FirebaseCollectionName.users,
    );
  }

  @override
  Future<AuthResult> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        return AuthResult.failure;
      }

      // Email 가입 시에는 displayName과 photoUrl이 없기 때문에 추가해준다.
      final String name = email.split('@').first;
      final String photoUrl =
          result.user!.photoURL ?? 'https://picsum.photos/80';
      await result.user!.updateDisplayName(name);
      await result.user!.updatePhotoURL(photoUrl);

      // Firebase에 사용자 정보 저장
      await _usersCollectionRef().doc(result.user?.uid).set({
        FirebaseUserFieldName.displayName: name,
        FirebaseUserFieldName.email: email,
        FirebaseUserFieldName.imageUrl: photoUrl,
      });

      return AuthResult.success;
    } on FirebaseAuthException {
      return AuthResult.failure;
    }
  }

  @override
  Future<AuthResult> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        return AuthResult.failure;
      }

      return AuthResult.success;
    } on FirebaseAuthException {
      return AuthResult.failure;
    }
  }
}
