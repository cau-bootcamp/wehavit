import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/data/datasources/wehavit_auth_datasource.dart';
import 'package:wehavit/presentation/auth/data/entities/auth_result.dart';

class WehavitAuthDataSourceImpl implements WehavitAuthDataSource {
  @override
  Stream<User?> authStateChanges() async* {
    yield* FirebaseAuth.instance.authStateChanges();
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
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

      // Firestore에 사용자 정보 저장
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

      // 혹시라도 없는 경우, 로그인 시 Firestore에 사용자 정보 저장
      await _usersCollectionRef().doc(result.user?.uid).set({
        FirebaseUserFieldName.displayName: email.split('@').first,
        FirebaseUserFieldName.email: email,
        FirebaseUserFieldName.imageUrl:
            result.user!.photoURL ?? 'https://picsum.photos/80',
      }, SetOptions(merge: true));

      return AuthResult.success;
    } on FirebaseAuthException {
      return AuthResult.failure;
    }
  }
}
