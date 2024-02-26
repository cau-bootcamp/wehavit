import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class WritingConfirmPostView extends ConsumerStatefulWidget {
  const WritingConfirmPostView({required this.entity, super.key});
  final ResolutionEntity entity;

  @override
  ConsumerState<WritingConfirmPostView> createState() =>
      _WritingConfirmPostViewState();
}

class _WritingConfirmPostViewState
    extends ConsumerState<WritingConfirmPostView> {
  @override
  void initState() {
    super.initState();
    ref.watch(writingConfirmPostViewModelProvider).entity = widget.entity;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(writingConfirmPostViewModelProvider);
    final provider = ref.read(writingConfirmPostViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: wehavitAppBar(
        title: '인증 남기기',
        leadingTitle: '목표 선택',
        leadingIcon: Icons.chevron_left,
        leadingAction: () {
          Navigator.pop(context);
        },
        trailingTitle: '공유 대상',
        trailingIcon: Icons.cloud_upload_outlined,
        trailingAction: () async {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return GradientBottomSheet(
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.80,
                  child: const ShareTargetGroupCellWidget(),
                ),
              );
            },
          );
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy년 M월 d일').format(
                    viewModel.todayDate.subtract(
                      Duration(
                        days: viewModel.isWritingYesterdayPost ? 1 : 0,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: CustomColors.whSemiWhite,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    viewModel.isWritingYesterdayPost =
                        !viewModel.isWritingYesterdayPost;
                    setState(() {});
                  },
                  icon: Icon(
                    size: 20,
                    viewModel.isWritingYesterdayPost
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: viewModel.isWritingYesterdayPost
                        ? CustomColors.whYellow
                        : CustomColors.whSemiWhite,
                  ),
                  label: Text(
                    '전날 기록하기',
                    style: TextStyle(
                      color: viewModel.isWritingYesterdayPost
                          ? CustomColors.whYellow
                          : CustomColors.whSemiWhite,
                      fontSize: 16.0,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
            Text(
              widget.entity.goalStatement ?? '',
              style: TextStyle(
                color: PointColors.colorList[widget.entity.colorIndex ?? 0],
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.entity.actionStatement ?? '',
              style: const TextStyle(
                color: CustomColors.whSemiWhite,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: TextFormField(
                maxLines: null,
                autofocus: true,
                style: const TextStyle(
                  color: CustomColors.whWhite,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '오늘의 발자국을 남겨주세요',
                  hintStyle: TextStyle(
                    color: CustomColors.whPlaceholderGrey.withAlpha(200),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: viewModel.imageMediaList.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: List<Widget>.generate(
                    viewModel.imageMediaList.length,
                    (index) => PhotoThumbnailWidget(
                      viewModel: viewModel,
                      index: index,
                      onRemove: () {
                        viewModel.imageMediaList.removeAt(index);
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    provider.pickPhotos().whenComplete(() => setState(() {}));
                  },
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: CustomColors.whWhite,
                  ),
                  style: IconButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '인증샷은 최대 3장까지 공유할 수 있어요',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.whPlaceholderGrey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Text(
                    '공유하기',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whYellow,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
