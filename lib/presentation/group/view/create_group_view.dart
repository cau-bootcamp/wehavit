import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/presentation/common_components/colored_button.dart';
import 'package:wehavit/presentation/common_components/gradient_bottom_sheet.dart';
import 'package:wehavit/presentation/group/group.dart';

class CreateGroupView extends StatelessWidget {
  CreateGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: AppBar(
        title: Text(
          '그룹 만들기',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            color: CustomColors.whWhite,
          ),
        ),
        leadingWidth: 80,
        leading: TextButton(
          child: Text(
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '그룹 이름을 지어주세요',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: CustomColors.whWhite),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColors.whGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '어떤 그룹인지 설명해주세요',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: CustomColors.whWhite),
                            // minLines: 4,
                            maxLines: 4,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColors.whGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '그룹의 규칙을 작성해주세요',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: CustomColors.whWhite),
                            // minLines: 4,
                            maxLines: 4,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColors.whGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '그룹을 나타낼 색상을 골라주세요',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                            ),
                          ),
                          SizedBox(
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
                                      visible: index == 0,
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: CustomColors.whBlack,
                                        size: 36,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ColoredButton(
                buttonTitle: '그룹 만들기',
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
