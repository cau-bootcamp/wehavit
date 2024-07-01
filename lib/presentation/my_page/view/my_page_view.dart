import 'dart:async';
import 'package:flutter/cupertino.dart';
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

  Future<void> deleteAccount() async {
    ref.watch(myPageViewModelProvider.notifier).deleteAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = ref.watch(myPageViewModelProvider);
    final provider = ref.watch(myPageViewModelProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: CustomColors.whDarkBlack,
          appBar: WehavitAppBar(
            title: '내 정보',
            trailingTitle: '',
            trailingIcon: Icons.menu,
            trailingAction: () async {
              // 변경사항을 TabBar에 알리기 위해 mainViewState를 참조
              MainViewState? mainViewState =
                  context.findAncestorStateOfType<MainViewState>();
              showMyPageMenuBottomSheet(
                context,
                mainViewState,
                deleteAccount,
              );
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
                        replacement: const ResolutionListPlaceholderWidget(),
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
                                onPressed: () async {
                                  showModifyResolutionShareTargetBottomSheet(
                                    context,
                                    () {},
                                    resolutionList[index],
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
        ),
      ],
    );
  }

  Future<dynamic> showMyPageMenuBottomSheet(
    BuildContext context,
    MainViewState? mainViewState,
    Function() deleteAccount,
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
                buttonTitle: '회원탈퇴',
                buttonIcon: Icons.no_accounts_outlined,
                foregroundColor: PointColors.red,
                onPressed: () async {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text('정말 탈퇴하시겠어요?'),
                        content: const Text('작성하신 인증글의 복구가 불가능합니다'),
                        actions: [
                          CupertinoDialogAction(
                            textStyle: const TextStyle(
                              color: PointColors.blue,
                            ),
                            isDefaultAction: true,
                            child: const Text('취소'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: deleteAccount,
                            child: const Text('탈퇴하기'),
                          ),
                        ],
                      );
                    },
                  ).then((result) {
                    if (result == false) {
                      showToastMessage(
                        context,
                        text: '오류 발생, 문의 부탁드립니다',
                        icon: const Icon(
                          Icons.report_problem,
                          color: CustomColors.whYellow,
                        ),
                      );
                    }
                  });
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

  Future<dynamic> showModifyResolutionShareTargetBottomSheet(
    BuildContext context,
    Function() deleteAccount,
    ResolutionEntity entity,
  ) {
    ref.watch(addResolutionDoneViewModelProvider).resolutionEntity = entity;
    final provider = ref.read(addResolutionDoneViewModelProvider.notifier);

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return GradientBottomSheet(
          Column(
            children: [
              WideColoredButton(
                buttonTitle: '목표 공유 친구 수정하기',
                buttonIcon: Icons.people_alt_outlined,
                onPressed: () async {
                  provider.loadFriendList().whenComplete(() async {
                    await provider.resetTempFriendList();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => GradientBottomSheet(
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child:
                              const ShareResolutionToFriendBottomSheetWidget(),
                        ),
                      ),
                    );
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideColoredButton(
                buttonTitle: '목표 공유 그룹 수정하기',
                buttonIcon: Icons.flag_outlined,
                onPressed: () async {
                  provider.loadGroupList().whenComplete(
                    () async {
                      await provider.resetTempGroupList();
                      showModalBottomSheet(
                        isScrollControlled: true,
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (context) => GradientBottomSheet(
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.82,
                            child:
                                const ShareResolutionToGroupBottomSheetWidget(),
                          ),
                        ),
                      );
                    },
                  );
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
