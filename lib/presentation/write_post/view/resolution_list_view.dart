import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/utils/preference_key.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/resolution_list/resolution_list_provider.dart';
import 'package:wehavit/presentation/write_post/view/resolution_list_view_widget.dart';

class ResolutionListView extends ConsumerStatefulWidget {
  const ResolutionListView({super.key});

  @override
  ConsumerState<ResolutionListView> createState() => _ResolutionListViewState();
}

class _ResolutionListViewState extends ConsumerState<ResolutionListView>
    with AutomaticKeepAliveClientMixin<ResolutionListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final provider = ref.read(resolutionListViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: const WehavitAppBar(
        titleLabel: '인증 남기기',
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(myWeeklyResolutionSummaryProvider);
            ref.invalidate(resolutionListNotifierProvider);
            ref.invalidate(weeklyResolutionInfoProvider);
          },
          child: ListView(
            children: [
              const WeeklyResolutionSummaryCard(),
              const SizedBox(height: 16.0),
              Consumer(
                builder: (context, ref, child) {
                  final asyncResolutionList = ref.watch(resolutionListNotifierProvider);

                  return asyncResolutionList.when(
                    data: (resolutionList) {
                      return Column(
                        children: List<Widget>.generate(
                          resolutionList.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: ResolutionListCell(
                              onPressed: () async {
                                final isGuideShown = await SharedPreferences.getInstance().then((instance) {
                                  return instance.getBool(PreferenceKey.isWritingPostGuideShown);
                                });

                                if (isGuideShown == null || isGuideShown == false) {
                                  // ignore: use_build_context_synchronously
                                  await showGuide(context).whenComplete(() async {
                                    await SharedPreferences.getInstance().then((instance) {
                                      instance.setBool(
                                        PreferenceKey.isWritingPostGuideShown,
                                        true,
                                      );
                                    });
                                  });
                                }

                                if (context.mounted) {
                                  showWritingMenu(
                                    context,
                                    resolutionList[index],
                                  );
                                }
                              },
                              resolutionEntity: ref.watch(resolutionListNotifierProvider).value![index],
                              showDetails: false,
                            ),
                          ),
                        )
                            .append(
                              ListDashOutlinedCell(
                                buttonLabel: '새로운 목표 추가하기',
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => const AddResolutionView(),
                                    ),
                                  ).whenComplete(() async {
                                    ref.invalidate(myWeeklyResolutionSummaryProvider);
                                    ref.invalidate(resolutionListNotifierProvider);
                                  });
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                    error: (_, __) {
                      return Container();
                    },
                    loading: () {
                      return Container();
                    },
                  );
                },
              ),
              Container(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showWritingMenu(
    BuildContext context,
    ResolutionEntity resolutionEntity,
  ) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ResolutionWritingMenuBottomSheet(
        resolutionEntity: resolutionEntity,
      ),
    );
  }

  Future<dynamic> showGuide(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => GradientBottomSheet(
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.80,
          child: const WritingPostGuideView(),
        ),
      ),
    );
  }
}
