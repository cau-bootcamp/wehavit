import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyPageView extends ConsumerStatefulWidget {
  const MyPageView(this.index, this.tabController, {super.key});

  final int index;
  final TabController tabController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageView>
    with AutomaticKeepAliveClientMixin<MyPageView> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabChange);

    unawaited(ref.read(myPageViewModelProvider.notifier).loadData());
  }

  @override
  void dispose() {
    // 리스너 제거
    widget.tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (widget.tabController.index == widget.index) {
      // 탭바에서 화면이 MainView로 전환되면 setState를 호출
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = ref.watch(myPageViewModelProvider);
    final provider = ref.watch(myPageViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '내 정보',
        trailingTitle: '',
        trailingIcon: Icons.menu,
        trailingAction: () async {
          // 변경사항을 TabBar에 알리기 위해 mainViewState를 참조
          MainViewState? mainViewState =
              context.findAncestorStateOfType<MainViewState>();
          showMyPageMenuBottomSheet(context, mainViewState);
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            provider.loadData().whenComplete(() {
              setState(() {});
            });
          },
          child: ListView(
            padding: const EdgeInsets.only(bottom: 64.0),
            children: [
              // 내 프로필
              MyPageWehavitSummaryWidget(
                futureUserEntity: viewModel.futureMyUserDataEntity,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                '도전중인 목표',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              EitherFutureBuilder<List<ResolutionEntity>>(
                target: viewModel.futureMyyResolutionList,
                forWaiting: Container(),
                forFail: Container(),
                mainWidgetCallback: (resolutionList) {
                  return Visibility(
                    replacement: ResolutionListPlaceholderWidget(),
                    visible: resolutionList.isNotEmpty,
                    child: Column(
                      children: List<Widget>.generate(
                        resolutionList.length,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: CustomColors.whSemiBlack,
                              shadowColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              overlayColor: PointColors.colorList[
                                  resolutionList[index].colorIndex ?? 0],
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            onPressed: () {
                              showToastMessage(
                                context,
                                text: '현재 개발중인 기능입니다!',
                                icon: const Icon(
                                  Icons.warning,
                                  color: CustomColors.whYellow,
                                ),
                              );
                            },
                            child: ResolutionListCellWidget(
                              resolutionEntity: resolutionList[index],
                              showDetails: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showMyPageMenuBottomSheet(
    BuildContext context,
    MainViewState? mainViewState,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return GradientBottomSheet(
          Column(
            children: [
              WideColoredButton(
                buttonTitle: '내 정보 수정하기',
                buttonIcon: Icons.person,
                onPressed: () async {
                  final userEntity = await ref
                      .read(getMyUserDataUsecaseProvider)
                      .call()
                      .then((result) {
                    return result.fold((failure) {
                      return null;
                    }, (entity) {
                      return entity;
                    });
                  });
                  if (userEntity != null) {
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditUserDetailView(
                            isModifying: true,
                            uid: userEntity.userId,
                            profileImageUrl: userEntity.userImageUrl,
                            name: userEntity.userName,
                            handle: userEntity.handle,
                            aboutMe: userEntity.aboutMe,
                          );
                        },
                      ),
                    ).then((result) {
                      if (result == true) {
                        mainViewState?.loadUserData();

                        ref
                            .read(myPageViewModelProvider.notifier)
                            .getMyUserData()
                            .whenComplete(() {
                          setState(() {});
                        });
                      }

                      Navigator.pop(context);
                    });
                  }
                },
                // isDiminished: true,
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '로그아웃',
                buttonIcon: Icons.person_off_outlined,
                onPressed: () async {
                  await ref.read(logOutUseCaseProvider).call();
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/entrance');
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '돌아가기',
                backgroundColor: Colors.transparent,
                foregroundColor: CustomColors.whPlaceholderGrey,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
