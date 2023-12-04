import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/presentation/model/swipe_view_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/emoji_sheet_widget.dart';

import '../../../../common/utils/emoji_assets.dart';

class ConfirmPostWidget extends ConsumerStatefulWidget {
  const ConfirmPostWidget({super.key, required this.model});

  final ConfirmPostModel model;

  @override
  ConsumerState<ConfirmPostWidget> createState() {
    return _ConfirmPostWidgetState();
  }
}

class _ConfirmPostWidgetState extends ConsumerState<ConfirmPostWidget>
    with SingleTickerProviderStateMixin {
  late String userName = widget.model.userName;
  late String? userImageUrl = widget.model.userImageUrl;
  late String resolutionGoalStatement = widget.model.resolutionGoalStatement;
  late String title = widget.model.title;
  late String content = widget.model.content;
  late String? contentImageUrl = widget.model.contentImageUrl;
  late Timestamp postAt = widget.model.postAt;
  late final SwipeViewModel _swipeViewModel;
  late final SwipeViewModelProvider _swipeViewModelProvider;

  bool _initOccurred = false;
  bool _isTextFieldActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initOccurred) {
      _swipeViewModel = ref.watch(swipeViewModelProvider);
      _swipeViewModelProvider = ref.read(swipeViewModelProvider.notifier);
      await ref
          .read(swipeViewModelProvider.notifier)
          .getTodayConfirmPostModelList();

      await _swipeViewModelProvider.initializeCamera();

      _swipeViewModel.cameraButtonPosition =
          _swipeViewModelProvider.getCameraButtonPosition() ??
              const Offset(0, 0);

      setAnimationVariables();

      setState(() {});
      _initOccurred = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: CustomColors.whDarkBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: userImageUrl != null
                            ? NetworkImage(userImageUrl!)
                                as ImageProvider<Object>
                            : const AssetImage('DEBUG_IMAGE'),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userName,
                        style: const TextStyle(
                          color: CustomColors.whSemiWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ), // icon, name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: CustomColors.whYellowDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          resolutionGoalStatement,
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ), //goal name
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: CustomColors.whSemiWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 2,
                width: 345,
                color: CustomColors.whYellow,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 120,
                    width: 180,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      strutStyle: const StrutStyle(fontSize: 16.0),
                      text: TextSpan(
                        text: content,
                      ),
                    ),
                  ),
                  //title
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 4 / 3, // 4:3 비율 설정
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: contentImageUrl != null
                                ? NetworkImage(contentImageUrl!)
                                    as ImageProvider<Object>
                                : const AssetImage('DEBUG_IMAGE'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 게시물 하단 격려 남기기 기능들
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (_isTextFieldActive)
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: TextFormField(
                          controller: _swipeViewModel.textEditingController,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                          cursorColor: CustomColors.whYellow,
                          // 여기에 적절한 커스텀 색상을 사용하세요
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            fillColor: CustomColors.whYellowDark,
                            // 여기에 적절한 커스텀 색상을 사용하세요
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  IconButton(
                    onPressed: () async {
                      if (_isTextFieldActive == true) {
                        await _swipeViewModelProvider.sendTextReaction();
                      }
                      setState(() {
                        _isTextFieldActive =
                            !_isTextFieldActive; // 버튼이 눌릴 때마다 텍스트 필드의 보임/숨김 상태를 토글합니다
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 24,
                    ),
                  ),
                  GestureDetector(
                    onTapUp: (details) async =>
                        emojiSheetWidget(context).whenComplete(() async {
                      _swipeViewModelProvider.sendEmojiReaction();
                    }),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '😄',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    key: _swipeViewModel.cameraButtonPlaceholderKey,
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        _swipeViewModel.isCameraInitialized == true
                            ? '📸'
                            : '❌',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
//                  IconButton(
//                    icon: const Icon(
//                      Icons.emoji_emotions,
//                    ),
//                    onPressed: () {
//                      // 기능 연결
//                    },
//                  ),
//                  IconButton(
//                    icon: const Icon(Icons.camera_alt,
//                        color: CustomColors.whYellow),
//                    onPressed: () {
//                      // 기능 연결
//                    },
//                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> emojiSheetWidget(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
      context: context,
      builder: (context) {
        void disposeWidget(UniqueKey key) {
          setState(() {
            _swipeViewModel.emojiWidgets.remove(key);
          });
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: _swipeViewModel.emojiWidgets.values.toList(),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Text(
                        '반응을 ${_swipeViewModel.countSend}회 보냈어요!',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: List<Widget>.generate(
                          3,
                          (index) => Row(
                            children: List<Widget>.generate(5, (jndex) {
                              final key = GlobalKey();
                              return Expanded(
                                key: key,
                                child: GestureDetector(
                                  onTapDown: (detail) {},
                                  onTapUp: (detail) {
                                    shootEmoji(
                                      setState,
                                      index,
                                      jndex,
                                      detail,
                                      context,
                                      disposeWidget,
                                    );
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          Emojis.emojiList[index * 5 + jndex],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void setAnimationVariables() {
    _swipeViewModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _swipeViewModel.animation = Tween<double>(begin: 0, end: 130).animate(
      CurvedAnimation(
        parent: _swipeViewModel.animationController,
        curve: Curves.linear,
      ),
    );
    _swipeViewModel.animationController.value = 1;
  }

  void shootEmoji(
    StateSetter setState,
    int index,
    int jndex,
    TapUpDetails detail,
    BuildContext context,
    void Function(UniqueKey key) disposeWidget,
  ) {
    return setState(
      () {
        _swipeViewModel.countSend++;
        _swipeViewModel.sendingEmojis[index * 5 + jndex] += 1;
        final animationWidgetKey = UniqueKey();
        _swipeViewModel.emojiWidgets.addEntries(
          {
            animationWidgetKey: ShootEmojiWidget(
              key: animationWidgetKey,
              emojiIndex: index * 5 + jndex,
              currentPos:
                  Point(detail.globalPosition.dx, detail.globalPosition.dy),
              targetPos: Point(
                MediaQuery.of(context).size.width / 2,
                MediaQuery.of(context).size.height + 50,
              ),
              disposeWidgetFromParent: disposeWidget,
            ),
          }.entries,
        );
      },
    );
  }
}
