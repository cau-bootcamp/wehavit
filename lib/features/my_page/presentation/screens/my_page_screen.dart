import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/src/either.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/presentation/providers/my_page_resolution_list_provider.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_dashboard_widget.dart';

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
    ref.read(myPageResolutionListProvider.notifier).getActiveResolutionList();
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
                    .getActiveResolutionList();
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
          (List<ResolutionModel>, List<Future<List<ConfirmPostModel>>>)>
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
                return ResolutionDashboardWidget(
                  model: right.$1[index],
                  confirmPostList: right.$2[index],
                );
              } else {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(border: Border.all()),
                  height: 150,
                  child: TextButton(
                    onPressed: () async {
                      context.push('/addResolution');
                    },
                    child: const Center(
                      child: Text(
                        '추가하기',
                        style: TextStyle(color: Colors.black),
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
