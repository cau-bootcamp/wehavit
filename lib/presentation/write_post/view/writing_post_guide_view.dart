import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/presentation.dart';

class WritingPostGuideView extends StatefulWidget {
  const WritingPostGuideView({super.key});

  @override
  State<WritingPostGuideView> createState() => _WritingPostGuideViewState();
}

class _WritingPostGuideViewState extends State<WritingPostGuideView>
    with TickerProviderStateMixin {
  PageController? pageController;
  final lastPageIndex = 2;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '인증 남기는 법!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: CustomColors.whYellow,
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Expanded(
          child: PageView(
            onPageChanged: (newPage) {
              setState(() {
                currentPageIndex = newPage;
              });
            },
            controller: pageController,
            children: [
              const WritingPostGuideFirstView(),
              Container(
                color: PointColors.green,
              ),
              Container(
                color: PointColors.pink,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        WideColoredButton(
          buttonTitle: currentPageIndex == lastPageIndex ? '인증 남기러가기' : '다음',
          foregroundColor: CustomColors.whBlack,
          backgroundColor: CustomColors.whYellow,
          onPressed: () async {
            if (currentPageIndex == lastPageIndex) {
              Navigator.pop(context);
            } else {
              pageController?.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          },
        ),
      ],
    );
  }
}

class WritingPostGuideFirstView extends StatelessWidget {
  const WritingPostGuideFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '여러분의 각 도전에 대한 인증글을 작성할 수 있어요!\n\n사진은 최대 3장까지 첨부할 수 있고,\n글 없이 사진만 공유해도 괜찮아요!',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
