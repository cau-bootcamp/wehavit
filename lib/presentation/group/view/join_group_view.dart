import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class JoinGroupView extends ConsumerStatefulWidget {
  const JoinGroupView({super.key});

  @override
  ConsumerState<JoinGroupView> createState() => _JoinGroupViewState();
}

class _JoinGroupViewState extends ConsumerState<JoinGroupView> {
  final groupNameFieldController = TextEditingController();
  List<GroupListViewCellWidgetModel> groupListCellWidgetModelList = [];

  bool isSearchDone = false;
  bool isSearchSuccessed = false;

  @override
  Widget build(BuildContext context) {
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
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          controller: groupNameFieldController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          cursorColor: CustomColors.whWhite,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontSize: 16.0,
                          ),
                          decoration: InputDecoration(
                            hintText: '그룹 이름',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: CustomColors.whPlaceholderGrey,
                            ),
                            filled: true,
                            fillColor: CustomColors.whGrey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                        Visibility(
                          replacement: IconButton(
                            onPressed: () {
                              setState(() {
                                groupNameFieldController.clear();
                                groupListCellWidgetModelList = [];
                                isSearchDone = false;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 24,
                              color: CustomColors.whWhite,
                            ),
                          ),
                          visible: groupNameFieldController.text.isEmpty,
                          child: IconButton(
                            onPressed: () async {
                              final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                              groupNameFieldController.text = clipboardData?.text ?? '';
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
                ),
                IconButton(
                  onPressed: () async {
                    if (groupNameFieldController.text.isNotEmpty) {
                      final groupEntityList = await ref
                          .read(searchGroupEntityListByGroupNameUsecaseProvider)
                          (searchKeyword: groupNameFieldController.text)
                          .then(
                            (result) => result.fold(
                              (failure) => null,
                              (list) => list,
                            ),
                          );

                      if (groupEntityList == null || (groupEntityList.isEmpty)) {
                        // 그룹 정보를 불러올 수 없는 경우 (데이터가 없다거나?)
                        setState(() {
                          isSearchDone = true;
                          isSearchSuccessed = false;
                        });
                        return;
                      }

                      groupListCellWidgetModelList = (await Future.wait(
                        groupEntityList.map(
                          (futureEntity) async {
                            return futureEntity.then((result) async {
                              final model = await result.fold(
                                (failure) => null,
                                (entity) async => await ref
                                    .read(
                                      // ignore: lines_longer_than_80_chars
                                      getGroupListViewCellWidgetModelUsecaseProvider,
                                    )(
                                      groupEntity: entity,
                                    )
                                    .then(
                                      (result) => result.fold(
                                        (failure) => null,
                                        (model) => model,
                                      ),
                                    ),
                              );

                              if (model != null) {
                                return model;
                              }
                            });
                          },
                        ).toList(),
                      ))
                          .whereNotNull()
                          .toList();

                      if (groupListCellWidgetModelList.isEmpty) {
                        // 그룹 정보를 불러올 수 없는 경우 (데이터가 없다거나?)
                        setState(() {
                          isSearchDone = true;
                          isSearchSuccessed = false;
                        });
                        return;
                      }

                      // ignore: use_build_context_synchronously
                      FocusScope.of(context).unfocus();
                      setState(() {
                        isSearchSuccessed = true;
                        isSearchDone = true;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    size: 28,
                    color: groupNameFieldController.text.isEmpty ? CustomColors.whGrey : CustomColors.whWhite,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isSearchDone,
              replacement: const Expanded(
                child: Center(
                  child: Text(
                    '참여하려는 그룹의 이름을\n 검색창에 입력해주세요 🥰',
                    style: TextStyle(
                      color: CustomColors.whSemiWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              child: Visibility(
                visible: isSearchSuccessed,
                replacement: const Expanded(
                  child: Center(
                    child: Text(
                      '해당 이름의 그룹을 찾을 수 없어요 🤔',
                      style: TextStyle(
                        color: CustomColors.whSemiWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                child: Expanded(
                  child: ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
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
                      ...groupListCellWidgetModelList.map(
                        (cellModel) => Container(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
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
                                      height: MediaQuery.sizeOf(context).height * 0.80,
                                      child: JoinGroupIntroduceView(
                                        groupModel: cellModel,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
  ConsumerState<JoinGroupIntroduceView> createState() => _JoinGroupIntroduceViewState();
}

class _JoinGroupIntroduceViewState extends ConsumerState<JoinGroupIntroduceView> {
  EitherFuture<UserDataEntity>? groupManagerEntity;
  Future<bool>? isRegisteredFuture;
  Future<bool>? isAppliedFuture;

  @override
  void initState() {
    super.initState();
    unawaited(initializeData());
  }

  Future<void> initializeData() async {
    groupManagerEntity =
        ref.read(getUserDataFromIdUsecaseProvider)(widget.groupModel.groupEntity.groupManagerUid).whenComplete(() {
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
                          widget.groupModel.groupEntity.groupDescription,
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
                        const SizedBox(height: 8.0),
                        FriendListCellWidget(
                          futureUserEntity: groupManagerEntity!,
                          cellState: FriendListCellState.normal,
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
                          '그룹 규칙',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        Text(
                          widget.groupModel.groupEntity.groupRule,
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
                        replacement: WideColoredButton(
                          buttonTitle: '참여 신청 완료',
                          backgroundColor: CustomColors.whYellowDark,
                          onPressed: () {},
                        ),
                        child: WideColoredButton(
                          buttonTitle: '참여 신청하기',
                          foregroundColor: CustomColors.whBlack,
                          onPressed: () async {
                            ref.read(applyForJoiningGroupUsecaseProvider)(
                              widget.groupModel.groupEntity.groupId,
                            );
                            isAppliedFuture = null;
                            setState(() {});

                            isAppliedFuture = ref
                                .read(
                                  // ignore: lines_longer_than_80_chars
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
                      return WideColoredButton(
                        buttonTitle: '신청 여부 조회에 문제가 발생하였습니다',
                        foregroundColor: CustomColors.whBlack,
                        backgroundColor: CustomColors.whPlaceholderGrey,
                        onPressed: () {},
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
                return WideColoredButton(
                  buttonTitle: '이미 그룹에 참여중입니다',
                  foregroundColor: CustomColors.whBlack,
                  backgroundColor: CustomColors.whPlaceholderGrey,
                  onPressed: () {},
                );
              }
            } else if (snapshot.hasError) {
              return WideColoredButton(
                buttonTitle: '가입 여부 조회에 문제가 발생하였습니다',
                foregroundColor: CustomColors.whBlack,
                backgroundColor: CustomColors.whPlaceholderGrey,
                onPressed: () {},
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
