import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/my_page/presentation/providers/my_page_resolution_list_provider.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_dashboard_widget.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var resolutionListProvider = ref.watch(myPageResolutionListProvider);
    var currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black54),
            // 일단 임시로 검은색과 홈 아이콘으로 처리하였음.
            onPressed: () async {
              context.go(RouteLocation.home);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  // Image(image: AssetImage(""), width: 50, height: 50),
                  Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      radius: 40,
                      foregroundImage:
                          NetworkImage(currentUser?.photoURL ?? 'DEBUG_URL'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentUser?.displayName ?? 'DEBUG_NONAME'),
                      Text(currentUser?.email ?? 'DEBUG_UserID'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: FilledButton(
                      onPressed: () async {
                        await ref
                            .read(myPageResolutionListProvider.notifier)
                            .getActiveResolutionList();
                      },
                      child: const Text('전체 통계 확인하기'),
                    ),
                  ),
                ),
              ],
            ),
            resolutionListProvider.fold(
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
                        margin: const EdgeInsets.symmetric(vertical: 8),
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
          ],
        ),
      ),
    );
  }
}
