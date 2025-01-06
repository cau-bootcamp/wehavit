import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/common_components/color_selection_list_cell.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/group/group.dart';

class CreateGroupView extends ConsumerStatefulWidget {
  const CreateGroupView({super.key});

  @override
  ConsumerState<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends ConsumerState<CreateGroupView> {
  List<FocusNode> focuseNodeList = [FocusNode(), FocusNode(), FocusNode()];

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(createGroupViewModelProvider);
    final provider = ref.read(createGroupViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        titleLabel: '그룹 만들기',
        leadingTitle: '취소',
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: viewModel.scrollController,
                child: Column(
                  children: [
                    Visibility(
                      visible: viewModel.currentStep >= 0,
                      maintainState: true,
                      child: CreateGroupNameFieldWidget(
                        provider: provider,
                        focusNode: focuseNodeList[0],
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                    Visibility(
                      visible: viewModel.currentStep >= 1,
                      maintainState: true,
                      child: CreateGroupDescriptionFieldWidget(
                        provider: provider,
                        focusNode: focuseNodeList[1],
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                    Visibility(
                      visible: viewModel.currentStep >= 2,
                      maintainState: true,
                      child: CreateGroupRuleFieldWidget(
                        provider: provider,
                        focusNode: focuseNodeList[2],
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                    Visibility(
                      visible: viewModel.currentStep >= 3,
                      maintainState: true,
                      child: CreateGroupColorSelectorWidget(
                        viewModel: viewModel,
                        provider: provider,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: WideColoredButton(
                buttonTitle: viewModel.currentStep != 3
                    ? '다음 (${viewModel.currentStep + 1} / ${viewModel.stepDoneList.length})'
                    : '그룹 만들기',
                isDiminished: !viewModel.isMovableToNextStep,
                foregroundColor: CustomColors.whBlack,
                backgroundColor: CustomColors.whYellow,
                onPressed: () async {
                  if (viewModel.currentStep != 3) {
                    setState(() {
                      viewModel.currentStep += 1;
                      provider.setFocusedStep(viewModel.currentStep);
                      provider.checkIsMovableToNextStep();
                    });

                    if (viewModel.currentStep < 3) {
                      FocusScope.of(context).requestFocus(
                        focuseNodeList[viewModel.currentStep],
                      );
                    } else {
                      focuseNodeList[0].unfocus();
                      focuseNodeList[1].unfocus();
                      focuseNodeList[2].unfocus();
                    }

                    setState(() {});
                  }

                  // 모든 데이터 다 채웠음
                  else {
                    final groupEntity = await provider.createGroup();

                    if (groupEntity != null) {
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DoneCreatingGroupView(
                              groupEntity: groupEntity,
                            );
                          },
                        ),
                      );
                    } else {
                      showToastMessage(
                        // ignore: use_build_context_synchronously
                        context,
                        text: '잠시 후 다시 시도해주세요',
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateGroupColorSelectorWidget extends StatelessWidget {
  const CreateGroupColorSelectorWidget({
    super.key,
    required this.viewModel,
    required this.provider,
    required this.onPressed,
  });

  final CreateGroupViewModel viewModel;
  final CreateGroupViewModelProvider provider;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '그룹을 나타낼 색상을 골라주세요',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: CustomColors.whWhite,
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 8.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(
                CustomColors.pointColorList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: ColorSelectionListCell(
                    isSelected: index == viewModel.groupColorIndex,
                    backgroundColor: CustomColors.pointColorList[index],
                    onTap: () {
                      provider.setGroupColorIndex(index);
                      onPressed();
                    },
                  ),

                  // GestureDetector(
                  //   onTapUp: (details) {
                  //     provider.setGroupColorIndex(index);

                  //     onPressed();
                  //   },
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: CustomColors.pointColorList[index],
                  //         ),
                  //         width: 36,
                  //         height: 36,
                  //       ),
                  //       Visibility(
                  //         visible: index == viewModel.groupColorIndex,
                  //         child: const Icon(
                  //           Icons.check_circle_outline,
                  //           color: CustomColors.whBlack,
                  //           size: 36,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}

class CreateGroupRuleFieldWidget extends StatelessWidget {
  const CreateGroupRuleFieldWidget({
    super.key,
    required this.provider,
    required this.onPressed,
    required this.focusNode,
  });

  final CreateGroupViewModelProvider provider;
  final Function onPressed;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '그룹의 규칙을 작성해주세요',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: CustomColors.whWhite,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            style: const TextStyle(color: CustomColors.whWhite),
            // minLines: 4,
            focusNode: focusNode,
            maxLines: 4,
            cursorColor: CustomColors.whWhite,
            decoration: InputDecoration(
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
              contentPadding: const EdgeInsets.all(10.0),
            ),
            onTap: () {
              provider.setFocusedStep(2);
            },
            onChanged: (value) {
              provider.setGroupRule(value);

              onPressed();
            },
          ),
        ],
      ),
    );
  }
}

class CreateGroupDescriptionFieldWidget extends StatelessWidget {
  const CreateGroupDescriptionFieldWidget({
    super.key,
    required this.provider,
    required this.onPressed,
    required this.focusNode,
  });

  final CreateGroupViewModelProvider provider;
  final Function onPressed;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '어떤 그룹인지 설명해주세요',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: CustomColors.whWhite,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            focusNode: focusNode,
            style: const TextStyle(color: CustomColors.whWhite),
            // minLines: 4,
            cursorColor: CustomColors.whWhite,
            maxLines: 4,
            decoration: InputDecoration(
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
              contentPadding: const EdgeInsets.all(10.0),
            ),
            onTap: () {
              provider.setFocusedStep(1);
            },
            onChanged: (value) {
              provider.setDescriptionName(value);

              onPressed();
            },
          ),
        ],
      ),
    );
  }
}

class CreateGroupNameFieldWidget extends StatelessWidget {
  const CreateGroupNameFieldWidget({
    super.key,
    required this.provider,
    required this.onPressed,
    required this.focusNode,
  });

  final CreateGroupViewModelProvider provider;
  final Function onPressed;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '그룹 이름을 지어주세요',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: CustomColors.whWhite,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            focusNode: focusNode,
            cursorColor: CustomColors.whWhite,
            style: const TextStyle(color: CustomColors.whWhite),
            decoration: InputDecoration(
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
              contentPadding: const EdgeInsets.all(10.0),
            ),
            onTap: () {
              provider.setFocusedStep(0);
            },
            onChanged: (value) {
              provider.setGroupName(value);

              onPressed();
            },
          ),
        ],
      ),
    );
  }
}
