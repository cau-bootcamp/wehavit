import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/app_colors.dart';
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
  void initState() {
    super.initState();
    unawaited(
      ref
          .read(resolutionListViewModelProvider.notifier)
          .loadResolutionModelList()
          .whenComplete(() {
        setState(() {
          ref.watch(resolutionListViewModelProvider).isLoadingView = false;
        });
      }),
    );
  }

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
            provider
                .loadResolutionModelList()
                .whenComplete(() => setState(() {}));
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
                    (index) => GestureDetector(
                      child: ResolutionListCellWidget(
                        resolutionEntity:
                            viewModel.resolutionModelList![index].entity,
                        showDetails: false,
                      ),
                      onTapUp: (details) async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return WritingResolutionBottomSheetWidget(
                              viewModel: viewModel,
                              provider: provider,
                              index: index,
                            );
                          },
                        ).whenComplete(() {
                          provider
                              .loadResolutionModelList()
                              .whenComplete(() => setState(() {}));
                        });
                      },
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
                        );
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
                viewModel.resolutionModelList![index].entity.goalStatement ??
                    '',
                style: TextStyle(
                  color: PointColors.colorList[0],
                  fontSize: 18.0,
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
                  buttonTitle: '반성글 작성하기',
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
                        Navigator.pop(context);
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
            isDiminished: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
