import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/my_page/data/repositories/resolution_repository_impl.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

final resolutionRepositoryProvider = Provider<ResolutionRepository>((ref) {
  return ResolutionRepositoryImpl();
});
