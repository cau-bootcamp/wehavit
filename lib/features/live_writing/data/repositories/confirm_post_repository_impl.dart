import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/live_writing/data/datasources/confirm_post_remote_datasource_impl.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/live_writing/domain/repositories/confirm_post_repository.dart';

class ConfirmPostRepositoryImpl implements ConfirmPostRepository {
  ConfirmPostRepositoryImpl(Ref ref) {
    _confirmPostRemoteDatasourceImpl = ref.watch(confirmPostDatasourceProvider);
  }

  late ConfirmPostDatasource _confirmPostRemoteDatasourceImpl;

  @override
  Future<Either<Failure, List<ConfirmPostModel>>> getAllConfirmPosts() async {
    return await _confirmPostRemoteDatasourceImpl.getAllConfirmPosts();
  }

  @override
  void createConfirmPost() {
    // TODO: implement createConfirmPost
  }

  @override
  void deleteConfirmPost() {
    // TODO: implement deleteConfirmPost
  }

  @override
  void getConfirmPostByUserId() {
    // TODO: implement getConfirmPostByUserId
  }

  @override
  void updateConfirmPost() {
    // TODO: implement updateConfirmPost
  }
}
