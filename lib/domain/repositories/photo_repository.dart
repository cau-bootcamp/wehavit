import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class PhotoRepository {
  EitherFuture<String> uploadPhotoForConfirmPostAndGetDownloadUrl({
    required String localPhotoUrl,
    required ConfirmPostEntity entity,
  });

  EitherFuture<String> uploadQuickshotPresetImage({
    required localFileUrl,
  });
}
