import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  PhotoRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<String> uploadPhotoForConfirmPostAndGetDownloadUrl({
    required String localPhotoUrl,
    required String confirmPostId,
  }) {
    final uploadResult =
        _wehavitDatasource.uploadPhotoFromLocalUrlToConfirmPost(
      localPhotoUrl: localPhotoUrl,
      confirmPostId: confirmPostId,
    );
    return uploadResult;
  }
}
