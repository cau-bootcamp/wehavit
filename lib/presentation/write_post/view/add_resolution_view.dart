import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class AddResolutionView extends ConsumerStatefulWidget {
  const AddResolutionView({super.key});

  @override
  ConsumerState<AddResolutionView> createState() => _AddResolutionViewState();
}

class _AddResolutionViewState extends ConsumerState<AddResolutionView> {
  FocusNode nameFocusNode = FocusNode();
  FocusNode goalFocusNode = FocusNode();
  FocusNode actionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(addResolutionViewModelProvider);
    final provider = ref.read(addResolutionViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '도전 추가하기',
        leadingTitle: '취소',
        leadingAction: () async {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Visibility(
                    visible: viewmodel.currentStep >= 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: viewmodel.focusedStep == 0,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: const Text(
                              '도전의 이름을 지어주세요',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: CustomColors.whWhite,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          focusNode: nameFocusNode,
                          onChanged: (value) {
                            setState(() {
                              provider.setNameString(value);
                            });
                          },
                          cursorColor: CustomColors.whWhite,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontSize: 16.0,
                          ),
                          decoration: InputDecoration(
                            hintText: '나의 새로운 도전',
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
                        Container(
                          height: 24.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewmodel.currentStep >= 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: viewmodel.focusedStep == 1,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: const Text(
                              '달성하려는 목표는 무엇인가요?',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: CustomColors.whWhite,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          focusNode: goalFocusNode,
                          onChanged: (value) {
                            setState(() {
                              provider.setGoalString(value);
                            });
                          },
                          cursorColor: CustomColors.whWhite,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontSize: 16.0,
                          ),
                          decoration: InputDecoration(
                            hintText: '좇으려는 목표',
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
                        Container(
                          height: 24.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewmodel.currentStep >= 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: viewmodel.focusedStep == 2,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: const Text(
                              '어떤 노력을 지속하실 건가요?',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: CustomColors.whWhite,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          focusNode: actionFocusNode,
                          onChanged: (value) {
                            setState(() {
                              provider.setActionString(value);
                            });
                          },
                          cursorColor: CustomColors.whWhite,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontSize: 16.0,
                          ),
                          decoration: InputDecoration(
                            hintText: '내가 실천할 행동',
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
                        Container(
                          height: 24.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewmodel.currentStep >= 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: viewmodel.focusedStep == 3,
                          child: const Text(
                            '일주일에 몇 번 실천하실건가요?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          height: 24.0,
                          margin: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 4.0,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            viewmodel.timesLabel,
                            style: TextStyle(
                              fontSize: 13.0 + viewmodel.times,
                              color: CustomColors.whWhite,
                              fontWeight: viewmodel.times > 4
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            tickMarkShape: SliderTickMarkShape.noTickMark,
                            overlayShape: SliderComponentShape.noOverlay,
                            trackHeight: 2,
                          ),
                          child: Slider(
                            inactiveColor: CustomColors.whGrey,
                            activeColor: CustomColors.whYellow,
                            secondaryActiveColor: CustomColors.whYellow,
                            min: 1,
                            max: 7,
                            value: viewmodel.timesTemp,
                            onChangeStart: (_) {
                              provider.setFocusedStep(3);
                            },
                            onChanged: (value) {
                              setState(() {
                                provider.setTimes(value);
                              });
                            },
                            onChangeEnd: (value) {
                              setState(() {
                                provider.setTimesOnChangeEnd(value);
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 24.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewmodel.currentStep >= 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: viewmodel.focusedStep == 4,
                          child: const Text(
                            '도전의 색상을 골라주세요',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          height: 16.0,
                        ),
                        SingleChildScrollView(
                          child: Row(
                            children: List<Widget>.generate(
                              PointColors.colorList.length,
                              (int index) => TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  setState(() {
                                    provider.setFocusedStep(4);
                                    provider.setIconIndex(index);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 8.0,
                                  ),
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: PointColors.colorList[index],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Visibility(
                                    visible: viewmodel.iconIndex == index,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        color: CustomColors.whDarkBlack,
                                        Icons.check_circle_outline,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 12.0,
              ),
              child: WideColoredButton(
                onPressed: () async {
                  // 데이터 채우기
                  if (viewmodel.currentStep != 4) {
                    setState(() {
                      viewmodel.currentStep += 1;
                      provider.setFocusedStep(viewmodel.currentStep);
                      provider.checkIsMovableToNextStep();
                    });
                  }
                  // 모든 데이터 다 채웠음
                  else {
                    // navigate
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddResolutionDoneView(),
                      ),
                    );
                  }
                },
                buttonTitle: viewmodel.currentStep != 4
                    ? '다음 (${viewmodel.currentStep + 1}/5)'
                    : '도전 만들기',
                foregroundColor: CustomColors.whBlack,
                backgroundColor: CustomColors.whYellow,
                isDiminished: !viewmodel.isMovableToNextStep,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    nameFocusNode.addListener(() => _onFocusChange(nameFocusNode));
    goalFocusNode.addListener(() => _onFocusChange(goalFocusNode));
    actionFocusNode.addListener(() => _onFocusChange(actionFocusNode));
  }

  @override
  void dispose() {
    nameFocusNode.removeListener(() => _onFocusChange(nameFocusNode));
    goalFocusNode.removeListener(() => _onFocusChange(goalFocusNode));
    actionFocusNode.removeListener(() => _onFocusChange(actionFocusNode));

    nameFocusNode.dispose();
    goalFocusNode.dispose();
    actionFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      _handleTextFieldTapped(focusNode);
    }
  }

  void _handleTextFieldTapped(FocusNode focusNode) {
    final provider = ref.read(addResolutionViewModelProvider.notifier);

    if (focusNode == nameFocusNode) {
      setState(() {
        provider.setFocusedStep(0);
      });
    } else if (focusNode == goalFocusNode) {
      setState(() {
        provider.setFocusedStep(1);
      });
    } else if (focusNode == actionFocusNode) {
      setState(() {
        provider.setFocusedStep(2);
      });
    }
  }
}
