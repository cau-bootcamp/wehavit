import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadConfirmPostImageUsecase {
  UploadConfirmPostImageUsecase(
    this._confirmPostRepository,
  );

  final ConfirmPostRepository _confirmPostRepository;

  EitherFuture<String> call({
    required XFile localImageFile,
  }) async {
    try {
      final networkImageUrl =
          await _confirmPostRepository.uploadConfirmPostImage(localFileUrl: localImageFile.path).then(
                (value) => value.fold(
                  (failure) => null,
                  (imageUrl) => imageUrl,
                ),
              );

      if (networkImageUrl == null) {
        throw const Failure('cannot upload confirm post photo');
      }

      return right(networkImageUrl);
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }
}
