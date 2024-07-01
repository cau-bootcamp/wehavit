import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/presentation.dart';

class ReactionGuideView extends StatefulWidget {
  const ReactionGuideView({super.key});

  @override
  State<ReactionGuideView> createState() => _ReactionGuideViewState();
}

class _ReactionGuideViewState extends State<ReactionGuideView>
    with TickerProviderStateMixin {
  PageController? pageController;
  final lastPageIndex = 3;
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
          '격려 보내는 법!',
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
              ReactionGuideFirstView(),
              ReactionGuideSecondView(),
              ReactionGuideThirdView(),
              ReactionGuideFourthView(),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        WideColoredButton(
          buttonTitle: currentPageIndex == lastPageIndex ? '격려 남기러가기' : '다음',
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

class ReactionGuideFirstView extends StatelessWidget {
  const ReactionGuideFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(GuideImage.reactionGuideImage1),
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          // ignore: lines_longer_than_80_chars
          '위해빗에서는\n친구들이 올려준 인증글에\n재미있는 격려를 보낼 수 있어요!',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 12,
        ),
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
          '여러분의 적극적인 격려는\n친구들의 도전을 지속하는데에 큰 도움이 돼요!\n격려하는 문화를 즐겨보세요',
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

class ReactionGuideSecondView extends StatelessWidget {
  const ReactionGuideSecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(GuideImage.reactionGuideImage2),
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          // ignore: lines_longer_than_80_chars
          '오늘 실천을 완료한 친구에게\n격려의 한마디와 응원의 이모지들을\n마구마구 보내주세요!',
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

class ReactionGuideThirdView extends StatelessWidget {
  const ReactionGuideThirdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(GuideImage.reactionGuideImage3),
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          // ignore: lines_longer_than_80_chars
          '퀵샷 버튼을 누른채로\n손가락을 움직여보세요\n\n여러분의 환한 미소로 \n친구들을 응원할 수 있어요 :)',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        // Expanded(
        //   child: Container(),
        // ),
      ],
    );
  }
}

class ReactionGuideFourthView extends StatelessWidget {
  const ReactionGuideFourthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(GuideImage.reactionGuideImage4),
        ),
        const SizedBox(height: 24.0),
        const Text(
          // ignore: lines_longer_than_80_chars
          '친구에게 도착한 응원들은\n위해빗이 알아서 재미있게 보여줄게요!',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
