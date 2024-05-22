import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/friend_list/view/view.dart';
import 'package:wehavit/presentation/presentation.dart';

class FriendListView extends ConsumerStatefulWidget {
  const FriendListView({super.key});

  static FriendListView builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const FriendListView();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FriendListScreenState();
}

class _FriendListScreenState extends ConsumerState<FriendListView> {
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    ref.read(friendListViewModelProvider.notifier).getFriendList();
  }

  bool isManagingMode = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(friendListViewModelProvider);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '친구 목록',
        trailingTitle: isManagingMode ? '완료' : null,
        trailingIcon: isManagingMode ? null : Icons.manage_accounts_outlined,
        trailingIconBadgeCount: isManagingMode ? null : 3,
        trailingAction: () {
          setState(() {
            isManagingMode = !isManagingMode;
          });
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: isManagingMode,
          replacement: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  print("HE");
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  backgroundColor: CustomColors.whGrey,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: CustomColors.whYellow,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FriendListMyProfileWidget(
                    futureUserEntity: Future.delayed(
                      Duration(seconds: 1),
                      () => right(UserDataEntity.dummyModel),
                      // () => left(Failure("HE")),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Expanded(
                child: EitherFutureBuilder<List<EitherFuture<UserDataEntity>>>(
                  target: viewModel.futureFriendList,
                  forFail: const FriendListFailPlaceholderWidget(),
                  forWaiting: Container(),
                  mainWidgetCallback: (list) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '내 친구들 (${list.length})',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return FriendListCellWidget(
                                futureUserEntity: list[index],
                                cellState: FriendListCellState.normal,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '친구 신청',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  FriendListTextFieldWidget(
                    searchCallback: (searchNickname) {
                      // viewModel 통해 search 하기
                      print(searchNickname);
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  FriendListCellWidget(
                    futureUserEntity: Future.delayed(
                      Duration(seconds: 2),
                      () => right(UserDataEntity.dummyModel),
                    ),
                    cellState: FriendListCellState.toApply,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '새로운 친구 요청',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whWhite,
                    ),
                  ),
                  Column(
                    children: List<Widget>.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: FriendListCellWidget(
                          futureUserEntity: Future.delayed(
                            const Duration(seconds: 2),
                            () => right(UserDataEntity.dummyModel),
                          ),
                          cellState: FriendListCellState.applied,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '내 친구들',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whWhite,
                    ),
                  ),
                  Column(
                    children: List<Widget>.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: FriendListCellWidget(
                          futureUserEntity: Future.delayed(
                            const Duration(seconds: 2),
                            () => right(UserDataEntity.dummyModel),
                          ),
                          cellState: FriendListCellState.managing,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
