import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/presentation/swipe_view/data/datasource/user_model_fetch_datasource.dart';

class UserModelFetchDatasourceImpl extends UserModelFetchDatasource {
  @override
  EitherFuture<UserDataEntity> fetchUserDataEntityFromId(
      String targetUserId) async {
    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .doc(targetUserId)
          .get();

      return Future(
        () => right(UserDataEntity.fromJson(fetchResult.data()!)),
      );
    } on Exception catch (e) {
      debugPrint('DEBUG : fetchLiveWrittenConfirmPostList error $e');
      return Future(
        () => left(
          const Failure('catch error on fetchLiveWrittenConfirmPostList'),
        ),
      );
    }
  }
}
