import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/get_quickshot_presets_usecase.dart';
import 'package:wehavit/domain/usecases/upload_quickshot_preset_usecase.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

final quickshotPresetProvider = FutureProvider<List<QuickshotPresetItemEntity>>(
  (ref) => ref.read(getQuickshotPresetsUsecaseProvider).call().then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

// final quickshotPresetStateNotifierProvider =
//     StateNotifierProvider<QuickshotPresetStateNotifier, List<QuickshotPresetItemEntity>>((ref) {
//   return QuickshotPresetStateNotifier(
//     [],
//     ref.read(getQuickshotPresetsUsecaseProvider),
//     ref.read(uploadQuickshotPresetUsecaseProvider),
//     ref.read(removeQuickshotPresetUsecaseProvider),
//   );
// });

// class QuickshotPresetStateNotifier extends StateNotifier<List<QuickshotPresetItemEntity>> {
//   QuickshotPresetStateNotifier(
//     super._state,
//     this._getQuickshotPresetsUsecase,
//     this._uploadQuickshotPresetUsecase,
//     this._removeQuickshotPresetUsecase,
//   );

//   final UploadQuickshotPresetUsecase _uploadQuickshotPresetUsecase;
//   final RemoveQuickshotPresetUsecase _removeQuickshotPresetUsecase;

//   EitherFuture<void> uploadQuickshotPresetEntity(String fileUrl) {
//     return _uploadQuickshotPresetUsecase.call(localFileUrl: fileUrl);
//   }

//   EitherFuture<void> removeQuickshotPresetEntity(QuickshotPresetItemEntity entity) {
//     return _removeQuickshotPresetUsecase.call(quickshotEntity: entity);
//   }
// }
