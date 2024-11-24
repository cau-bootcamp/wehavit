import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetQuickshotPresetUrlsUsecase {
  GetQuickshotPresetUrlsUsecase(
    this._userModelRepository,
  );

  final UserModelRepository _userModelRepository;

  EitherFuture<List<QuickshotPresetItemEntity>> call() async {
    return _userModelRepository.getQuickshotPresets();
  }
}
