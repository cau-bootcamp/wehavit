import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wehavit/common/constants.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';

final googleAuthDatasourceProvider = Provider<AuthGoogleDatasource>((ref) {
  return AuthGoogleDatasourceImpl();
});

class AuthGoogleDatasourceImpl implements AuthGoogleDatasource {
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

  CollectionReference _usersCollectionRef() {
    return FirebaseFirestore.instance.collection(
      FirebaseCollectionName.users,
    );
  }

  @override
  Future<void> googleLogOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
