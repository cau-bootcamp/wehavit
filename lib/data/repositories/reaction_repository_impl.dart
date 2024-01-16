import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/repositories/reaction_repository.dart';

final reactionRepositoryProvider = Provider<ReactionRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return ReactionRepositoryImpl(wehavitDatasource);
});

class ReactionRepositoryImpl implements ReactionRepository {
  ReactionRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

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
}
