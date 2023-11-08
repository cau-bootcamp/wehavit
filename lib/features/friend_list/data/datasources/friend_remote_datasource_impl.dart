import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/friend_list/data/datasources/friend_datasource.dart';
import 'package:wehavit/features/friend_list/data/entities/friend_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendRemoteDatasourceImpl implements FriendDatasource {
  @override
  EitherFuture<List<FriendEntity>> getFriendEntityList() async {
    List<FriendEntity> friendEntityList;

    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .get();

      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .doc(FirebaseAuth.instance.currentUser?.uid ?? 'anonymous');

      DocumentSnapshot userDocSnapshot = await userDocRef.get();

      List<DocumentReference> friendsRefs = List<DocumentReference>
          .from(userDocSnapshot.get('friend_docs_ref'));

      friendEntityList = [];
      for (DocumentReference friendRef in friendsRefs) {
        DocumentSnapshot friendDocSnapshot = await friendRef.get();
        if (friendDocSnapshot.exists) {
          friendEntityList.add(
              FriendEntity
                  .fromFirebaseDocument(friendDocSnapshot.id,
                  friendDocSnapshot.data() as Map<String, dynamic>,),);
        }
        else {
          print('Docs does not exist: ${friendRef.path}');
        }
      }

      return Future(() => right(friendEntityList));
    } on Exception {
      return Future(
            () => left(
          const Failure('catch error on getActiveFriendEntityList'),

        ),
      );
    }
  }

  @override
  EitherFuture<bool> uploadFriendEntity(
      FriendEntity entity,
      ) async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.friends)
          .add(entity.toFirebaseDocument());
      return Future(() => right(true));
    } on Exception {
      return Future(
            () => left(
          const Failure('catch error on uploadFriendEntity'),
        ),
      );
    }
  }
}
