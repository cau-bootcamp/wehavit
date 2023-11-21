import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource.dart';
import 'package:wehavit/features/my_page/data/entities/resolution_entity.dart';

class ResolutionRemoteDatasourceImpl implements ResolutionDatasource {
  /// Firebase에서 나의 도전 목표 데이터를 받아온다.
  ///
  /// `FirebaseCollectionName.resolutions` 변수에 접근하여 나의 resolution 이 담겨있는
  /// collection에 접근할 수 있으며,
  /// 여기에 접근해 현재 활성화가 되어있는 도전들만 가져온다. (보관되지 않은 도전)
  ///
  /// 만약 보관된 도전들까지 모두 가져오고 싶다면 `getAllResolutionEntityList()` 함수를
  /// 실행해주면 된다.
  @override
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList() async {
    List<ResolutionEntity> resolutionEntityList;

    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.resolutions)
          .where(
            FirebaseResolutionFieldName.resolutionIsActive,
            isEqualTo: true,
          )
          .get();

      resolutionEntityList = fetchResult.docs
          .map(
            (doc) => ResolutionEntity.fromFirebaseDocument(
              doc.data(),
              doc.reference.path,
            ),
          )
          .toList();

      return Future(() => right(resolutionEntityList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getActiveResolutionEntityList'),
        ),
      );
    }
  }

  /// Firebase에서 나의 도전 목표 데이터를 받아온다.
  ///
  /// `FirebaseCollectionName.resolutions` 변수에 접근하여 나의 resolution 이 담겨있는
  /// collection에 접근할 수 있으며,
  /// 여기에 접근해 현재 활성화가 되어있는 도전들만 가져온다. (보관되지 않은 도전)
  ///
  /// 만약 활성화된 도전들만 가져오고 싶다면 `getActiveResolutionEntityList()` 함수를
  /// 실행해주면 된다.
  @override
  EitherFuture<List<ResolutionEntity>> getAllResolutionEntityList() async {
    List<ResolutionEntity> resolutionEntityList;

    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.resolutions)
          .get();

      resolutionEntityList = fetchResult.docs
          .map(
            (doc) => ResolutionEntity.fromFirebaseDocument(
              doc.data(),
              doc.reference.path,
            ),
          )
          .toList();

      return Future(() => right(resolutionEntityList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getAllResolutionEntityList'),
        ),
      );
    }
  }

  /// Firebase로 나의 도전 목표 데이터를 업로드한다.
  ///
  /// ResolutionEntity 타입의 객체를 인자로 전달받으면
  /// 이를 사용자의 도전 목표 컬렉션에 저장해주고,
  /// 업로드에 성공하였음을 Future<bool>을 통해 전달한다.
  @override
  EitherFuture<bool> uploadResolutionEntity(
    ResolutionEntity entity,
  ) async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.resolutions)
          .add(entity.toFirebaseDocument());

      return Future(() => right(true));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on uploadResolutionEntity'),
        ),
      );
    }
  }

  @override
  EitherFuture<List<ConfirmPostModel>> getConfirmPostListForResolutionId({
    required String resolutionId,
  }) async {
    try {
      final fetchResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.confirmPosts)
          .where(
            FirebaseConfirmPostFieldName.resolutionId,
            isEqualTo: FirebaseFirestore.instance.doc('/$resolutionId'),
          )
          .get();

      final confirmPostModelList = fetchResult.docs.map((doc) {
        return ConfirmPostModel.fromFireStoreDocument(doc);
      }).toList();

      return Future(() => right(confirmPostModelList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getConfirmPostListForResolutionId'),
        ),
      );
    }
  }
}
