import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/presentation/common_components/colored_button.dart';
import 'package:wehavit/presentation/common_components/gradient_bottom_sheet.dart';
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
      appBar: AppBar(
        title: const Text(
          '그룹에 참여하기',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            color: CustomColors.whWhite,
          ),
        ),
        // leadingWidth: 100,
        leading: TextButton(
          child: const Text(
            '취소',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
              color: CustomColors.whWhite,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
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
              // TODO : Search에 대한 결과 보여주기
              visible: isSearchDone,
              child: Visibility(
                // TODO : Search 결과가 없는 경우에 대한 replacement 보여주기
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
                                          child: JoinGroupIntroduceView(),
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

class JoinGroupIntroduceView extends StatelessWidget {
  const JoinGroupIntroduceView({super.key});

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
                    cellModel: GroupListViewCellWidgetModel.dummyModel,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '그룹 소개',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        Text(
                          '그룹 소개가 이렇게 나옵니다. 호후',
                          style: TextStyle(
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
                        Text(
                          '그룹 리더',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        Text(
                          '그룹 리더가 이렇게 보여집니다',
                          style: TextStyle(
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
                        Text(
                          '그룹 규칙',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whWhite,
                          ),
                        ),
                        Text(
                          '그룹 규칙이 이렇게 작성됩니다.',
                          style: TextStyle(
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
        Visibility(
          visible: false,
          replacement: ColoredButton(
            buttonTitle: '참여 신청 완료',
            backgroundColor: CustomColors.whYellowDark,
            onPressed: () {},
          ),
          child: ColoredButton(
            buttonTitle: '참여 신청하기',
            foregroundColor: CustomColors.whBlack,
            backgroundColor: CustomColors.whYellow,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
