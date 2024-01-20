import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/effects/effects.dart';

class MyPageScreen extends ConsumerStatefulWidget {
  const MyPageScreen({super.key});

  static MyPageScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const MyPageScreen();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageScreen> {
  @override
  void initState() {
    ref.read(myPageResolutionListProvider.notifier).getMyActiveResolutionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var resolutionListProvider = ref.watch(myPageResolutionListProvider);
    var currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.whBlack,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: CustomColors.whSemiWhite),
            onPressed: () async {
              context.go(RouteLocation.home);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: CustomColors.whBlack,
        ),
        child: Column(
          children: [
            // 내 프로필
            MyProfile(currentUser: currentUser),
            // 모든 목표 통계 확인하기
            CheckAllWidget(ref: ref),
            // 내 목표 리스트
            MyResolutionListWidget(
                resolutionListProvider: resolutionListProvider),
          ],
        ),
      ),
    );
  }
}

class CheckAllWidget extends StatelessWidget {
  const CheckAllWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              top: 12,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            child: TextButton(
              onPressed: () async {
                await ref
                    .read(myPageResolutionListProvider.notifier)
                    .getMyActiveResolutionList();
              },
              style: TextButton.styleFrom(
                backgroundColor: CustomColors.whYellowDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 모서리 둥글게
                ),
              ),
              child: const Text(
                '전체 통계 확인하기',
                style: TextStyle(
                  color: CustomColors.whSemiWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyResolutionListWidget extends StatelessWidget {
  const MyResolutionListWidget({
    super.key,
    required this.resolutionListProvider,
  });

  final Either<Failure,
          (List<ResolutionEntity>, List<Future<List<ConfirmPostEntity>>>)>
      resolutionListProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: resolutionListProvider.fold(
        (left) => null,
        (right) => Expanded(
          child: ListView.builder(
            itemCount: right.$1.length + 1,
            itemBuilder: (context, index) {
              if (index < right.$1.length) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: CustomColors.whGrey,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 16.0),
                          child: Row(
                            children: [
                              Text(
                                right.$1[index].goalStatement!,
                                style: const TextStyle(
                                  color: CustomColors.whWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                '${DateTime.now().difference(right.$1[index].startDate!).inDays.toString()}일차',
                                style: const TextStyle(
                                  color: CustomColors.whYellow,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 2,
                            color: CustomColors.whYellow,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SwipeDashboardWidget(
                            confirmPostList: right.$2[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  height: 150,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    // 모서리 둥글기
                    radius: const Radius.circular(16),
                    padding: const EdgeInsets.all(6),
                    // 점선의 길이와 간격
                    dashPattern: const [12, 8],
                    // 선의 두께
                    strokeWidth: 3,
                    color: CustomColors.whGrey,
                    child: TextButton(
                      onPressed: () async {
                        context.push('/addResolution');
                      },
                      child: const Center(
                        child: Text(
                          '새 목표 추가하기',
                          style: TextStyle(
                            color: CustomColors.whGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ) as Widget,
    );
  }
}
