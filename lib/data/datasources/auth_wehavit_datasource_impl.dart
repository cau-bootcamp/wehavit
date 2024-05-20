import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';

final wehavitAuthDatasourceProvider = Provider<AuthWehavitDataSource>((ref) {
  return AuthWehavitDataSourceImpl();
});

class AuthWehavitDataSourceImpl implements AuthWehavitDataSource {
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
        FirebaseUserFieldName.createdAt: DateTime.now(),
        FirebaseUserFieldName.aboutMe: '',
        FirebaseUserFieldName.cumulativeGoals: 0,
        FirebaseUserFieldName.cumulativePosts: 0,
        FirebaseUserFieldName.cumulativeReactions: 0,
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
      await _usersCollectionRef().doc(result.user?.uid).set(
        {
          FirebaseUserFieldName.displayName: email.split('@').first,
          FirebaseUserFieldName.email: email,
          FirebaseUserFieldName.imageUrl:
              result.user!.photoURL ?? 'https://picsum.photos/80',
          FirebaseUserFieldName.createdAt: DateTime.now(),
          FirebaseUserFieldName.cumulativeGoals: 0,
          FirebaseUserFieldName.cumulativePosts: 0,
          FirebaseUserFieldName.cumulativeReactions: 0,
        },
        SetOptions(merge: true),
      );

      return AuthResult.success;
    } on FirebaseAuthException {
      return AuthResult.failure;
    }
  }
}
