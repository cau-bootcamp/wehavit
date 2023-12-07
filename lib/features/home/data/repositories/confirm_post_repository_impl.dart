import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/home/data/datasources/confirm_post_datasource.dart';
import 'package:wehavit/features/home/data/datasources/confirm_post_datasource_provider.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';
// import 'package:wehavit/features/home/data/entities/confirm_post_entity.dart';
// import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/home/domain/repositories/confirm_post_repository.dart';

class ConfirmPostRepositoryImpl implements ConfirmPostRepository {
  ConfirmPostRepositoryImpl(Ref ref) {
    _confirmPostDatasource = ref.watch(confirmPostDatasourceProvider);
  }

  late final ConfirmPostDatasource _confirmPostDatasource;

  @override
  EitherFuture<List<HomeConfirmPostModel>> getConfirmPostModelList(
    int selectedIndex,
  ) async {
    try {
      final getResult = await _confirmPostDatasource.getConfirmPostEntityList(
        selectedIndex,
      );

      return getResult.fold((failure) => left(failure), (entityList) {
        final modelList = entityList.toList();

        return Future(() => right(modelList));
      });
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }
}
