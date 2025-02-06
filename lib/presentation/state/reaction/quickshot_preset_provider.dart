import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

final quickshotPresetProvider = FutureProvider<List<QuickshotPresetItemEntity>>(
  (ref) => ref.read(getQuickshotPresetsUsecaseProvider).call().then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);
