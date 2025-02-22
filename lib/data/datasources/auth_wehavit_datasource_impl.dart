import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';

final wehavitAuthDatasourceProvider = Provider<AuthDataSource>((ref) {
  return AuthWehavitDataSourceImpl();
});

class AuthWehavitDataSourceImpl implements AuthDataSource {
  @override
  Stream<User?> authStateChanges() async* {
    yield* FirebaseAuth.instance.authStateChanges();
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  EitherFuture<String> signUpWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    try {
      if (email == null || password == null) {
        return left(Failure(AuthResult.failure.name));
      }

      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        return left(const Failure("user doesn't created"));
      }

      // Email 가입 시에는 displayName과 photoUrl이 없기 때문에 추가해준다.
      final String name = email.split('@').first;
      final String photoUrl = result.user!.photoURL ?? 'https://picsum.photos/80';
      await result.user!.updateDisplayName(name);
      await result.user!.updatePhotoURL(photoUrl);

      // Firestore에 사용자 정보 저장

      return right(result.user!.uid);
    } on FirebaseAuthException catch (exception) {
      return left(Failure(exception.code));
    }
  }

  @override
  EitherFuture<String> logInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    try {
      if (email == null || password == null) {
        return left(Failure(AuthResult.failure.name));
      }

      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        return left(const Failure('user-not-found'));
      }

      return right(result.user!.uid);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.code));
    }
  }

  // Future<void> createUserData({
  //   required String uid,
  //   String? name,
  //   String? email,
  //   String? imageUrl,
  // }) async {
  //   await FirebaseFirestore.instance
  //       .collection(
  //         FirebaseCollectionName.users,
  //       )
  //       .doc(uid)
  //       .set({
  //     FirebaseUserFieldName.displayName: name ?? '',
  //     FirebaseUserFieldName.imageUrl: imageUrl ?? '',
  //     FirebaseUserFieldName.createdAt: DateTime.now(),
  //     FirebaseUserFieldName.aboutMe: '',
  //     FirebaseUserFieldName.handle: '',
  //     FirebaseUserFieldName.cumulativeGoals: 0,
  //     FirebaseUserFieldName.cumulativePosts: 0,
  //     FirebaseUserFieldName.cumulativeReactions: 0,
  //     FirebaseUserFieldName.messageToken: '',
  //   });
  // }

  @override
  EitherFuture<void> removeCurrentUserData() async {
    await FirebaseAuth.instance.currentUser?.delete();

    return Future(() => right(null));
  }
}
