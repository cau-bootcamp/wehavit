import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class GroupPostView extends ConsumerStatefulWidget {
  const GroupPostView({super.key, required this.groupEntity});

  final GroupEntity groupEntity;

  @override
  ConsumerState<GroupPostView> createState() => _GroupPostViewState();
}

class _GroupPostViewState extends ConsumerState<GroupPostView> {
  List<DateTime> calendartMondayDateList = [
    DateTime.now(),
    DateTime.now().subtract(const Duration(days: 7)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.groupEntity.groupName,
          style: const TextStyle(
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
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                children: [
                  Row(
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
                  Visibility(
                    visible: true,
                    child: Container(
                      padding: EdgeInsets.only(top: 12),
                      child: CarouselSlider.builder(
                        itemBuilder: (context, index, realIndex) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List<Widget>.generate(
                              7,
                              (jndex) => Expanded(
                                child: GestureDetector(
                                  onTapUp: (details) {
                                    print('tap date');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    height: 64,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Container(
                                      height: 64,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: CustomColors.whBlack,
                                          width: 2,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            offset: Offset(0, 0),
                                            color: CustomColors.whBlack,
                                          ),
                                          BoxShadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 6,
                                            color: CustomColors.whYellow,
                                            // color: CustomColors.whGrey,
                                            // color: CustomColors.whYellowDark,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '30',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              // color: CustomColors.whPlaceholderGrey,
                                              color: CustomColors.whBlack,
                                            ),
                                          ),
                                          Text(
                                            index.toString(),
                                            style: TextStyle(
                                              height: 1.0,
                                              fontFamily: 'Giants',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              // color: CustomColors.whPlaceholderGrey,
                                              color: CustomColors.whBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: calendartMondayDateList.length,
                        options: CarouselOptions(
                          height: 64,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          reverse: true,
                          initialPage: calendartMondayDateList.length - 1,
                          onPageChanged: (index, reason) {
                            if (index == calendartMondayDateList.length - 1) {
                              // 마지막 페이지에 도달했을 때 추가 요소를 추가합니다.
                              calendartMondayDateList.insert(
                                0,
                                calendartMondayDateList.first.subtract(
                                  const Duration(days: 7),
                                ),
                              );
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20.0),
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
  ConfirmPostEntity? confirmPostEntity;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ref
        .watch(getMyResolutionListUsecaseProvider)
        .call(NoParams())
        .then((value) => value.fold((l) => null, (r) => r.first))
        .then((value) async {
      if (value != null) {
        resEntity = value;
        confirmPostEntity = await ref
            .watch(getConfirmPostListForResolutionIdUsecaseProvider)
            (resEntity!.resolutionId ?? '')
            .then(
          (value) {
            return value.fold((l) => null, (pList) => pList.first);
          },
        );
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
                        ),
                        left: BorderSide(
                          width: 8.0,
                          color: CustomColors.whDarkBlack,
                        ),
                        right: BorderSide(
                          width: 8.0,
                          color: CustomColors.whDarkBlack,
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
                                () => right(UserDataEntity.dummyModel),
                              ),
                            ),
                            Text(
                              // ignore: lines_longer_than_80_chars
                              '${confirmPostEntity!.createdAt!.hour > 12 ? '오전' : '오후'} ${confirmPostEntity!.createdAt!.hour > 12 ? confirmPostEntity!.createdAt!.hour - 12 : confirmPostEntity!.createdAt!.hour}시 ${confirmPostEntity!.createdAt!.minute}분',
                              style: const TextStyle(
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
                        ConfirmPostContentWidget(
                          confirmPostEntity: confirmPostEntity!,
                        ),
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
        ],
      ),
    );
  }
}

class ConfirmPostContentWidget extends StatelessWidget {
  const ConfirmPostContentWidget({
    super.key,
    required this.confirmPostEntity,
  });
  final ConfirmPostEntity confirmPostEntity;

  @override
  Widget build(BuildContext context) {
    if (confirmPostEntity.content != null && confirmPostEntity.content! != '') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 100,
              ),
              child: Text(
                confirmPostEntity.content!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: CustomColors.whWhite,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          if (confirmPostEntity.imageUrlList!.isNotEmpty)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(64),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return Stack(
                          children: [
                            child,
                            if (confirmPostEntity.imageUrlList!.length > 1)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  // ignore: lines_longer_than_80_chars
                                  '+${confirmPostEntity.imageUrlList!.length - 1}',
                                  style: const TextStyle(
                                    color: CustomColors.whWhite,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        );
                      } else {
                        return Container(
                          color: CustomColors.whBlack,
                          child: const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: CustomColors.whYellow,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    fit: BoxFit.cover,
                    width: 150,
                    height: 100,
                    image: NetworkImage(
                      confirmPostEntity.imageUrlList!.first,
                    ),
                  ),
                ),
              ],
            ),
        ],
      );
    } else {
      if (confirmPostEntity.imageUrlList!.length == 1) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(64),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        color: CustomColors.whBlack,
                        child: const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: CustomColors.whYellow,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    confirmPostEntity.imageUrlList![0],
                  ),
                ),
              ),
            ),
          ],
        );
      } else if (confirmPostEntity.imageUrlList!.length == 2) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(64),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        color: CustomColors.whBlack,
                        child: const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: CustomColors.whYellow,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    confirmPostEntity.imageUrlList![0],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(64),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        color: CustomColors.whBlack,
                        child: const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: CustomColors.whYellow,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    confirmPostEntity.imageUrlList![1],
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
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(64),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Container(
                          color: CustomColors.whBlack,
                          child: const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: CustomColors.whYellow,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      confirmPostEntity.imageUrlList![0],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(64),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image(
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                color: CustomColors.whBlack,
                                child: const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: CustomColors.whYellow,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            confirmPostEntity.imageUrlList![1],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(64),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image(
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                color: CustomColors.whBlack,
                                child: const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: CustomColors.whYellow,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            confirmPostEntity.imageUrlList![2],
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
