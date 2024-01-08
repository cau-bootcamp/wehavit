import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/legacy/swipe_view/data/datasource/reaction_datasource.dart';
import 'package:wehavit/legacy/swipe_view/data/datasource/reaction_datasource_impl.dart';

final reactionDatasourceProvider = Provider<ReactionDatasource>((ref) {
  return ReactionDatasourceImpl();
});
