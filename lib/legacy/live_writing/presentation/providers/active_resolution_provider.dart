import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/usecases/get_resolution_list_usecase.dart';

final activeResolutionListProvider =
    FutureProvider.autoDispose<Either<Failure, List<ResolutionEntity>>>(
        (ref) async {
  final getResolutionListUsecase =
      ref.watch(getResolutionListByUserIdUsecaseProvider);
  return await getResolutionListUsecase('my user id');
});
