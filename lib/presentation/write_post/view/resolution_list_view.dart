import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/utils/preference_key.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';

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
    final viewModel = ref.watch(resolutionListViewModelProvider);
    final provider = ref.read(resolutionListViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '인증 남기기',
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            provider.loadResolutionModelList().whenComplete(() {
              setState(() {
                ref.watch(resolutionListViewModelProvider).isLoadingView =
                    false;
              });
            });
          },
          child: ListView(
            children: [
              ResolutionSummaryCardWidget(
                futureDoneRatio: viewModel.futureDoneRatio,
                futureDoneCount: viewModel.futureDoneCount,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Visibility(
                visible: !viewModel.isLoadingView,
                replacement: const Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: CustomColors.whYellow,
                      ),
                    ),
                  ),
                ),
                child: Column(
                  children: List<Widget>.generate(
                    viewModel.resolutionModelList?.length ?? 0,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: CustomColors.whSemiBlack,
                          shadowColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          overlayColor: PointColors.colorList[viewModel
                                  .resolutionModelList![index]
                                  .entity
                                  .colorIndex ??
                              0],
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () async {
                          final isGuideShown =
                              await SharedPreferences.getInstance()
                                  .then((instance) {
                            return instance
                                .getBool(PreferenceKey.isWritingPostGuideShown);
                          });

                          if (isGuideShown == null || isGuideShown == false) {
                            // ignore: use_build_context_synchronously
                            showGuideBottomSheet(context)
                                .whenComplete(() async {
                              await SharedPreferences.getInstance()
                                  .then((instance) {
                                instance.setBool(
                                  PreferenceKey.isWritingPostGuideShown,
                                  true,
                                );
                              });
                              showWritingOptionBottomSheet(
                                // ignore: use_build_context_synchronously
                                context,
                                viewModel,
                                provider,
                                index,
                              ).then((returnValue) async {
                                if (returnValue == true) {
                                  await provider
                                      .loadResolutionModelList()
                                      .whenComplete(() {
                                    ref
                                        .watch(resolutionListViewModelProvider)
                                        .isLoadingView = false;
                                  });
                                } else {
                                  //
                                }
                              });
                            });
                          } else {
                            showWritingOptionBottomSheet(
                              // ignore: use_build_context_synchronously
                              context,
                              viewModel,
                              provider,
                              index,
                            ).then((returnValue) async {
                              if (returnValue == true) {
                                await provider
                                    .loadResolutionModelList()
                                    .whenComplete(() {
                                  ref
                                      .watch(resolutionListViewModelProvider)
                                      .isLoadingView = false;
                                });
                              } else {
                                //
                              }
                            });
                          }
                        },
                        child: ResolutionListCellWidget(
                          resolutionEntity:
                              viewModel.resolutionModelList![index].entity,
                          showDetails: false,
                        ),
                      ),
                    ),
                  ).append(
                    AddResolutionCellWidget(
                      tapAddResolutionCallback: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const AddResolutionView(),
                          ),
                        ).whenComplete(() async {
                          await ref
                              .watch(myPageViewModelProvider.notifier)
                              .getMyResolutionListUsecase();
                          await provider
                              .loadResolutionModelList()
                              .whenComplete(() {
                            setState(() {
                              ref
                                  .watch(resolutionListViewModelProvider)
                                  .isLoadingView = false;
                            });
                          });
                        });
                      },
                    ),
                  ).toList(),
                ),
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
    ResolutionListViewModel viewModel,
    ResolutionListViewModelProvider provider,
    int index,
  ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => WritingResolutionBottomSheetWidget(
        viewModel: viewModel,
        provider: provider,
        index: index,
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
    required this.viewModel,
    required this.provider,
    required this.index,
  });

  final ResolutionListViewModel viewModel;
  final ResolutionListViewModelProvider provider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GradientBottomSheet(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                viewModel.resolutionModelList![index].entity.resolutionName ??
                    '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: PointColors.colorList[
                      viewModel.resolutionModelList![index].entity.colorIndex ??
                          0],
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                viewModel.resolutionModelList![index].entity.goalStatement ??
                    '',
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
              ResolutionLinearGaugeWidget(
                resolutionEntity: viewModel.resolutionModelList![index].entity,
                futureDoneList: viewModel.resolutionModelList![index].doneList,
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          WideColoredButton(
            buttonTitle: '인증글 작성하기',
            backgroundColor: CustomColors.whYellow,
            foregroundColor: CustomColors.whBlack,
            onPressed: () async {
              final bool result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WritingConfirmPostView(
                      entity: viewModel.resolutionModelList![index].entity,
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
                  icon: const Icon(
                    Icons.check_circle,
                    color: CustomColors.whYellow,
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: WideColoredButton(
                  buttonTitle: '반성 남기기',
                  foregroundColor: Colors.red,
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WritingConfirmPostView(
                            entity:
                                viewModel.resolutionModelList![index].entity,
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
                        icon: const Icon(
                          Icons.check_circle,
                          color: CustomColors.whYellow,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: WideColoredButton(
                    buttonTitle: '완료 표시만 하기',
                    onPressed: () async {
                      provider
                          .uploadPostWithoutContents(
                        model: viewModel.resolutionModelList![index],
                      )
                          .whenComplete(() {
                        Navigator.pop(context, true);
                        // ignore: use_build_context_synchronously
                        showToastMessage(
                          context,
                          text: '성공적으로 인증을 남겼어요',
                          icon: const Icon(
                            Icons.check_circle,
                            color: CustomColors.whYellow,
                          ),
                        );
                      });
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
