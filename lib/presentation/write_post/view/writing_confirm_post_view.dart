import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/image_uploader.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

class WritingConfirmPostView extends ConsumerStatefulWidget {
  const WritingConfirmPostView({
    required this.entity,
    required this.hasRested,
    super.key,
  });
  final ResolutionEntity entity;
  final bool hasRested;

  @override
  ConsumerState<WritingConfirmPostView> createState() => _WritingConfirmPostViewState();
}

class _WritingConfirmPostViewState extends ConsumerState<WritingConfirmPostView> {
  FocusNode contentFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    contentFieldFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(writingConfirmPostViewModelProvider(widget.entity));
    final provider = ref.read(writingConfirmPostViewModelProvider(widget.entity).notifier);

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: CustomColors.whDarkBlack,
          appBar: WehavitAppBar(
            titleLabel: widget.hasRested ? '반성글 남기기' : '인증 남기기',
            leadingIconString: WHIcons.back,
            leadingAction: () {
              Navigator.of(context).pop(false);
            },
            trailingIconString: WHIcons.shareTo,
            trailingAction: () async {
              showShareTargetBottomSheet(context);
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: SafeArea(
                  minimum: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
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
                                Duration(days: viewModel.isWritingYesterdayPost ? 1 : 0),
                              ),
                            ),
                            style: context.labelLarge,
                          ),
                          TextButton.icon(
                            onPressed: () {
                              provider.toggleYesterdayOption();
                            },
                            icon: Icon(
                              size: 20,
                              viewModel.isWritingYesterdayPost ? Icons.check_box : Icons.check_box_outline_blank,
                              color:
                                  viewModel.isWritingYesterdayPost ? CustomColors.whYellow500 : CustomColors.whGrey900,
                            ),
                            label: Text(
                              '전날 기록하기',
                              style: context.labelLarge?.copyWith(
                                color: viewModel.isWritingYesterdayPost
                                    ? CustomColors.whYellow500
                                    : CustomColors.whGrey900,
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
                        widget.entity.goalStatement,
                        style: context.titleSmall?.copyWith(
                          color: CustomColors.pointColorList[widget.entity.colorIndex],
                        ),
                      ),
                      Text(
                        widget.entity.actionStatement,
                        style: context.bodyMedium,
                      ),
                      Expanded(
                        child: TextFormField(
                          focusNode: contentFieldFocusNode,
                          maxLines: null,
                          style: context.bodyMedium,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '오늘의 발자국을 남겨주세요',
                            hintStyle: context.bodyMedium?.copyWith(color: CustomColors.whGrey600),
                          ),
                          onChanged: (value) {
                            viewModel.postContent = value;
                          },
                        ),
                      ),
                      Visibility(
                        visible: viewModel.imageMediaList.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: List<Widget>.generate(
                              viewModel.imageMediaList.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: UploadPhotoCell(
                                  imageFile: File(viewModel.imageMediaList[index].imageFile.path),
                                  state: viewModel.imageMediaList[index].status,
                                  onCancel: () {
                                    provider.cancelPhotoUpload(viewModel.imageMediaList[index]);
                                  },
                                  onRetry: () async {
                                    provider.reuploadPhoto(viewModel.imageMediaList[index]);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              UploadPhotoBottomToolbar(
                type: widget.hasRested ? UploadPhotoBottomToolbarType.regret : UploadPhotoBottomToolbarType.upload,
                onIconPressed: () async {
                  if (!widget.hasRested) {
                    FocusScope.of(context).unfocus();
                    provider.pickPhotos().whenComplete(
                          () => setState(() {
                            Future.delayed(
                              const Duration(
                                milliseconds: 100,
                              ),
                              () => contentFieldFocusNode.requestFocus(),
                            );
                          }),
                        );
                  }
                },
                onActionPressed: () async {
                  // 넘길 수 있는지 확인
                  if (!ref
                      .read(writingConfirmPostViewModelProvider(widget.entity))
                      .imageMediaList
                      .every((entity) => entity.status == ImageUploadStatus.success)) {
                    showToastMessage(context, text: '아직 업로드 중이거나 업로드에 실패한 사진이 있어요');
                    return;
                  }

                  final myUserEntity = await ref.read(getMyUserDataProvider.future);

                  await provider
                      .uploadPost(
                    hasRested: widget.hasRested,
                    myUserEntity: myUserEntity,
                  )
                      .whenComplete(() {
                    if (context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> showShareTargetBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GradientBottomSheet(
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.80,
            child: ShareTargetGroupCellWidget(widget.entity),
          ),
        );
      },
    );
  }
}
