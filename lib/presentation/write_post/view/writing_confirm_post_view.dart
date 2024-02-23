import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/write_post/view/view.dart';

class WritingConfirmPostView extends StatefulWidget {
  const WritingConfirmPostView({super.key});

  @override
  State<WritingConfirmPostView> createState() => _WritingConfirmPostViewState();
}

class _WritingConfirmPostViewState extends State<WritingConfirmPostView> {
  bool isWritingYesterdayPost = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: wehavitAppBar(
          title: '인증 남기기',
          leadingTitle: '목표 선택',
          leadingIcon: Icons.chevron_left,
          leadingAction: () {
            Navigator.pop(context);
          },
          trailingTitle: '공유 대상',
          trailingIcon: Icons.cloud_upload_outlined,
          trailingAction: () async {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return GradientBottomSheet(
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.80,
                    child: ShareTargetGroupCellWidget(),
                  ),
                );
              },
            );
          }),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2024년 2월 6일',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: CustomColors.whSemiWhite,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      isWritingYesterdayPost
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: isWritingYesterdayPost
                          ? CustomColors.whYellow
                          : CustomColors.whSemiWhite,
                    ),
                    label: Text(
                      '전날 기록하기',
                      style: TextStyle(
                        color: isWritingYesterdayPost
                            ? CustomColors.whYellow
                            : CustomColors.whSemiWhite,
                        fontSize: 16.0,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ],
              ),
              Text(
                '새해에는 유산소를 시작할테야',
                style: TextStyle(
                  color: CustomColors.whYellow,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '일주일에 1번 한 번에 3km 이상 가볍게 뛰기',
                style: TextStyle(
                  color: CustomColors.whSemiWhite,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: TextFormField(
                  autofocus: true,
                  style: TextStyle(
                    color: CustomColors.whWhite,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '오늘의 발자국을 남겨주세요',
                      hintStyle: TextStyle(
                        color: CustomColors.whPlaceholderGrey,
                      )),
                ),
              ),
              Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/emoji_3d/beaming_face_with_smiling_eyes_3d.png',
                                ),
                              ),
                              color: Colors.amber,
                              width: 90,
                              height: 90,
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: CustomColors.whWhite,
                                ),
                              ),
                              onTapUp: (details) {
                                //
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/emoji_3d/beaming_face_with_smiling_eyes_3d.png')),
                              color: Colors.amber,
                              width: 90,
                              height: 90,
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: CustomColors.whWhite,
                                ),
                              ),
                              onTapUp: (details) {
                                //
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: CustomColors.whWhite,
                    ),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "인증샷은 최대 3장까지 공유할 수 있어요",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.whPlaceholderGrey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(
                      '공유하기',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whYellow,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
