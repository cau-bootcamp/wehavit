import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/friend_list/data/repositories/friend_repository_impl.dart';
import 'package:wehavit/features/friend_list/domain/repositories/friend_repository.dart';

final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  return FriendRepositoryImpl(ref);
});