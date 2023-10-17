import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository_provider.dart';
import 'package:wehavit/features/my_page/domain/usecases/get_resolution_list_usecase.dart';

final getResolutionListUseCaseProvider =
    Provider<GetResolutionListUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetResolutionListUsecase(resolutionRepository);
});
