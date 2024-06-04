import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/write_post/model/add_resolution_done_view_model.dart';

class AddResolutionDoneViewModelProvider
    extends StateNotifier<AddResolutionDoneViewModel> {
  AddResolutionDoneViewModelProvider() : super(AddResolutionDoneViewModel());

  void toggleFriendSelection(index) {
    if (state.selectedFriendList != null) {
      state.selectedFriendList![index] = !state.selectedFriendList![index];
    }
  }

  void toggleGroupSelection(index) {
    if (state.selectedGroupList != null) {
      state.selectedGroupList![index] = !state.selectedGroupList![index];
    }
  }
}
