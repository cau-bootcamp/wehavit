import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/get_target_resolution_done_list_for_week_usecase.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';

class ResolutionLinearGaugeIndicator extends StatelessWidget {
  const ResolutionLinearGaugeIndicator({
    required this.resolutionEntity,
    required this.targetDate,
    super.key,
  });

  final ResolutionEntity resolutionEntity;
  final DateTime targetDate;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final param = WeeklyResolutionInfoProviderParam(
          resolutionId: resolutionEntity.resolutionId,
          startMonday: targetDate.getMondayDateTime(),
        );

        final weeklyDoneList = ref.watch(
          weeklyResolutionInfoProvider(param),
        );

        return weeklyDoneList.when(
          data: (successList) {
            final successCount = successList.where((element) => element == true).length;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        resolutionEntity.actionStatement,
                        style: context.bodyMedium?.copyWith(
                          color: CustomColors.whGrey900,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      '주 ${resolutionEntity.actionPerWeek}회 중 $successCount회 실천',
                      style: context.bodySmall?.copyWith(
                        color: CustomColors.whGrey900,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 8,
                        width: double.infinity,
                        color: CustomColors.whDarkBlack,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            flex: successCount,
                            child: Container(
                              height: 8,
                              color: CustomColors.pointColorList[resolutionEntity.colorIndex],
                            ),
                          ),
                          Flexible(
                            flex: (resolutionEntity.actionPerWeek) - successCount,
                            child: Container(
                              height: 8,
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (e, _) => Column(
            children: [
              Text(
                '정보를 가져오는데 실패했어요',
                style: context.bodyMedium?.copyWith(
                  color: CustomColors.whGrey900,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                height: 8,
                color: CustomColors.whGrey600,
              ),
            ],
          ),
          loading: () => Column(
            children: [
              Row(
                children: [
                  Text(
                    resolutionEntity.actionStatement,
                    textAlign: TextAlign.left,
                    style: context.bodyMedium?.copyWith(
                      color: CustomColors.whGrey900,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              LinearProgressIndicator(
                minHeight: 8,
                color: CustomColors.pointColorList[resolutionEntity.colorIndex],
                backgroundColor: CustomColors.whGrey100,
              ),
            ],
          ),
        );
      },
    );
  }
}
