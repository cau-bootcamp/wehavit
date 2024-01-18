import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/wehavit_datasource.dart';
import 'package:wehavit/domain/repositories/photo_repository.dart';

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return PhotoRepositoryImpl(wehavitDatasource);
});

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
