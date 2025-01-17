import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(writingConfirmPostViewModelProvider).entity = widget.entity;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(writingConfirmPostViewModelProvider);
    final provider = ref.read(writingConfirmPostViewModelProvider.notifier);

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
            trailingTitle: '공유 대상',
            trailingAction: () async {
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
                              viewModel.isWritingYesterdayPost = !viewModel.isWritingYesterdayPost;
                              setState(() {});
                            },
                            icon: Icon(
                              size: 20,
                              viewModel.isWritingYesterdayPost ? Icons.check_box : Icons.check_box_outline_blank,
                              color:
                                  viewModel.isWritingYesterdayPost ? CustomColors.whYellow : CustomColors.whSemiWhite,
                            ),
                            label: Text(
                              '전날 기록하기',
                              style: TextStyle(
                                color:
                                    viewModel.isWritingYesterdayPost ? CustomColors.whYellow : CustomColors.whSemiWhite,
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
                        widget.entity.goalStatement,
                        style: TextStyle(
                          color: CustomColors.pointColorList[widget.entity.colorIndex],
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.entity.actionStatement,
                        style: const TextStyle(
                          color: CustomColors.whSemiWhite,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          focusNode: contentFieldFocusNode,
                          maxLines: null,
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
                                  imageFile: File(viewModel.imageMediaList[index].path),
                                  state: UploadPhotoCellState.failed,
                                  onCancel: () {
                                    setState(() {
                                      viewModel.imageMediaList.removeAt(index);
                                    });
                                  },
                                  onRetry: () {},
                                ),
                              ),
                              // PhotoThumbnailWidget(
                              //   viewModel: viewModel,
                              //   index: index,
                              //   onRemove: () {
                              //     viewModel.imageMediaList.removeAt(index);
                              //     setState(() {});
                              //   },
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              UploadPhotoBottomToolbar(
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
                  viewModel.isUploading = true;
                  setState(() {});

                  final myUserEntity = await ref.read(getMyUserDataProvider.future);

                  await provider
                      .uploadPost(
                    hasRested: widget.hasRested,
                    myUserEntity: myUserEntity,
                  )
                      .whenComplete(() {
                    viewModel.isUploading = false;

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(true);
                  });
                },
              ),
            ],
          ),
        ),
        Visibility(
          visible: viewModel.isUploading,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: CustomColors.whDarkBlack.withAlpha(100),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      color: CustomColors.whYellow,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    '업로드 중입니다',
                    style: TextStyle(
                      color: CustomColors.whWhite,
                      fontSize: 16.0,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
