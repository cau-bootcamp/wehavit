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
                        const Text(
                          '도전의 이름을 지어주세요',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          height: 8.0,
                        ),
                        TextFormField(
                          // controller: viewmodel.nameController,
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
                        const Text(
                          '달성하려는 목표는 무엇인가요?',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          height: 8.0,
                        ),
                        TextFormField(
                          // controller: viewmodel.goalController,
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
                        const Text(
                          '어떤 노력을 지속하실 건가요?',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          height: 8.0,
                        ),
                        TextFormField(
                          // controller: viewmodel.actionController,
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
                        const Text(
                          '일주일에 몇 번 실천하실건가요?',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                            fontSize: 20,
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
                        const Text(
                          '도전의 색상을 골라주세요',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whWhite,
                            fontSize: 20,
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
}
