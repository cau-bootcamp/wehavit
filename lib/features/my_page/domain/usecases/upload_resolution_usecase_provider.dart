import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository_provider.dart';
import 'package:wehavit/features/my_page/domain/usecases/upload_resolution_usecase.dart';

final uploadResolutionUsecaseProvider =
    Provider<UploadResolutionUseCase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return UploadResolutionUseCase(resolutionRepository);
});
