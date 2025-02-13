import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ResolutionWritingMenuBottomSheet extends StatelessWidget {
  const ResolutionWritingMenuBottomSheet({
    super.key,
    required this.resolutionEntity,
  });

  final ResolutionEntity resolutionEntity;

  @override
  Widget build(BuildContext context) {
    return GradientBottomSheet(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                resolutionEntity.resolutionName,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: context.titleMedium?.copyWith(color: CustomColors.pointColorList[resolutionEntity.colorIndex]),
              ),
              const SizedBox(height: 12.0),
              Text(
                resolutionEntity.goalStatement,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: context.bodyMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              ResolutionLinearGaugeIndicator(
                resolutionEntity: resolutionEntity,
                targetDate: DateTime.now().getMondayDateTime(),
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          Consumer(
            builder: (context, ref, _) {
              return WideColoredButton(
                buttonTitle: '인증글 작성하기',
                foregroundColor: CustomColors.whBlack,
                onPressed: () async {
                  final bool result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WritingConfirmPostView(
                          entity: resolutionEntity,
                          hasRested: false,
                        );
                      },
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(true);

                    showToastMessage(
                      // ignore: use_build_context_synchronously
                      context,
                      text: '성공적으로 인증글을 공유했어요',
                    );
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, ref, _) {
                    return WideOutlinedButton(
                      buttonTitle: '반성 남기기',
                      foregroundColor: Colors.red,
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WritingConfirmPostView(
                                entity: resolutionEntity,
                                hasRested: true,
                              );
                            },
                          ),
                        );
                        if (result == true) {
                          showToastMessage(
                            // ignore: use_build_context_synchronously
                            context,
                            text: '성공적으로 반성글을 공유했어요',
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: Consumer(
                    builder: (context, ref, _) {
                      return WideOutlinedButton(
                        buttonTitle: '완료 표시만 하기',
                        onPressed: () async {
                          ref
                              .read(resolutionListViewModelProvider.notifier)
                              .uploadPostWithoutContents(
                                entity: resolutionEntity,
                              )
                              .whenComplete(() {
                            Navigator.pop(context, true);
                            showToastMessage(
                              context,
                              text: '성공적으로 인증을 남겼어요',
                            );
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          WideColoredButton(
            buttonTitle: '돌아가기',
            backgroundColor: Colors.transparent,
            foregroundColor: CustomColors.whPlaceholderGrey,
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }
}
