import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';

class MyPageView extends ConsumerStatefulWidget {
  const MyPageView(this.index, this.tabController, {super.key});

  final int index;
  final TabController tabController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyPageScreenState();
}

class MyPageScreenState extends ConsumerState<MyPageView> with AutomaticKeepAliveClientMixin<MyPageView> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabChange);
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
    // final viewModel = ref.watch(myPageViewModelProvider);
    final provider = ref.watch(myPageViewModelProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: CustomColors.whDarkBlack,
          appBar: WehavitAppBar(
            titleLabel: '내 정보',
            trailingIconString: WHIcons.menu,
            trailingAction: () async {
              // 변경사항을 TabBar에 알리기 위해 mainViewState를 참조
              MainViewState? mainViewState = context.findAncestorStateOfType<MainViewState>();
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
                  const MyWehavitSummary(),
                  // MyWehavitSummary(
                  //   futureUserEntity: ref.read(getMyUserDataProvider).value!,
                  // ),
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
                  Consumer(
                    builder: (context, ref, child) {
                      final asyncResolutionList = ref.watch(resolutionListNotifierProvider);

                      return asyncResolutionList.when(
                        data: (resolutionList) {
                          return Visibility(
                            replacement: const ResolutionListPlaceholderWidget(),
                            visible: resolutionList.isNotEmpty,
                            child: Column(
                              children: List<Widget>.generate(
                                resolutionList.length,
                                (index) => Container(
                                  margin: const EdgeInsets.only(bottom: 16.0),
                                  child: ResolutionListCell(
                                    resolutionEntity: resolutionList[index],
                                    showDetails: true,
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResolutionDetailView(
                                            entity: resolutionList[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        error: (_, __) => Container(),
                        loading: () => Container(),
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
              WideOutlinedButton(
                buttonTitle: '내 정보 수정하기',
                iconString: WHIcons.manageMyInfo,
                onPressed: () async {
                  final userEntity = await ref.read(getMyUserDataUsecaseProvider).call().then((result) {
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
                            // isModifying: true,
                            userId: userEntity.userId,
                            // profileImageUrl: userEntity.userImageUrl,
                            // name: userEntity.userName,
                            // handle: userEntity.handle,
                            // aboutMe: userEntity.aboutMe,
                          );
                        },
                      ),
                    ).then((result) {
                      if (result == true) {
                        mainViewState?.setState(() {});
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
              WideOutlinedButton(
                buttonTitle: '로그아웃',
                iconString: WHIcons.logout,
                onPressed: () async {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text('정말 로그아웃하시겠어요?'),
                        actions: [
                          CupertinoDialogAction(
                            textStyle: const TextStyle(
                              color: CustomColors.pointBlue,
                            ),
                            isDefaultAction: true,
                            child: const Text('취소'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () async {
                              await ref.read(logOutUseCaseProvider).call();
                              ref.invalidate(getMyUserDataUsecaseProvider);
                              if (mounted) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(context, '/entrance');
                              }
                            },
                            child: const Text('로그아웃'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WideOutlinedButton(
                buttonTitle: '회원탈퇴',
                iconString: WHIcons.withdraw,
                foregroundColor: CustomColors.pointRed,
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
                              color: CustomColors.pointBlue,
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
}
