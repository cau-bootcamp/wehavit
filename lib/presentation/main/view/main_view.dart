import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => MainViewState();
}

class MainViewState extends ConsumerState<MainView> with TickerProviderStateMixin {
  late TabController tabController;

  Future<void> updateFCMMessageToken() async {
    FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      FirebaseUserFieldName.messageToken: await FirebaseMessaging.instance.getToken(),
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);

    unawaited(ref.read(mainViewModelProvider.notifier).updateFCMToken());
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
    ref.read(myPageViewModelProvider.notifier).loadData();
    // ref.read(friendListViewModelProvider.notifier).getMyUserDataEntity();
  }

  Future<void> loadResolutionData() async {
    // 인증 리스트의 목표 셀 로드
    ref.read(resolutionListViewModelProvider.notifier).loadResolutionModelList().whenComplete(() {
      setState(() {
        ref.watch(resolutionListViewModelProvider).isLoadingView = false;
      });
    });
  }

  Future<void> loadGroupData() async {
    // 그룹리스트의 그룹 셀 로드
    ref.read(groupViewModelProvider.notifier).loadMyGroupCellList().whenComplete(() => setState(() {}));
  }

// TODO: 제거하기
  Future<void> loadFriendData() async {
    // 친구리스트 셀 로드
    // ref.read(friendListViewModelProvider.notifier).getAppliedFriendList().whenComplete(() => setState(() {}));

    await ref.read(friendListViewModelProvider.notifier).getFriendList().whenComplete(() => setState(() {}));

    // 그룹리스트의 친구 셀 로드
    // final userIdList = ref.read(friendListProvider).whenData((data) => data.map((e) => e.userId).toList());
    // final userIdList = await Future.wait(
    //   ref.read(friendListViewModelProvider).friendFutureUserList?.map((futureFriendEntity) async {
    //         final result = await futureFriendEntity;
    //         return result.fold(
    //           (failure) => null,
    //           (entity) => entity.userId,
    //         );
    //       }).toList() ??
    //       [],
    // );

    // final userIdListWithoutNull = userIdList.where((userId) => userId != null).cast<String>().toList();

    // ref.watch(groupViewModelProvider).friendUidList = userIdListWithoutNull;

    // await ref
    //     .read(groupViewModelProvider.notifier)
    //     .loadFriendCellWidgetModel(friendUidList: userIdListWithoutNull)
    //     .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // final myPageViewModel = ref.watch(myPageViewModelProvider);
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
                              futureUserDataEntity: Future(() => right(ref.read(getMyUserDataProvider).value!)),
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
          ReactionAnimationWidget(
            key: ref.watch(reactionAnimationWidgetKeyProvider),
          ),
        ],
      ),
    );
  }
}
