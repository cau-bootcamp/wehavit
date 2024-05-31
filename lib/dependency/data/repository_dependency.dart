import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/data/repositories/group_repository_impl.dart';
import 'package:wehavit/data/repositories/repositories.dart';
import 'package:wehavit/dependency/data/datasource_dependency.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final wehavitAuthDataSource = ref.watch(wehavitAuthDatasourceProvider);
  final googleAuthDataSource = ref.watch(googleAuthDatasourceProvider);
  return AuthRepositoryImpl(
    wehavitAuthDataSource,
    googleAuthDataSource,
  );
});

final confirmPostRepositoryProvider = Provider<ConfirmPostRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return ConfirmPostRepositoryImpl(wehavitDatasource);
});

final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return FriendRepositoryImpl(wehavitDatasource);
});

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return PhotoRepositoryImpl(wehavitDatasource);
});

final reactionRepositoryProvider = Provider<ReactionRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return ReactionRepositoryImpl(wehavitDatasource);
});

final resolutionRepositoryProvider = Provider<ResolutionRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return ResolutionRepositoryImpl(wehavitDatasource);
});

final userModelRepositoryProvider = Provider<UserModelRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return UserModelRepositoryImpl(wehavitDatasource);
});

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  final WehavitDatasource wehavitDatasource =
      ref.watch(wehavitDatasourceProvider);
  return GroupRepositoryImpl(wehavitDatasource);
});
