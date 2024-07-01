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
          height: 20.0,
        ),
        Expanded(
          child: PageView(
            onPageChanged: (newPage) {
              setState(() {
                currentPageIndex = newPage;
              });
            },
            controller: pageController,
            children: const [
              WritingPostGuideFirstView(),
              WritingPostGuideSecondView(),
              WritingPostGuideThirdView(),
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
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(GuideImage.postGuideImage1),
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          // ignore: lines_longer_than_80_chars
          '여러분의 각 도전에 대한 인증글을 작성할 수 있어요!\n\n사진은 최대 3장까지 첨부할 수 있고,\n글 없이 사진만 공유해도 괜찮아요!',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Container(height: 12.0),
        const Text(
          'Tip',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          '결과보다는 과정이 담긴 인증이 \n서로에게 더 많은 도움이 되어요',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class WritingPostGuideSecondView extends StatelessWidget {
  const WritingPostGuideSecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(GuideImage.postGuideImage2),
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          // ignore: lines_longer_than_80_chars
          '도전을 공유하기로 선택한 친구와 그룹에게만\n각각의 도전에 대한 인증글이 보내집니다!\n\n나머지는 이 인증글을 볼 수 없어요',
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

class WritingPostGuideThirdView extends StatelessWidget {
  const WritingPostGuideThirdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(GuideImage.postGuideImage3),
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          // ignore: lines_longer_than_80_chars
          '글쓰기가 귀찮다면? \n그냥 완료 표시만 남겨주세요!\n\n혹시 오늘 목표를 실천하지 못했더라도\n반성을 적으면 친구들에게 격려를 받을 수 있어요!',
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
