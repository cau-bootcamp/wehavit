import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
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
    // ref.read(myPageResolutionListProvider.notifier).getMyActiveResolutionList();
  }

  @override
  Widget build(BuildContext context) {
    var resolutionListProvider = ref.watch(myPageResolutionListProvider);
    var currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(title: '내 정보'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            // 내 프로필
            MyPageWehavitSummaryWidget(),
            SizedBox(
              height: 16,
            ),
            Text(
              "도전중인 목표",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            MyPageResolutionListCellWidget(
              resolutionEntity: ResolutionEntity(),
              showDetails: true,
            ),

            MyPageResolutionListCellWidget(
              resolutionEntity: ResolutionEntity(),
              showDetails: false,
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
