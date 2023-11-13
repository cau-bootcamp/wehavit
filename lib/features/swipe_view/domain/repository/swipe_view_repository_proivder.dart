import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/data/repository/swipe_view_repository_impl.dart';
import 'package:wehavit/features/swipe_view/domain/repository/swipe_view_repository.dart';

final swipeViewRepositoryProvider = Provider<SwipeViewRepository>((ref) {
  return SwipeViewRepositoryImpl(ref);
});
