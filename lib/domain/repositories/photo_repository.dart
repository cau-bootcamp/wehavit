import 'package:wehavit/common/utils/custom_types.dart';

abstract class PhotoRepository {
  EitherFuture<String> uploadPhotoForConfirmPostAndGetDownloadUrl({
    required String localPhotoUrl,
    required String confirmPostId,
  });
}
