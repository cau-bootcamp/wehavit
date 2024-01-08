import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/data/datasources/firebase_datasource_impl.dart';
import 'package:wehavit/data/datasources/wehavit_datasource_interface.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';
import 'package:wehavit/domain/repositories/friend_repository.dart';
import 'package:wehavit/domain/repositories/reaction_repository.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';
import 'package:wehavit/domain/repositories/user_model_fetch_repository.dart';

final wehavitDataRepositoryProvider =
    Provider<WehavitDataRepositoryImpl>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(firebaseDatasourceImplProvider);
  return WehavitDataRepositoryImpl(wehavitDatasource);
});

class WehavitDataRepositoryImpl
    implements
        ConfirmPostRepository,
        FriendRepository,
        ReactionRepository,
        ResolutionRepository,
        UserModelFetchRepository {
  WehavitDataRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  // Friend Repository
  @override
  EitherFuture<List<UserDataEntity>> getFriendModelList() async {
    try {
      final getResult = await _wehavitDatasource.getFriendEntityList();

      return getResult.fold(
        (failure) => left(failure),
        (modelList) {
          // final entityList =
          //     modelList.map((model) => model.toFriendModel()).toList();

          return Future(() => right(modelList));
        },
      );
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<bool> uploadFriendEntity(UserDataEntity entity) async {
    // final model = UserDataModel.fromEntity(entity);
    return _wehavitDatasource.uploadFriendEntity(entity);
  }

  // Confirm Post Repository
  @override
  EitherFuture<bool> createConfirmPost(ConfirmPostEntity confirmPost) async {
    final String resolutionId = confirmPost.resolutionId!;
    try {
      final existingPost = await _wehavitDatasource
          .getConfirmPostOfTodayByResolutionGoalId(resolutionId);

      existingPost.fold(
        (l) {
          // create new post if not exist
          confirmPost = confirmPost.copyWith(
            owner: FirebaseAuth.instance.currentUser!.uid,
          );

          _wehavitDatasource.uploadConfirmPost(confirmPost);
        },
        (cf) {
          // update existing post
          confirmPost = confirmPost.copyWith(
            id: cf.id,
            owner: FirebaseAuth.instance.currentUser!.uid,
            createdAt: cf.createdAt,
            updatedAt: DateTime.now(),
          );

          _wehavitDatasource.updateConfirmPost(confirmPost);
        },
      );

      return Future(() => right(true));
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? 'FirebaseException'));
    }
  }

  @override
  EitherFuture<bool> deleteConfirmPost(
    DocumentReference<ConfirmPostEntity> confirmPostRef,
  ) {
    // TODO: implement deleteConfirmPost
    return Future(
      () => left(const Failure('deleteConfirmPost not implemented')),
    );
  }

  @override
  EitherFuture<ConfirmPostEntity> getConfirmPostEntityByUserId({
    required String userId,
  }) {
    // TODO: implement getConfirmPostByUserId
    return Future(
      () => left(const Failure('getConfirmPostByUserId not implemented')),
    );
  }

  @override
  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost) {
    return Future(
      () => left(const Failure('updateConfirmPost not implemented')),
    );
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId(
      {required String resolutionId}) {
    // TODO: implement getConfirmPostListForResolutionId
    throw UnimplementedError();
  }

  @override
  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionEntity,
  ) {
    return _wehavitDatasource.sendReactionToTargetConfirmPost(
      targetConfirmPostId,
      reactionEntity,
    );
  }

  @override
  EitherFuture<List<ResolutionEntity>> getActiveResolutionModelList(
    String userId,
  ) async {
    try {
      final getResult =
          await _wehavitDatasource.getActiveResolutionEntityList();

      return getResult.fold(
        (failure) => left(failure),
        (entityList) {
          // final modelList =
          // entityList.map((entity) => entity.toResolutionEntity()).toList();

          return Future(() => right(entityList));
        },
      );
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<List<ReactionEntity>>
      getUnreadReactionFromLastConfirmPost() async {
    final confirmPostFetchResult = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.confirmPosts)
        .where('owner', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    final temp = confirmPostFetchResult.docs.toList();
    final myLatestConfirmPostId = temp.first.reference.id;

    final encourages = await FirebaseFirestore.instance
        .collection(
          '${FirebaseCollectionName.confirmPosts}/$myLatestConfirmPostId/${FirebaseCollectionName.encourages}',
        )
        .where('hasRead', isEqualTo: false)
        .get();

    // 이 로직으로 응원 데이터는 한 번만 가져올 수 있음
    for (var doc in encourages.docs) {
      FirebaseFirestore.instance.doc(doc.reference.path).set(
        {'hasRead': true},
        SetOptions(merge: true),
      );
    }

    final result = encourages.docs
        .map((doc) => ReactionEntity.fromJson(doc.data()))
        .toList();

    return Future(
      () => right(result),
    );
  }

  @override
  EitherFuture<bool> uploadResolutionEntity(
    ResolutionEntity entity,
  ) async {
    return _wehavitDatasource.uploadResolutionEntity(entity);
  }

  @override
  EitherFuture<UserDataEntity> fetchUserModelFromId(String targetUserId) {
    return _wehavitDatasource.fetchUserDataEntityFromId(targetUserId);
  }

  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate({
    required int selectedDate,
  }) async {
    try {
      final getResult = await _wehavitDatasource.getConfirmPostEntityList(
        selectedDate,
      );

      return getResult.fold((failure) => left(failure), (entityList) {
        final modelList = entityList.toList();

        return Future(() => right(modelList));
      });
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }
}
