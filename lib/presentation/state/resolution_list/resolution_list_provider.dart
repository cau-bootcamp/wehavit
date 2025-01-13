import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';

final resolutionListNotifierProvider = FutureProvider<List<ResolutionEntity>>(
  (ref) => ref.read(getMyResolutionListUsecaseProvider).call().then(
        (result) => result.fold(
          (failure) => [],
          (success) => success,
        ),
      ),
);

final weeklyResolutionInfoProvider = FutureProvider.family<List<bool>, GetTargetResolutionDoneListForWeekUsecaseParams>(
  (ref, param) async {
    return ref.read(getTargetResolutionDoneListForWeekUsecaseProvider).call(param: param).then(
          (result) => result.fold(
            (failure) => Future.error(Exception('실천 정보를 조회하는데 실패했습니다')),
            (success) => success,
          ),
        );
  },
);
