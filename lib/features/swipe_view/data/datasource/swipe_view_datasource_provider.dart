import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/data/datasource/swipe_view_datasource.dart';
import 'package:wehavit/features/swipe_view/data/datasource/swipe_view_datasource_impl.dart';

final swipeViewDatasourceProvider = Provider<SwipeViewDatasource>((ref) {
  return SwipeViewDatasourceImpl();
});
