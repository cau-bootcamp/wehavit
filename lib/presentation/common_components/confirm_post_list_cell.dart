import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/resolution_linear_gauge_indicator.dart';
import 'package:wehavit/presentation/common_components/user_profile_cell.dart';
import 'package:wehavit/presentation/presentation.dart';

class ConfirmPostListCell extends StatelessWidget {
  const ConfirmPostListCell({
    required this.confirmPostEntity,
    this.showActions = true,
    required this.onCommentPressed,
    required this.onEmojiPressed,
    required this.onQuickshotTapUp,
    required this.onQuickshotLongPressStart,
    required this.onQuickshotLongPressMove,
    required this.onQuickshotLongPressEnd,
    super.key,
  });

  final ConfirmPostEntity confirmPostEntity;
  final bool showActions;

  final Function() onCommentPressed;
  final Function() onEmojiPressed;
  final Function(TapUpDetails) onQuickshotTapUp;
  final Function(LongPressStartDetails) onQuickshotLongPressStart;
  final Function(LongPressMoveUpdateDetails) onQuickshotLongPressMove;
  final Function(LongPressEndDetails) onQuickshotLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: CustomColors.whGrey100,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            border: Border(
              top: BorderSide(width: 4.0, color: CustomColors.whGrey100),
              left: BorderSide(width: 4.0, color: CustomColors.whGrey100),
              right: BorderSide(width: 4.0, color: CustomColors.whGrey100),
              bottom: BorderSide(width: 4.0, color: CustomColors.whGrey100),
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: CustomColors.whGrey300,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                constraints: const BoxConstraints(minHeight: 200),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        const UserProfileCell(type: UserProfileCellType.normal),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomColors.whRed300,
                          ),
                          child: Text(
                            '오늘 실천 실패',
                            style: context.labelSmall?.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    // ResolutionLinearGaugeIndicator(resolutionEntity: resolutionEntity, futureDoneList: futureDoneList),
                    // const SizedBox(height: 12.0),
                    ConfirmPostListCellContent(confirmPostEntity: confirmPostEntity),
                  ],
                ),
              ),
              if (showActions)
                ConfirmPostReactionButtonList(
                  onCommentPressed: () {},
                  onEmojiPressed: () {},
                  onQuickshotTapUp: (_) {},
                  onQuickshotLongPressStart: (_) {},
                  onQuickshotLongPressMove: (_) {},
                  onQuickshotLongPressEnd: (_) {},
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class ConfirmPostListCellContent extends StatelessWidget {
  const ConfirmPostListCellContent({required this.confirmPostEntity, super.key});

  final ConfirmPostEntity confirmPostEntity;

  @override
  Widget build(BuildContext context) {
    if (confirmPostEntity.content != null && confirmPostEntity.content!.isNotEmpty) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 100,
              ),
              child: Text(
                confirmPostEntity.content ?? '',
                textAlign: TextAlign.start,
                style: context.bodyMedium?.copyWith(color: CustomColors.whGrey900),
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          if (confirmPostEntity.imageUrlList!.isNotEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: CustomColors.whGrey100,
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: CustomColors.whGrey100,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image(
                      image: NetworkImage(
                        confirmPostEntity.imageUrlList!.first,
                      ),
                      loadingBuilder: (context, image, loadingProgress) {
                        if (loadingProgress == null) {
                          return Stack(
                            children: [
                              image,
                              if (confirmPostEntity.imageUrlList!.length > 1)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: CustomColors.whBlack,
                                    ),
                                    child: Text(
                                      '+${confirmPostEntity.imageUrlList!.length - 1}',
                                      style: context.labelMedium?.bold,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        } else {
                          return const SizedBox(
                            width: 150,
                            height: 100,
                            child: Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
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
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                // TODO: 이미지 보여주는 페이지로 이동
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ConfirmPostPhotoView(
                //       imageProviderList: imageList,
                //       initPageIndex: 0,
                //     ),
                //   ),
                // );
              },
            ),
        ],
      );
    }
    if (confirmPostEntity.imageUrlList != null && confirmPostEntity.imageUrlList!.isNotEmpty) {
      return Column(
        children: List<Widget>.generate(confirmPostEntity.imageUrlList?.length ?? 0, (index) {
          return Container(
            padding: EdgeInsets.only(top: index == 0 ? 0.0 : 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: CustomColors.whGrey100,
              ),
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: CustomColors.whGrey100,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    image: NetworkImage(
                      confirmPostEntity.imageUrlList!.first,
                    ),
                    loadingBuilder: (context, image, loadingProgress) {
                      if (loadingProgress == null) {
                        return image;
                      } else {
                        return const Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: CustomColors.whYellow,
                            ),
                          ),
                        );
                      }
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onPressed: () {
                // TODO: 이미지 보여주는 페이지로 이동
              },
            ),
          );
        }),
      );
    } else {
      return SizedBox(
        height: 100,
        child: Center(
          child: Text(
            '오늘 실천 완료!',
            textAlign: TextAlign.center,
            style: context.bodyMedium,
          ),
        ),
      );
    }
  }
}

class ConfirmPostReactionButtonList extends ConsumerWidget {
  const ConfirmPostReactionButtonList({
    super.key,
    required this.onCommentPressed,
    required this.onEmojiPressed,
    required this.onQuickshotTapUp,
    required this.onQuickshotLongPressStart,
    required this.onQuickshotLongPressMove,
    required this.onQuickshotLongPressEnd,
  });
  final Function() onCommentPressed;
  final Function() onEmojiPressed;
  final Function(TapUpDetails) onQuickshotTapUp;
  final Function(LongPressStartDetails) onQuickshotLongPressStart;
  final Function(LongPressMoveUpdateDetails) onQuickshotLongPressMove;
  final Function(LongPressEndDetails) onQuickshotLongPressEnd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: double.infinity,
            child: TextButton.icon(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              icon: const WHIcon(size: WHIconsize.small, iconString: WHIcons.reactionComment),
              label: Text('메시지', style: context.labelLarge?.copyWith(color: CustomColors.whGrey900)),
              onPressed: onCommentPressed,
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              icon: const WHIcon(size: WHIconsize.small, iconString: WHIcons.reactionEmoji),
              label: Text('이모지', style: context.labelLarge?.copyWith(color: CustomColors.whGrey900)),
              onPressed: onEmojiPressed,
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapUp: onQuickshotTapUp,
            onLongPressStart: onQuickshotLongPressStart,
            onLongPressMoveUpdate: onQuickshotLongPressMove,
            onLongPressEnd: onQuickshotLongPressEnd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WHIcon(size: WHIconsize.small, iconString: WHIcons.reactionQuickshot),
                  const SizedBox(width: 8.0),
                  Text('퀵샷', style: context.labelLarge?.copyWith(color: CustomColors.whGrey900)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
