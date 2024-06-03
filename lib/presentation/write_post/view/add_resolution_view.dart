import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class AddResolutionView extends StatelessWidget {
  const AddResolutionView({super.key});

  @override
  Widget build(BuildContext context) {
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
                children: [
                  Column(
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
                    ],
                  ),
                  Container(
                    height: 24.0,
                  ),
                  Column(
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
                    ],
                  ),
                  Container(
                    height: 24.0,
                  ),
                  Column(
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
                    ],
                  ),
                  Container(
                    height: 24.0,
                  ),
                  Column(
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
                        padding: EdgeInsets.only(top: 8.0),
                        alignment: Alignment.center,
                        child: Text(
                          "hi",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: CustomColors.whWhite,
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
                          value: 3,
                          divisions: 7,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(height: 24.0),
                  Column(
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
                            (int index) => Container(
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
                                visible: true,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.check_circle_outline,
                                    size: 36,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 40,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 12.0,
              ),
              child: WideColoredButton(
                buttonTitle: '도전 만들기',
                foregroundColor: CustomColors.whBlack,
                backgroundColor: CustomColors.whYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
