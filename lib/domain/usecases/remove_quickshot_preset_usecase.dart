import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/domain.dart';

class RemoveQuickshotPresetUsecase {
  RemoveQuickshotPresetUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<void> call({
    required QuickshotPresetItemEntity quickshotEntity,
  }) {
    return _userModelRepository.removeQuickshotPreset(quickshotEntity);
  }
}
