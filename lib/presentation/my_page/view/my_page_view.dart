import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyPageView extends ConsumerStatefulWidget {
  const MyPageView({super.key});

  static MyPageView builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const MyPageView();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageView> {
  @override
  void initState() {
    super.initState();
    unawaited(ref.read(myPageViewModelProvider.notifier).loadData());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(myPageViewModelProvider);
    final provider = ref.read(myPageViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(title: '내 정보'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            // 내 프로필
            MyPageWehavitSummaryWidget(
              futureUserEntity: viewModel.futureMyUserDataEntity,
            ),
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
            EitherFutureBuilder<List<ResolutionEntity>>(
              target: viewModel.futureMyyResolutionList,
              forWaiting: Container(),
              forFail: Container(),
              mainWidgetCallback: (resolutionList) {
                return Column(
                  children: List<ResolutionListCellWidget>.generate(
                    resolutionList.length,
                    (index) => ResolutionListCellWidget(
                      resolutionEntity: resolutionList[index],
                      showDetails: true,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

// class CheckAllWidget extends StatelessWidget {
//   const CheckAllWidget({
//     super.key,
//     required this.ref,
//   });

//   final WidgetRef ref;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             margin: const EdgeInsets.only(
//               top: 12,
//               left: 16,
//               right: 16,
//               bottom: 12,
//             ),
//             child: TextButton(
//               onPressed: () async {
//                 await ref
//                     .read(myPageResolutionListProvider.notifier)
//                     .getMyActiveResolutionList();
//               },
//               style: TextButton.styleFrom(
//                 backgroundColor: CustomColors.whYellowDark,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10), // 모서리 둥글게
//                 ),
//               ),
//               child: const Text(
//                 '전체 통계 확인하기',
//                 style: TextStyle(
//                   color: CustomColors.whSemiWhite,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
