import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => MainViewState();
}

class MainViewState extends ConsumerState<MainView>
    with TickerProviderStateMixin {
  late TabController tabController;
  late EitherFuture<UserDataEntity> userDataEntity;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    loadUserData();
    loadResolutionData();
    loadFriendData();
    loadGroupData();
  }

  Future<void> loadUserData() async {
    userDataEntity = ref.read(getMyUserDataUsecaseProvider).call();
    ref.read(friendListViewModelProvider.notifier).getMyUserDataEntity();
  }

  Future<void> loadResolutionData() async {
    ref
        .read(resolutionListViewModelProvider.notifier)
        .loadResolutionModelList()
        .whenComplete(() {
      setState(() {
        ref.watch(resolutionListViewModelProvider).isLoadingView = false;
      });
    });
  }

  Future<void> loadGroupData() async {
    // loadGroupCell
    ref
        .read(groupViewModelProvider.notifier)
        .loadMyGroupCellList()
        .whenComplete(() => setState(() {}));
  }

  Future<void> loadFriendData() async {
    ref
        .read(friendListViewModelProvider.notifier)
        .getAppliedFriendList()
        .whenComplete(() => setState(() {}));

    await ref
        .read(friendListViewModelProvider.notifier)
        .getFriendList()
        .whenComplete(() => setState(() {}));

    // loadFriendCell
    final userIdList = await Future.wait(
      ref
              .read(friendListViewModelProvider)
              .friendFutureUserList
              ?.map((futureFriendEntity) async {
            final result = await futureFriendEntity;
            return result.fold(
              (failure) => null,
              (entity) => entity.userId,
            );
          }).toList() ??
          [],
    );

    final userIdListWithoutNull =
        userIdList.where((userId) => userId != null).cast<String>().toList();

    ref.watch(groupViewModelProvider).friendUidList = userIdListWithoutNull;

    await ref
        .read(groupViewModelProvider.notifier)
        .loadFriendCellWidgetModel(friendUidList: userIdListWithoutNull)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.whDarkBlack,
      body: Stack(
        children: [
          SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const ResolutionListView(),
                    const GroupView(),
                    const FriendListView(),
                    // 페이지 이동 시 데이터 setState 함수 수행을 위해 붙여줌
                    MyPageView(3, tabController),
                  ],
                ),
                SizedBox(
                  height: 64,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const TabBarBackgroundBlurWidget(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TabBar(
                          onTap: (value) {
                            setState(() {});
                          },
                          // dividerHeight: 0,
                          indicatorColor: Colors.transparent,
                          labelColor: CustomColors.whYellow,
                          controller: tabController,
                          dividerColor: Colors.transparent,
                          tabs: [
                            TabBarIconLabelButton(
                              isSelected: tabController.index == 0,
                              iconImageName: CustomIconImage.approvalIcon,
                              label: '인증하기',
                            ),
                            TabBarIconLabelButton(
                              isSelected: tabController.index == 1,
                              iconData: Icons.outlined_flag_rounded,
                              label: '그룹',
                            ),
                            TabBarIconLabelButton(
                              isSelected: tabController.index == 2,
                              iconData: Icons.people_alt_outlined,
                              label: '친구',
                            ),
                            TabBarProfileImageButton(
                              isSelected: tabController.index == 3,
                              futureUserDataEntity: userDataEntity,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const ReactionAnimationWidget(),
        ],
      ),
    );
  }
}
