import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/wh_icon.dart';

class ResolutionInfo extends StatelessWidget {
  const ResolutionInfo({
    required this.resolutionEntity,
    super.key,
  });

  final ResolutionEntity resolutionEntity;

  @override
  Widget build(BuildContext context) {
    final pointColor = CustomColors.pointColorList[resolutionEntity.colorIndex];

    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: CustomColors.whGrey300,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WHIcon(
                size: WHIconsize.small,
                iconString: WHIcons.emojiFlag,
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '나의 목표',
                    style: context.titleSmall?.copyWith(color: pointColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    resolutionEntity.goalStatement,
                    style: context.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WHIcon(
                size: WHIconsize.small,
                iconString: WHIcons.emojiClipboard,
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '나의 실천 계획',
                    style: context.titleSmall?.copyWith(color: pointColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${resolutionEntity.actionStatement}\n일주일에 ${resolutionEntity.actionPerWeek}회 실천하기',
                    style: context.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WHIcon(
                size: WHIconsize.small,
                iconString: WHIcons.emojiCalendar,
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '도전 시작일',
                    style: context.titleSmall?.copyWith(color: pointColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('yyyy년 M월 d일').format(
                      resolutionEntity.startDate,
                    ),
                    style: context.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
