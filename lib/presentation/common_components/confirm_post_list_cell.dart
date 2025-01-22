import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/reaction/quickshot_preset_provider.dart';

class ConfirmPostListCell extends StatefulWidget {
  const ConfirmPostListCell({
    super.key,
    required this.confirmPostEntity,
    this.showActions = true,
    required this.onSendCommentPressed,
    required this.onEmojiPressed,
    required this.onQuickshotLongPressStart,
    required this.onQuickshotLongPressMove,
    required this.onQuickshotLongPressEnd,
    required this.onQuickshotPaletteCellTapUp,
    required this.onQuickshotPaletteAddCellTapUp,
    required this.onQuickshotPaletteAddCellLongPressStart,
    required this.onQuickshotPaletteAddCellLongPressMove,
    required this.onQuickshotPaletteAddCellLongPressEnd,
  });

  final ConfirmPostEntity confirmPostEntity;
  final bool showActions;

  final Function() onSendCommentPressed;
  final Function() onEmojiPressed;

  final Function(LongPressStartDetails) onQuickshotLongPressStart;
  final Function(LongPressMoveUpdateDetails) onQuickshotLongPressMove;
  final Function(LongPressEndDetails) onQuickshotLongPressEnd;

  final Function(String) onQuickshotPaletteCellTapUp;
  final Function() onQuickshotPaletteAddCellTapUp;
  final Function(LongPressStartDetails) onQuickshotPaletteAddCellLongPressStart;
  final Function(LongPressMoveUpdateDetails) onQuickshotPaletteAddCellLongPressMove;
  final Function(LongPressEndDetails) onQuickshotPaletteAddCellLongPressEnd;

  @override
  State<ConfirmPostListCell> createState() => _ConfirmPostListCellState();
}

