import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class GroupPostView extends StatelessWidget {
  const GroupPostView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          groupEntity.groupName,
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.campaign_outlined,
              color: CustomColors.whWhite,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.error_outline,
              color: CustomColors.whWhite,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.people_outline,
              color: CustomColors.whWhite,
              size: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Text(
                    '2024년 2월 27일',
                    style: TextStyle(
                      color: CustomColors.whWhite,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: CustomColors.whWhite,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: const Column(
                  children: [
                    ConfirmPostWidget(),
                    SizedBox(height: 12.0),
                    ConfirmPostWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmPostWidget extends ConsumerStatefulWidget {
  const ConfirmPostWidget({super.key});

  // final ConfirmPostEntity confirmPostEntity;

  @override
  ConsumerState<ConfirmPostWidget> createState() => _ConfirmPostWidgetState();
}

class _ConfirmPostWidgetState extends ConsumerState<ConfirmPostWidget> {
  ResolutionEntity? resEntity;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ref
        .watch(getMyResolutionListUsecaseProvider)
        .call(NoParams())
        .then((value) => value.fold((l) => null, (r) => r.first))
        .then((value) {
      if (value != null) {
        resEntity = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: CustomColors.whDarkBlack,
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: CustomColors.whGrey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        border: Border(
                          top: BorderSide(
                            width: 8.0,
                            color: CustomColors.whDarkBlack,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          left: BorderSide(
                            width: 8.0,
                            color: CustomColors.whDarkBlack,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          right: BorderSide(
                            width: 8.0,
                            color: CustomColors.whDarkBlack,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 4.0,
                        bottom: 12.0,
                      ),

                      // height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              UserProfileBar(
                                futureUserEntity: Future(
                                    () => right(UserDataEntity.dummyModel)),
                              ),
                              Text(
                                '오전 7시 38분',
                                style: TextStyle(
                                  color: CustomColors.whWhite,
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(height: 12.0),
                          if (resEntity != null)
                            ResolutionLinearGaugeWidget(
                              ResolutionListCellWidgetModel(
                                entity: resEntity!,
                                successCount: 3,
                              ),
                            ),
                          const SizedBox(height: 12.0),
                          ConfirmPostContentWidget(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          icon: const Icon(
                            Icons.chat_bubble_outline,
                            color: CustomColors.whWhite,
                          ),
                          label: const Text(
                            '코멘트',
                            style: TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          onPressed: () {},
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: CustomColors.whWhite,
                          ),
                          label: const Text(
                            '이모지',
                            style: TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          onPressed: () {},
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: CustomColors.whWhite,
                          ),
                          label: const Text(
                            '퀵샷',
                            style: TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmPostContentWidget extends StatelessWidget {
  const ConfirmPostContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (false) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 100,
              ),
              child: Text(
                '군인은 현역을 면한 후가 아니면 국무위원으로 임명될 수 없다. \n 국가는 사회보장·사회복지의 증진에 노력할 의무를 진다. 정당의 설립은 자유이며, 복수정당제는 보장된다.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: CustomColors.whWhite,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 4.0,
          ),
          if (false)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(64),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ]),
              clipBehavior: Clip.hardEdge,
              child: Image(
                fit: BoxFit.cover,
                width: 150,
                height: 100,
                image: NetworkImage(
                  'https://mblogthumb-phinf.pstatic.net/MjAxOTEyMDRfMjM0/MDAxNTc1NDI4ODY0MTEy.5DPI5kT24bspmKGFA1J3yDDNhrkmSbSg84VKWO2uegkg.1g5p5XKOvAV5rzm4vcXWoQN0Kkd9fwaUyU34oDev_s4g.PNG.caunselor/1.png?type=w800',
                ),
              ),
            ),
        ],
      );
    } else {
      if (false) {
        return Column(
          children: [
            Container(
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(64),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        )
                      ]),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://mblogthumb-phinf.pstatic.net/MjAxOTEyMDRfMjM0/MDAxNTc1NDI4ODY0MTEy.5DPI5kT24bspmKGFA1J3yDDNhrkmSbSg84VKWO2uegkg.1g5p5XKOvAV5rzm4vcXWoQN0Kkd9fwaUyU34oDev_s4g.PNG.caunselor/1.png?type=w800',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(64),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        )
                      ]),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://mblogthumb-phinf.pstatic.net/MjAxOTEyMDRfMjM0/MDAxNTc1NDI4ODY0MTEy.5DPI5kT24bspmKGFA1J3yDDNhrkmSbSg84VKWO2uegkg.1g5p5XKOvAV5rzm4vcXWoQN0Kkd9fwaUyU34oDev_s4g.PNG.caunselor/1.png?type=w800',
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(64),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://mblogthumb-phinf.pstatic.net/MjAxOTEyMDRfMjM0/MDAxNTc1NDI4ODY0MTEy.5DPI5kT24bspmKGFA1J3yDDNhrkmSbSg84VKWO2uegkg.1g5p5XKOvAV5rzm4vcXWoQN0Kkd9fwaUyU34oDev_s4g.PNG.caunselor/1.png?type=w800',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(64),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                )
                              ]),
                          clipBehavior: Clip.hardEdge,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://mblogthumb-phinf.pstatic.net/MjAxOTEyMDRfMjM0/MDAxNTc1NDI4ODY0MTEy.5DPI5kT24bspmKGFA1J3yDDNhrkmSbSg84VKWO2uegkg.1g5p5XKOvAV5rzm4vcXWoQN0Kkd9fwaUyU34oDev_s4g.PNG.caunselor/1.png?type=w800',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(64),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                )
                              ]),
                          clipBehavior: Clip.hardEdge,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://mblogthumb-phinf.pstatic.net/MjAxOTEyMDRfMjM0/MDAxNTc1NDI4ODY0MTEy.5DPI5kT24bspmKGFA1J3yDDNhrkmSbSg84VKWO2uegkg.1g5p5XKOvAV5rzm4vcXWoQN0Kkd9fwaUyU34oDev_s4g.PNG.caunselor/1.png?type=w800',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
  }
}
