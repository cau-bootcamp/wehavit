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
