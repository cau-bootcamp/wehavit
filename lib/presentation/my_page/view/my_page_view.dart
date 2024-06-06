import 'dart:async';

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

class _MyPageScreenState extends ConsumerState<MyPageView>
    with AutomaticKeepAliveClientMixin<MyPageView> {
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
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(myPageViewModelProvider.notifier).loadData();
          },
          child: ListView(
            padding: const EdgeInsets.only(bottom: 64.0),
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
