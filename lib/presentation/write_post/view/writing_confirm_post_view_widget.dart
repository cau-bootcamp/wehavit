import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
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
  List<GroupListViewCellWidgetModel>? sharingTargetGroupModelList;

  @override
  void initState() {
    super.initState();
    unawaited(
      loadEntityList().whenComplete(
        () => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
              child: Text(
            '공유 대상',
            style: TextStyle(
              color: CustomColors.whWhite,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          )),
          const SizedBox(
            height: 24,
          ),
          const Text(
            '그룹',
            style: TextStyle(
              color: CustomColors.whWhite,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (sharingTargetGroupModelList != null)
            Column(
              children: List<Widget>.generate(
                sharingTargetGroupModelList!.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ShareTargetGroupListCellWidget(
                    sharingTargetGroupModelList![index],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> loadEntityList() async {
    final entityList = await ref
        .read(getToWhomResolutionWillBeSharedUsecaseProvider)
        .call(resolutionId: widget.entity.resolutionId ?? '')
        .then(
          (result) => result.fold(
            (failure) => null,
            (entityList) => entityList,
          ),
        );

    if (entityList == null) {
      sharingTargetGroupModelList = null;
      return;
    }

    sharingTargetGroupModelList = (await Future.wait(
      entityList.map(
        (entity) => ref.read(getGroupListViewCellWidgetModelUsecaseProvider).call(groupEntity: entity).then(
              (result) => result.fold(
                (failure) => null,
                (model) => model,
              ),
            ),
      ),
    ))
        .nonNulls
        .toList();
  }
}

class ShareTargetGroupListCellWidget extends StatelessWidget {
  const ShareTargetGroupListCellWidget(
    this.groupModel, {
    super.key,
  });

  final GroupListViewCellWidgetModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          groupModel.groupEntity.groupName,
          style: TextStyle(
            color: CustomColors.pointColorList[groupModel.groupEntity.groupColor],
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            const Text(
              '멤버 수',
              style: TextStyle(
                color: CustomColors.whWhite,
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              groupModel.groupEntity.groupMemberUidList.length.toString(),
              style: const TextStyle(
                color: CustomColors.whWhite,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ],
        ),
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            const Text(
              '함께 도전중인 목표 수',
              style: TextStyle(
                color: CustomColors.whWhite,
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            FutureBuilder(
              future: groupModel.sharedResolutionCount,
              builder: (
                BuildContext context,
                AsyncSnapshot<Either<Failure, int>> snapshot,
              ) {
                if (snapshot.hasData) {
                  return snapshot.data!.fold(
                    (failure) => const Text(
                      '0',
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                    (value) => Text(
                      value.toString(),
                      style: const TextStyle(
                        color: CustomColors.whWhite,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  );
                } else {
                  return const Text(
                    '0',
                    style: TextStyle(
                      color: Colors.transparent,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class PhotoThumbnailWidget extends StatelessWidget {
  const PhotoThumbnailWidget({
    super.key,
    required this.viewModel,
    required this.index,
    required this.onRemove,
  });

  final WritingConfirmPostViewModel viewModel;
  final int index;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Image.file(
              File(viewModel.imageMediaList[index].path),
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.cancel,
                size: 20,
                color: CustomColors.whWhite,
              ),
            ),
            onTapUp: (details) {
              onRemove();
            },
          ),
        ],
      ),
    );
  }
}
