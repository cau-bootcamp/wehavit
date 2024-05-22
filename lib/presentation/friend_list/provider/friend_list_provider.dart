import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/friend_list/model/friend_list_view_model.dart';

class FriendListViewModelProvider extends StateNotifier<FriendListViewModel> {
  FriendListViewModelProvider(this.getFriendListUsecase)
      : super(FriendListViewModel());

  final GetFriendListUsecase getFriendListUsecase;

  Future<void> getFriendList() async {
    state.futureFriendList = getFriendListUsecase();
  }
}
