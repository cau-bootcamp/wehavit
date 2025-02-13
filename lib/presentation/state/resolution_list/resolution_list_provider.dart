import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/datetime+.dart';
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

final weeklyResolutionInfoProvider = FutureProvider.family<List<bool>, WeeklyResolutionInfoProviderParam>(
  (ref, param) async {
    return ref
        .read(getTargetResolutionDoneListForWeekUsecaseProvider)
        .call(
          param: GetTargetResolutionDoneListForWeekUsecaseParams(
            resolutionId: param.resolutionId,
            startMonday: param.startMonday,
          ),
        )
        .then(
          (value) => value.fold(
            (failure) => Future.error(failure.message),
            (success) => success,
          ),
        );
  },
);

class WeeklyResolutionInfoProviderParam {
  WeeklyResolutionInfoProviderParam({required this.resolutionId, required this.startMonday});

  final String resolutionId;
  final DateTime startMonday;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeeklyResolutionInfoProviderParam &&
        other.resolutionId == resolutionId &&
        other.startMonday == startMonday;
  }

  @override
  int get hashCode => resolutionId.hashCode ^ startMonday.hashCode;
}

final myWeeklyResolutionSummaryProvider = FutureProvider<int>((ref) async {
  final resolutionEntityList = await ref.watch(resolutionListNotifierProvider.future);

  final successCount = await Future.wait(
    resolutionEntityList.map((entity) async {
      return await ref
          .read(getTargetResolutionDoneListForWeekUsecaseProvider)
          .call(
            param: GetTargetResolutionDoneListForWeekUsecaseParams(
              resolutionId: entity.resolutionId,
              startMonday: DateTime.now().getMondayDateTime(),
            ),
          )
          .then((result) => result.fold((failure) => 0, (success) => success.where((e) => e == true).length));
    }),
  );

  return successCount.reduce((v, e) => v + e);
});
