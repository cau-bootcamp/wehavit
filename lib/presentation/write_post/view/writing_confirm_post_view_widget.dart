import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class ShareTargetGroupCellWidget extends ConsumerStatefulWidget {
  const ShareTargetGroupCellWidget(
    this.entity, {
    super.key,
  });

  final ResolutionEntity entity;

  @override
  ConsumerState<ShareTargetGroupCellWidget> createState() => _ShareTargetGroupCellWidgetState();
}

class _ShareTargetGroupCellWidgetState extends ConsumerState<ShareTargetGroupCellWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WehavitAppBar(
            titleLabel: '공유 대상',
            leadingTitle: ' ',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '그룹',
                style: context.titleSmall,
              ),
              if (widget.entity.shareGroupEntityList.isEmpty)
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    '아직 목표를 공유하는 그룹이 없어요',
                    style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                  ),
                ),
              Column(
                children: List<Widget>.generate(widget.entity.shareGroupEntityList.length, (index) {
                  final groupEntity = widget.entity.shareGroupEntityList[index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: GroupListCell(groupEntity: groupEntity),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '친구',
                style: context.titleSmall,
              ),
              if (widget.entity.shareFriendEntityList.isEmpty)
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    '아직 목표를 공유하는 친구가 없어요',
                    style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                  ),
                ),
              Column(
                children: List<Widget>.generate(widget.entity.shareFriendEntityList.length, (index) {
                  final friendEntity = widget.entity.shareFriendEntityList[index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: UserProfileCell(
                      friendEntity.userId,
                      type: UserProfileCellType.normal,
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
