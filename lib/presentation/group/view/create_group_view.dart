import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/group/group.dart';

class CreateGroupView extends ConsumerStatefulWidget {
  const CreateGroupView({super.key});

  @override
  ConsumerState<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends ConsumerState<CreateGroupView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(createGroupViewModelProvider);
    final provider = ref.read(createGroupViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: wehavitAppBar(
        title: '그룹 만들기',
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
                    CreateGroupNameFieldWidget(
                      provider: provider,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    CreateGroupDescriptionFieldWidget(
                      provider: provider,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    CreateGroupRuleFieldWidget(
                      provider: provider,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    CreateGroupColorSelectorWidget(
                      viewModel: viewModel,
                      provider: provider,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Visibility(
                visible: provider.isComplete(),
                replacement: ColoredButton(
                  buttonTitle: '그룹 만들기',
                  backgroundColor: CustomColors.whGrey,
                ),
                child: ColoredButton(
                  buttonTitle: '그룹 만들기',
                  foregroundColor: CustomColors.whBlack,
                  backgroundColor: CustomColors.whYellow,
                  onPressed: () async {
                    final groupEntity = await provider.createGroup();

                    if (groupEntity != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DoneCreatingGroupView(
                              groupEntity: groupEntity,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
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
                PointColors.colorList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: GestureDetector(
                    onTapUp: (details) {
                      provider.setGroupColorIndex(index);
                      if (index >= 0) {
                        provider.setStepDoneList(3, true);
                      } else {
                        provider.setStepDoneList(3, false);
                      }
                      onPressed();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PointColors.colorList[index],
                          ),
                          width: 36,
                          height: 36,
                        ),
                        Visibility(
                          visible: index == viewModel.groupColorIndex,
                          child: const Icon(
                            Icons.check_circle_outline,
                            color: CustomColors.whBlack,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
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
  });

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
            onChanged: (value) {
              provider.setGroupRule(value);
              if (value.isEmpty) {
                provider.setStepDoneList(2, false);
              } else {
                provider.setStepDoneList(2, true);
              }
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
  });

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
            onChanged: (value) {
              provider.setDescriptionName(value);
              if (value.isEmpty) {
                provider.setStepDoneList(1, false);
              } else {
                provider.setStepDoneList(1, true);
              }
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
  });

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
            onChanged: (value) {
              provider.setGroupName(value);
              if (value.isEmpty) {
                provider.setStepDoneList(0, false);
              } else {
                provider.setStepDoneList(0, true);
              }
              onPressed();
            },
          ),
        ],
      ),
    );
  }
}
