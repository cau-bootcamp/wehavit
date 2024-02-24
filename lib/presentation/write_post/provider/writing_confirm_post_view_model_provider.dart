import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class WritingConfirmPostViewModelProvider
    extends StateNotifier<WritingConfirmPostViewModel> {
  WritingConfirmPostViewModelProvider() : super(WritingConfirmPostViewModel());
}
