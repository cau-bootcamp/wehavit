import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  PhotoRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<String> uploadPhotoForConfirmPostAndGetDownloadUrl({
    required String localPhotoUrl,
    required ConfirmPostEntity entity,
  }) {
    final uploadResult =
        _wehavitDatasource.uploadQuickShotFromLocalUrlToConfirmPost(
      localPhotoUrl: localPhotoUrl,
      entity: entity,
    );
    return uploadResult;
  }
}
