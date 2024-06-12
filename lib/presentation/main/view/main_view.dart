import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView>
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

    userDataEntity = ref.read(getMyUserDataUsecaseProvider).call();
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
                    ResolutionListView(0, tabController),
                    GroupView(1, tabController),
                    FriendListView(2, tabController),
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
