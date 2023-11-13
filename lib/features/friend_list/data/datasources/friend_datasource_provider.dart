import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/friend_list/data/datasources/friend_datasource.dart';
import 'package:wehavit/features/friend_list/data/datasources/friend_remote_datasource_impl.dart';

final friendDatasourceProvider = Provider<FriendDatasource>((ref) {
  return FriendRemoteDatasourceImpl();
});