class _ConfirmPostListCellState extends State<ConfirmPostListCell> {
  bool isShowingQuickshotPreset = false;

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
              Stack(
                alignment: Alignment.bottomRight,
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
                            ConfirmPostUserProfile(
                              userEntity: UserDataEntity.dummyModel,
                              uploadedAt: widget.confirmPostEntity.updatedAt ?? DateTime.now(),
                            ),
                            if (widget.confirmPostEntity.hasRested)
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
                        ConfirmPostListCellContent(confirmPostEntity: widget.confirmPostEntity),
                      ],
                    ),
                  ),
                  if (isShowingQuickshotPreset)
                    Consumer(
                      builder: (context, ref, child) {
                        final asyncPalette = ref.watch(quickshotPresetProvider);

                        return asyncPalette.when(
                          data: (quickshotPresets) {
                            return Container(
                              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                              child: QuickshotPresetPalette(
                                quickshotPresets: quickshotPresets,
                                onQuickshotPresetPressed: (imageFileUrl) {
                                  widget.onQuickshotPaletteCellTapUp(imageFileUrl);
                                  setState(() {
                                    isShowingQuickshotPreset = false;
                                  });
                                },
                                onQuickshotPresetAddPressed: widget.onQuickshotPaletteAddCellTapUp,
                                onQuickshotPresetAddLongPressStart: widget.onQuickshotPaletteAddCellLongPressStart,
                                onQuickshotPresetAddLongPressMove: widget.onQuickshotPaletteAddCellLongPressMove,
                                onQuickshotPresetAddLongPressEnd: widget.onQuickshotPaletteAddCellLongPressEnd,
                              ),
                            );
                          },
                          error: (_, __) {
                            return Container();
                          },
                          loading: () {
                            return Container();
                          },
                        );
                      },
                    ),
                ],
              ),
              if (widget.showActions)
                ConfirmPostReactionButtonList(
                  onCommentPressed: widget.onSendCommentPressed,
                  onEmojiPressed: widget.onEmojiPressed,
                  onQuickshotTapUp: (_) {
                    setState(() {
                      isShowingQuickshotPreset = !isShowingQuickshotPreset;
                    });
                  },
                  onQuickshotLongPressStart: widget.onQuickshotLongPressStart,
                  onQuickshotLongPressMove: widget.onQuickshotLongPressMove,
                  onQuickshotLongPressEnd: widget.onQuickshotLongPressEnd,
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
    if (confirmPostEntity.content.isNotEmpty) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 100,
              ),
              child: Text(
                confirmPostEntity.content,
                textAlign: TextAlign.start,
                style: context.bodyMedium?.copyWith(color: CustomColors.whGrey900),
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          if (confirmPostEntity.imageUrlList.isNotEmpty)
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
                        confirmPostEntity.imageUrlList.first,
                      ),
                      loadingBuilder: (context, image, loadingProgress) {
                        if (loadingProgress == null) {
                          return Stack(
                            children: [
                              image,
                              if (confirmPostEntity.imageUrlList.length > 1)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: CustomColors.whBlack,
                                    ),
                                    child: Text(
                                      '+${confirmPostEntity.imageUrlList.length - 1}',
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
                final imageList = confirmPostEntity.imageUrlList.map((imageUrl) {
                  return NetworkImage(imageUrl);
                }).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmPostPhotoView(
                      imageProviderList: imageList,
                      initPageIndex: 0,
                    ),
                  ),
                );
              },
            ),
        ],
      );
    }
    if (confirmPostEntity.imageUrlList.isNotEmpty) {
      return Column(
        children: List<Widget>.generate(confirmPostEntity.imageUrlList.length, (index) {
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
                      confirmPostEntity.imageUrlList.first,
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

class QuickshotPresetPalette extends StatelessWidget {
  const QuickshotPresetPalette({
    required this.quickshotPresets,
    required this.onQuickshotPresetPressed,
    required this.onQuickshotPresetAddPressed,
    required this.onQuickshotPresetAddLongPressStart,
    required this.onQuickshotPresetAddLongPressMove,
    required this.onQuickshotPresetAddLongPressEnd,
    super.key,
  });

  static const int maxPreset = 5;

  final List<QuickshotPresetItemEntity> quickshotPresets;

  final Function(String) onQuickshotPresetPressed;
  final Function() onQuickshotPresetAddPressed;
  final Function(LongPressStartDetails) onQuickshotPresetAddLongPressStart;
  final Function(LongPressMoveUpdateDetails) onQuickshotPresetAddLongPressMove;
  final Function(LongPressEndDetails) onQuickshotPresetAddLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      decoration: BoxDecoration(
        color: CustomColors.whGrey100.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (quickshotPresets.isEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 8.0),
              child: Text(
                '미리 퀵샷을 찍어두고 보낼 수도 있어요\n저장 없이 보내려면 버튼을 꾹! 눌러주세요',
                style: context.bodySmall,
              ),
            ),
          ...quickshotPresets.map((entity) {
            return Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.whGrey100,
                  border: Border.all(color: CustomColors.whWhite),
                ),
                clipBehavior: Clip.hardEdge,
                child: MaterialButton(
                  onPressed: () async {
                    Dio dio = Dio();
                    final tempDir = (await getTemporaryDirectory()).path;

                    final tempDirPath = '$tempDir/preset_image';
                    final tempFileName = entity.id;

                    if (!(await Directory(tempDirPath).exists())) {
                      await Directory(tempDirPath).create(recursive: true);
                    }
                    final filePath = '$tempDirPath/$tempFileName';
                    final file = File('$tempDirPath/$tempFileName');
                    if (!(await file.exists())) {
                      final response = await dio.download(entity.url, filePath);

                      if (response.statusCode != 200) {
                        return;
                      }
                    }
                    onQuickshotPresetPressed(filePath);
                  },
                  onLongPress: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Consumer(
                          builder: (context, ref, child) {
                            return AlertDialog(
                              content: Text(
                                '저장된 퀵샷을 지우시겠어요?',
                                style: context.bodyMedium?.copyWith(color: CustomColors.whGrey100),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); //창 닫기
                                  },
                                  child: const Text('아니요'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(removeQuickshotPresetUsecaseProvider)
                                        .call(quickshotEntity: entity)
                                        .whenComplete(() async {
                                      ref.invalidate(quickshotPresetProvider);
                                    }).whenComplete(() {
                                      if (context.mounted) Navigator.of(context).pop(); //창 닫기
                                    });
                                  },
                                  child: const Text('네'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  padding: EdgeInsets.zero,
                  child: CircleProfileImage(
                    size: 40,
                    url: entity.url,
                  ),
                ),
              ),
            );
          }),
          // 추가 버튼
          if (quickshotPresets.length < maxPreset)
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.whGrey100,
                border: Border.all(
                  color: CustomColors.whWhite,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapUp: (_) => onQuickshotPresetAddPressed,
                onLongPressStart: onQuickshotPresetAddLongPressStart,
                onLongPressMoveUpdate: onQuickshotPresetAddLongPressMove,
                onLongPressEnd: onQuickshotPresetAddLongPressEnd,
                child: Container(
                  alignment: Alignment.center,
                  child: const Icon(
                    color: CustomColors.whBrightGrey,
                    Icons.add,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
