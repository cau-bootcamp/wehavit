import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource.dart';
import 'package:wehavit/features/my_page/data/entities/new_resolution_entity.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

class ResolutionRemoteDatasourceImpl implements ResolutionDatasource {
  /// Firebase에서 나의 도전 목표 데이터를 받아온다.
  ///
  /// `FirebaseCollectionName.resolutions` 변수에 접근하여 나의 resolution 이 담겨있는 collection에 접근할 수 있으며,
  /// 여기에 접근해 현재 활성화가 되어있는 도전들만 가져온다. (보관되지 않은 도전)
  ///
  /// 만약 보관된 도전들까지 모두 가져오고 싶다면 `getAllResolutionModelList()` 함수를 실행해주면 된다.
  @override
  Future<Either<Failure, List<ResolutionModel>>>
      getActiveResolutionModelList() async {
    List<ResolutionModel> resolutionList = [];

    try {
      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.resolutions)
          .where(FirebaseFieldName.resolutionIsActive, isEqualTo: true)
          .snapshots()
          .listen(
            (data) => {
              for (var doc in data.docs)
                {
                  // TODO : Entity 로 받은 뒤 Model로 Casting 하여 전달해줘야 함
                  resolutionList.add(
                    ResolutionModel.fromMapData(doc.data()),
                  ),
                },
            },
          );

      return Future(() => right(resolutionList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getActiveResolutionModelList'),
        ),
      );
    }
  }

  /// Firebase에서 나의 도전 목표 데이터를 받아온다.
  ///
  /// `FirebaseCollectionName.resolutions` 변수에 접근하여 나의 resolution 이 담겨있는 collection에 접근할 수 있으며,
  /// 여기에 접근해 현재 활성화가 되어있는 도전들만 가져온다. (보관되지 않은 도전)
  ///
  /// 만약 활성화된 도전들만 가져오고 싶다면 `getActiveResolutionModelList()` 함수를 실행해주면 된다.
  @override
  Future<Either<Failure, List<ResolutionModel>>>
      getAllResolutionModelList() async {
    List<ResolutionModel> resolutionList = [];

    try {
      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.resolutions)
          .snapshots()
          .listen(
            (data) => {
              for (var doc in data.docs)
                {
                  resolutionList.add(
                    ResolutionModel.fromMapData(doc.data()),
                  ),
                },
            },
          );

      return Future(() => right(resolutionList));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getActiveResolutionModelList'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> uploadResolutionEntity(
    ResolutionToUploadEntity entity,
  ) async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.resolutions)
          .add(entity.toFirebaseDocument());

      return Future(() => right(true));
    } on Exception {
      return Future(
        () => left(
          const Failure('catch error on getActiveResolutionModelList'),
        ),
      );
    }
  }
}
