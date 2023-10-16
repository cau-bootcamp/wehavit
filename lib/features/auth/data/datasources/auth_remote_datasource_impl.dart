import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wehavit/common/constants.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
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
        FirebaseFieldName.displayName: result.user?.displayName,
        FirebaseFieldName.email: result.user?.email,
        FirebaseFieldName.imageUrl: result.user?.photoURL,
      });

      return AuthResult.success;
    } on FirebaseAuthException {
      return AuthResult.failure;
    }
  }

  @override
  Future<void> googleLogOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  CollectionReference _usersCollectionRef() {
    return FirebaseFirestore.instance.collection(
      FirebaseCollectionName.users,
    );
  }
}
