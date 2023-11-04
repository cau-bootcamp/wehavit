import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/friend_list/data/datasources/friend_datasource.dart';
import 'package:wehavit/features/friend_list/data/entities/friend_entity.dart';

class FriendRemoteDatasourceImpl implements FriendDatasource {
  @override
  EitherFuture<List<FriendEntity>> getFriendEntityList() async {
    List<FriendEntity> friendEntityList;

    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.friends)
          .get();
      final documentIds = fetchResult.docs.map((doc) => doc.id);
      final fetchFriendResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FieldPath.documentId, whereIn: documentIds)
          .get();
      var friendMap = {
        for (var doc in fetchFriendResult.docs) doc.id : doc.data(),
      };
      friendEntityList = fetchResult.docs
          .map((doc) => FriendEntity
          .fromFirebaseDocument(doc.data(), friendMap),)
          .toList();

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
