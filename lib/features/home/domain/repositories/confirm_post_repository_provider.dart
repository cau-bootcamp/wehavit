import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/home/data/repositories/confirm_post_repository_impl.dart';
import 'package:wehavit/features/home/domain/repositories/confirm_post_repository.dart';

final confirmPostRepositoryProvider = Provider<ConfirmPostRepository>((ref) {
  return ConfirmPostRepositoryImpl(ref);
});
