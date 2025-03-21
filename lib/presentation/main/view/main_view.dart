import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/presentation.dart';

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
                bottomTabBar(),
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

  SizedBox bottomTabBar() {
    return SizedBox(
      height: 60,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
