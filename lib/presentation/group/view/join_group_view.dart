import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/group_list/group_list_cell_model_provider.dart';
import 'package:wehavit/presentation/state/group_list/group_list_provider.dart';
import 'package:wehavit/presentation/state/group_list/join_group_provider.dart';

class JoinGroupView extends StatefulWidget {
  const JoinGroupView({super.key});

  @override
  State<JoinGroupView> createState() => _JoinGroupViewState();
}

class _JoinGroupViewState extends State<JoinGroupView> {
  Timer? _debounce;

  final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchFieldController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() {});
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        titleLabel: '그룹에 참여하기',
        leadingTitle: '닫기',
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Stack(
                      children: [
                        SearchFormField(
                          textEditingController: searchFieldController,
                          placeholder: '그룹 이름을 검색해보세요',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                if (searchFieldController.text.isEmpty) {
                  return Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      '친구와 함께라면 더 쉽게 도전할 수 있어요',
                      style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                    ),
                  );
                }
                return ref.watch(searchGroupProvider(searchFieldController.text)).when(
                  data: (entityList) {
                    if (entityList.isEmpty) {
                      return Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          '해당 이름의 그룹을 찾을 수 없어요',
                          style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 60),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GroupListCell(
                              groupEntity: entityList[index],
                              onPressed: () async {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return GradientBottomSheet(
                                      SizedBox(
                                        height: MediaQuery.sizeOf(context).height * 0.80,
                                        child: JoinGroupIntroduceView(
                                          groupEntity: entityList[index],
                                        ),
                                      ),
                                    );
                                  },
                                ).whenComplete(() {
                                  ref.invalidate(groupListProvider);
                                });
                              },
                            ),
                          );
                        },
                        itemCount: entityList.length,
                      ),
                    );
                  },
                  error: (_, __) {
                    return Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        '잠시 후 다시 시도해주세요',
                        style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
                      ),
                    );
                  },
                  loading: () {
                    return Container(
                      width: double.infinity,
                      height: 120,
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.waveDots(
                        color: CustomColors.whGrey700,
                        size: 30,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class JoinGroupIntroduceView extends StatelessWidget {
  const JoinGroupIntroduceView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      return GroupListCellContent(asyncCellModel: ref.watch(groupListCellModelProvider(groupEntity)));
                    },
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '그룹 소개',
                        style: context.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        groupEntity.groupDescription,
                        style: context.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '그룹 리더',
                        style: context.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      UserProfileCell(groupEntity.groupManagerUid, type: UserProfileCellType.normal)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '그룹 규칙',
                        style: context.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        groupEntity.groupRule,
                        style: context.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final isApplied = ref
                .watch(groupApplyStateProvider(groupEntity.groupId))
                .when(data: (data) => data, error: (_, __) => null, loading: () => false);
            final isRegistered = ref
                .watch(groupRegisterStateProvider(groupEntity.groupId))
                .when(data: (data) => data, error: (_, __) => null, loading: () => false);

            return WideColoredButton(
              buttonTitle: (isApplied != null && isApplied == true)
                  ? '신청을 완료했어요'
                  : ((isRegistered != null && isRegistered == true) ? '이미 가입한 그룹이예요' : '신청하기'),
              foregroundColor: CustomColors.whBalck,
              isDiminished: isApplied == null || isRegistered == null || isApplied == true || isRegistered == true,
              onPressed: () async {
                await ref
                    .read(applyForJoiningGroupUsecaseProvider)
                    .call(groupEntity.groupId)
                    .then(
                      (result) => result.fold(
                        (failure) {
                          showToastMessage(context, text: '그룹 참여 신청에 실패했어요. 잠시 후 다시 시도해주세요');
                        },
                        (success) {},
                      ),
                    )
                    .whenComplete(() {
                  ref.invalidate(groupApplyStateProvider(groupEntity.groupId));
                  ref.invalidate(groupRegisterStateProvider(groupEntity.groupId));
                });
              },
            );
          },
        ),
      ],
    );
  }
}
