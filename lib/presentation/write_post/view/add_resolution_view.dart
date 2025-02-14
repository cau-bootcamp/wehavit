import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class AddResolutionView extends ConsumerStatefulWidget {
  const AddResolutionView({super.key});

  @override
  ConsumerState<AddResolutionView> createState() => _AddResolutionViewState();
}

class _AddResolutionViewState extends ConsumerState<AddResolutionView> {
  List<FocusNode> focuseNodeList = [FocusNode(), FocusNode(), FocusNode()];
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController goalTextEditingController = TextEditingController();
  TextEditingController actionTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(addResolutionViewModelProvider);
    final provider = ref.read(addResolutionViewModelProvider.notifier);

    nameTextEditingController.addListener(() {
      provider.setNameString(nameTextEditingController.text);
    });

    goalTextEditingController.addListener(() {
      provider.setGoalString(goalTextEditingController.text);
    });

    actionTextEditingController.addListener(() {
      provider.setActionString(actionTextEditingController.text);
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        titleLabel: '목표 추가하기',
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
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Visibility(
                    maintainState: true,
                    visible: viewmodel.currentStep >= 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '도전명',
                          style: context.titleSmall,
                        ),
                        Container(
                          height: 12.0,
                        ),
                        InputFormField(
                          textEditingController: nameTextEditingController,
                          focusNode: focuseNodeList[0],
                          placeholder: '나의 도전에 멋진 이름을 붙여주세요',
                        ),
                        Container(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    maintainState: true,
                    visible: viewmodel.currentStep >= 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '목표',
                          style: context.titleSmall,
                        ),
                        Container(
                          height: 12.0,
                        ),
                        InputFormField(
                          textEditingController: goalTextEditingController,
                          focusNode: focuseNodeList[1],
                          placeholder: '도전으로 이루고싶은 바를 알려주세요',
                        ),
                        Container(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    maintainState: true,
                    visible: viewmodel.currentStep >= 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '실천할 액션',
                          style: context.titleSmall,
                        ),
                        Container(
                          height: 12.0,
                        ),
                        InputFormField(
                          textEditingController: actionTextEditingController,
                          focusNode: focuseNodeList[2],
                          placeholder: '내가 실천하고 인증할 노력이에요',
                        ),
                        Container(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewmodel.currentStep >= 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '일주일에 몇 번 실천하실건가요?',
                          style: context.titleSmall,
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
                              fontWeight: viewmodel.times > 4 ? FontWeight.w600 : FontWeight.w400,
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
                            inactiveColor: CustomColors.whGrey400,
                            activeColor: CustomColors.whYellow500,
                            secondaryActiveColor: CustomColors.whYellow500,
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
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewmodel.currentStep >= 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '도전의 색상을 골라주세요',
                          style: context.titleSmall,
                        ),
                        Container(
                          height: 12.0,
                        ),
                        SingleChildScrollView(
                          child: Row(
                            children: List<Widget>.generate(
                              CustomColors.pointColorList.length,
                              (int index) => TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  setState(() {
                                    provider.setFocusedStep(4);
                                    provider.setColorIndex(index);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 8.0,
                                  ),
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: CustomColors.pointColorList[index],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Visibility(
                                    visible: viewmodel.pointColorIndex == index,
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
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewmodel.currentStep >= 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '도전을 나타낼 아이콘을 골라주세요',
                          style: context.titleSmall,
                        ),
                        Container(
                          height: 12.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.generate(
                              CustomIconImage.resolutionIcons.length,
                              (int index) => TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  setState(() {
                                    provider.setFocusedStep(5);
                                    provider.setIconIndex(index);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 6.0,
                                  ),
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: viewmodel.iconIndex == index
                                          ? CustomColors.whYellow500
                                          : CustomColors.whWhite,
                                      width: 2.0,
                                    ),
                                    color: viewmodel.iconIndex == index
                                        ? CustomColors.whYellow300
                                        : CustomColors.whGrey600,
                                  ),
                                  child: Image.asset(
                                    CustomIconImage.resolutionIcons[index],
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
                  if (viewmodel.currentStep != viewmodel.maxStep) {
                    setState(() {
                      viewmodel.currentStep += 1;
                      provider.setFocusedStep(viewmodel.currentStep);
                      provider.checkIsMovableToNextStep();
                    });

                    if (viewmodel.currentStep < 3) {
                      FocusScope.of(context).requestFocus(
                        focuseNodeList[viewmodel.currentStep],
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
                    provider.uploadResolution().then((resolutionEntity) {
                      if (resolutionEntity != null) {
                        updateResolutionEntity(resolutionEntity).whenComplete(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddResolutionDoneView(resolutionEntity: resolutionEntity),
                            ),
                          );
                        });
                      } else {
                        showToastMessage(
                          context,
                          text: '잠시 후 다시 시도해주세요',
                        );
                      }
                    });
                    // navigate
                  }
                },
                buttonTitle: viewmodel.currentStep != viewmodel.maxStep
                    ? '다음 (${viewmodel.currentStep + 1}/${viewmodel.maxStep + 1})'
                    : '도전 만들기',
                foregroundColor: CustomColors.whBlack,
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

    focuseNodeList[0].addListener(() => _onFocusChange(focuseNodeList[0]));
    focuseNodeList[1].addListener(() => _onFocusChange(focuseNodeList[1]));
    focuseNodeList[2].addListener(() => _onFocusChange(focuseNodeList[2]));
  }

  @override
  void dispose() {
    focuseNodeList[0].removeListener(() => _onFocusChange(focuseNodeList[0]));
    focuseNodeList[1].removeListener(() => _onFocusChange(focuseNodeList[1]));
    focuseNodeList[2].removeListener(() => _onFocusChange(focuseNodeList[2]));

    focuseNodeList[0].dispose();
    focuseNodeList[1].dispose();
    focuseNodeList[2].dispose();

    super.dispose();
  }

  void _onFocusChange(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      _handleTextFieldTapped(focusNode);
    }
  }

  void _handleTextFieldTapped(FocusNode focusNode) {
    final provider = ref.read(addResolutionViewModelProvider.notifier);

    if (focusNode == focuseNodeList[0]) {
      setState(() {
        provider.setFocusedStep(0);
      });
    } else if (focusNode == focuseNodeList[1]) {
      setState(() {
        provider.setFocusedStep(1);
      });
    } else if (focusNode == focuseNodeList[2]) {
      setState(() {
        provider.setFocusedStep(2);
      });
    }
  }

  Future<void> updateResolutionEntity(ResolutionEntity resolutionEntity) async {
    ref.watch(addResolutionDoneViewModelProvider).resolutionEntity = resolutionEntity;
  }
}
