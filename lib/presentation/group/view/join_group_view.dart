import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/group/group.dart';

class JoinGroupView extends ConsumerStatefulWidget {
  const JoinGroupView({super.key});

  @override
  ConsumerState<JoinGroupView> createState() => _JoinGroupViewState();
}

class _JoinGroupViewState extends ConsumerState<JoinGroupView> {
  final groupIdController = TextEditingController();
  List<GroupListViewCellWidgetModel> groupListCellWidgetModelList = [];

  bool isSearchDone = false;
  bool isSearchSuccessed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: wehavitAppBar(
        title: '그룹에 참여하기',
        leadingTitle: '취소',
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                          hintText: '그룹 코드 입력',
                          hintStyle: TextStyle(
                            color: CustomColors.whPlaceholderGrey,
                          ),
                        ),
                        controller: groupIdController,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      Visibility(
                        replacement: IconButton(
                          onPressed: () {
                            groupIdController.clear();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 24,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        visible: groupIdController.text.isEmpty,
                        child: IconButton(
                          onPressed: () async {
                            final clipboardData =
                                await Clipboard.getData(Clipboard.kTextPlain);
                            groupIdController.text = clipboardData?.text ?? '';
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.paste,
                            size: 20,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (groupIdController.text.isNotEmpty) {
                      final groupEntity = await ref
                          .read(getGroupEntityByIdUsecaseProvider)(
                            groupId: groupIdController.text,
                          )
                          .then(
                            (result) => result.fold(
                              (failure) => null,
                              (entity) => entity,
                            ),
                          );

                      if (groupEntity == null) {
                        // 그룹 정보를 불러올 수 없는 경우 (데이터가 없다거나?)
                        setState(() {
                          isSearchSuccessed = false;
                        });
                        return;
                      }

                      groupListCellWidgetModelList = await ref
                          .read(getGroupListViewCellWidgetModelUsecaseProvider)(
                            groupEntity: groupEntity,
                          )
                          .then(
                            (result) => result.fold(
                              (failure) => [],
                              (model) => [model],
                            ),
                          );

                      setState(() {
                        isSearchSuccessed = true;
                        isSearchDone = true;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    size: 28,
                    color: groupIdController.text.isEmpty
                        ? CustomColors.whGrey
                        : CustomColors.whWhite,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isSearchDone,
              child: Visibility(
                visible: isSearchSuccessed,
                replacement: const Expanded(
                  child: Center(
                    child: Text(
                      '해당 코드의 그룹을 찾을 수 없어요 🤔',
                      style: TextStyle(
                        color: CustomColors.whSemiWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: const Text(
                        '참여하려는 그룹을 선택해주세요',
                        style: TextStyle(
                          color: CustomColors.whSemiWhite,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: groupListCellWidgetModelList
                            .map(
                              (cellModel) => GestureDetector(
                                child: GroupListViewCellWidget(
                                  cellModel: cellModel,
                                ),
                                onTapUp: (details) async {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return GradientBottomSheet(
                                        SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.80,
                                          child: JoinGroupIntroduceView(
                                            groupModel: cellModel,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JoinGroupIntroduceView extends ConsumerStatefulWidget {
  const JoinGroupIntroduceView({super.key, required this.groupModel});

  final GroupListViewCellWidgetModel groupModel;

  @override
  ConsumerState<JoinGroupIntroduceView> createState() =>
      _JoinGroupIntroduceViewState();
}

class _JoinGroupIntroduceViewState
    extends ConsumerState<JoinGroupIntroduceView> {
  EitherFuture<UserDataEntity>? groupManagerEntity;
  Future<bool>? isRegisteredFuture;
  Future<bool>? isAppliedFuture;

  @override
  void initState() {
    super.initState();
    unawaited(initializeData());
  }

  Future<void> initializeData() async {
    groupManagerEntity = ref
        .read(fetchUserDataFromIdUsecaseProvider)
        (widget.groupModel.groupEntity.groupManagerUid)
        .whenComplete(() {
      setState(() {});
    });

    isRegisteredFuture = ref
        .read(checkWhetherAlreadyRegisteredToGroupUsecaseProvider)(
          widget.groupModel.groupEntity.groupId,
        )
        .then(
          (value) => value.fold(
            (failure) => false,
            (isRegistered) => isRegistered,
          ),
        )
        .whenComplete(() => setState(() {}));

    isAppliedFuture = ref
        .read(checkWhetherAlreadyAppliedToGroupUsecaseProvider)(
          widget.groupModel.groupEntity.groupId,
        )
        .then(
          (value) => value.fold(
            (failure) => false,
            (isApplied) => isApplied,
          ),
        )
        .whenComplete(() => setState(() {}));
  }

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
                  GroupListViewCellContentWidget(
                    cellModel: widget.groupModel,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '그룹 소개',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        Text(
                          widget.groupModel.groupEntity.groupDescription ?? '',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '그룹 리더',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        UserProfileBar(futureUserEntity: groupManagerEntity!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '그룹 규칙',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        Text(
                          widget.groupModel.groupEntity.groupRule ?? '',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: isRegisteredFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!snapshot.data!) {
                return FutureBuilder(
                  future: isAppliedFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Visibility(
                        visible: !snapshot.data!,
                        replacement: ColoredButton(
                          buttonTitle: '참여 신청 완료',
                          backgroundColor: CustomColors.whYellowDark,
                          onPressed: () {},
                        ),
                        child: ColoredButton(
                          buttonTitle: '참여 신청하기',
                          foregroundColor: CustomColors.whBlack,
                          backgroundColor: CustomColors.whYellow,
                          onPressed: () async {
                            ref.read(applyForJoiningGroupUsecaseProvider)(
                              widget.groupModel.groupEntity.groupId,
                            );
                            isAppliedFuture = null;
                            setState(() {});

                            isAppliedFuture = ref
                                // ignore: lines_longer_than_80_chars
                                .read(
                                  checkWhetherAlreadyAppliedToGroupUsecaseProvider,
                                )(
                                  widget.groupModel.groupEntity.groupId,
                                )
                                .then(
                                  (value) => value.fold(
                                    (failure) => false,
                                    (isApplied) => isApplied,
                                  ),
                                )
                                .whenComplete(() => setState(() {}));
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return ColoredButton(
                        buttonTitle: '신청 여부 조회에 문제가 발생하였습니다',
                        foregroundColor: CustomColors.whBlack,
                        backgroundColor: CustomColors.whPlaceholderGrey,
                      );
                    } else {
                      return Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.all(8.0),
                        child: const CircularProgressIndicator(
                          color: CustomColors.whYellow,
                        ),
                      );
                    }
                  },
                );
              } else {
                return ColoredButton(
                  buttonTitle: '이미 그룹에 참여중입니다',
                  foregroundColor: CustomColors.whBlack,
                  backgroundColor: CustomColors.whPlaceholderGrey,
                );
              }
            } else if (snapshot.hasError) {
              return ColoredButton(
                buttonTitle: '가입 여부 조회에 문제가 발생하였습니다',
                foregroundColor: CustomColors.whBlack,
                backgroundColor: CustomColors.whPlaceholderGrey,
              );
            } else {
              return Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.all(8.0),
                child: const CircularProgressIndicator(
                  color: CustomColors.whYellow,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
