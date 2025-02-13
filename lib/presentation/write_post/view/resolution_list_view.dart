import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/utils/datetime+.dart';
import 'package:wehavit/common/utils/preference_key.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';

class ResolutionListView extends ConsumerStatefulWidget {
  const ResolutionListView({super.key});

  @override
  ConsumerState<ResolutionListView> createState() => _ResolutionListViewState();
}

class _ResolutionListViewState extends ConsumerState<ResolutionListView>
    with AutomaticKeepAliveClientMixin<ResolutionListView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final provider = ref.read(resolutionListViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: const WehavitAppBar(
        titleLabel: '인증 남기기',
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(myWeeklyResolutionSummaryProvider);
            ref.invalidate(resolutionListNotifierProvider);
            ref.invalidate(weeklyResolutionInfoProvider);
          },
          child: ListView(
            children: [
              const WeeklyResolutionSummaryCard(),
              const SizedBox(height: 16.0),
              Consumer(
                builder: (context, ref, child) {
                  final asyncResolutionList = ref.watch(resolutionListNotifierProvider);

                  return asyncResolutionList.when(
                    data: (resolutionList) {
                      return Column(
                        children: List<Widget>.generate(
                          resolutionList.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: ResolutionListCell(
                              onPressed: () async {
                                final isGuideShown = await SharedPreferences.getInstance().then((instance) {
                                  return instance.getBool(PreferenceKey.isWritingPostGuideShown);
                                });

                                if (isGuideShown == null || isGuideShown == false) {
                                  // ignore: use_build_context_synchronously
                                  showGuideBottomSheet(context).whenComplete(() async {
                                    await SharedPreferences.getInstance().then((instance) {
                                      instance.setBool(
                                        PreferenceKey.isWritingPostGuideShown,
                                        true,
                                      );
                                    });
                                    showWritingOptionBottomSheet(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      resolutionList[index],
                                    );
                                  });
                                } else {
                                  showWritingOptionBottomSheet(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    resolutionList[index],
                                  );
                                }
                              },
                              resolutionEntity: ref.watch(resolutionListNotifierProvider).value![index],
                              showDetails: false,
                            ),
                          ),
                        )
                            .append(
                              ListDashOutlinedCell(
                                buttonLabel: '새로운 목표 추가하기',
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => const AddResolutionView(),
                                    ),
                                  ).whenComplete(() async {
                                    ref.invalidate(myWeeklyResolutionSummaryProvider);
                                    ref.invalidate(resolutionListNotifierProvider);
                                  });
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                    error: (_, __) {
                      return Container();
                    },
                    loading: () {
                      return Container();
                    },
                  );
                },
              ),
              Container(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showWritingOptionBottomSheet(
    BuildContext context,
    ResolutionEntity resolutionEntity,
  ) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) => WritingResolutionBottomSheetWidget(
        resolutionEntity: resolutionEntity,
      ),
    );
  }

  Future<dynamic> showGuideBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => GradientBottomSheet(
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.80,
          child: const WritingPostGuideView(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class WritingResolutionBottomSheetWidget extends StatelessWidget {
  const WritingResolutionBottomSheetWidget({
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
                style: TextStyle(
                  color: CustomColors.pointColorList[resolutionEntity.colorIndex],
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                resolutionEntity.goalStatement,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ResolutionLinearGaugeIndicator(
                resolutionEntity: resolutionEntity,
                targetDate: DateTime.now().getMondayDateTime(),
                // weeklyDoneList: viewModel.resolutionModelList![index].doneList,
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
                    return WideColoredButton(
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
                      return WideColoredButton(
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
