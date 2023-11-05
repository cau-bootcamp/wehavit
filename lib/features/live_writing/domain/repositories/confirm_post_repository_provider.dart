import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/live_writing/data/repositories/confirm_post_repository_impl.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';

final confirmPostRepositoryProvider = Provider<ConfirmPostRepository>((ref) {
  return ConfirmPostRepositoryImpl(ref);
});
