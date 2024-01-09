import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/legacy/live_writing/live_writing.dart';

final liveWritingConfirmPostDatasourceProvider =
    Provider<ConfirmPostDatasource>((ref) {
  return ConfirmPostRemoteDatasourceImpl();
});
