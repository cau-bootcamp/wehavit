import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/swipe_view/data/datasource/user_model_fetch_datasource.dart';

class UserModelFetchDatasourceImpl extends UserModelFetchDatasource {
  @override
  EitherFuture<UserModel> fetchUserModelFromId(String targetUserId) async {
    try {
      print(targetUserId);
      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .doc(targetUserId)
          .get();

      return Future(
        () => right(UserModel.fromJson(fetchResult.data()!)),
      );
    } on Exception catch (e) {
      print("DEBUG : fetchLiveWrittenConfirmPostList error $e");
      return Future(
        () => left(
          const Failure("catch error on fetchLiveWrittenConfirmPostList"),
        ),
      );
    }
  }
}
