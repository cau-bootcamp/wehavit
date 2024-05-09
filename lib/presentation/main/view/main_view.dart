import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/common/utils/icon_assets.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/friend_list/screens/friend_list_screen.dart';
import 'package:wehavit/presentation/group/group.dart';
import 'package:wehavit/presentation/main/view/main_view_widget.dart';
import 'package:wehavit/presentation/my_page/my_page.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

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
      body: Container(
        child: Stack(
          children: [
            TabBarView(
              controller: tabController,
              children: [
                ResolutionListView(),
                GroupView(),
                FriendListScreen(),
                MyPageScreen(),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Stack(
                  children: [
                    IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45.withOpacity(0.1),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: BackdropFilter(
                          filter:
                              ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: TabBar(
                        onTap: (value) {
                          setState(() {});
                        },
                        dividerHeight: 0,
                        indicatorColor: Colors.transparent,
                        labelColor: CustomColors.whYellow,
                        controller: tabController,
                        tabs: [
                          TabBarIconLabelButton(
                            isSelected: tabController.index == 0,
                            iconImageName: CustomIconImage.approvalIcon,
                            label: '인증하기',
                          ),
                          TabBarIconLabelButton(
                            isSelected: tabController.index == 1,
                            iconImageName: CustomIconImage.approvalIcon,
                            label: '그룹',
                          ),
                          TabBarIconLabelButton(
                            isSelected: tabController.index == 2,
                            iconImageName: CustomIconImage.approvalIcon,
                            label: '친구',
                          ),
                          TabBarProfileImageButton(
                            isSelected: tabController.index == 3,
                            futureUserDataEntity: userDataEntity,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
