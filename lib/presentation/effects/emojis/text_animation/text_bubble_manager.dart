import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/presentation/effects/emojis/text_animation/text_bubble_widget.dart';

final textBubbleAnimationManagerProvider =
    StateNotifierProvider<TextBubbleAnimationManager, Map<Key, TextBubbleFrameWidget>>(
  (ref) {
    return TextBubbleAnimationManager();
  },
);

/// 간단한 텍스트 메시지를 보여주는 위젯을 화면에 그려줍니다.
/// - message 에 받은 메시지를 담기
/// - imageUrl에 친구의 프로필사진 URL을 담기
///
/// ## 사용 방법
/// 1. `_textBubbleWidgets = ref.watch(textBubbleAnimationManagerProvider);`
/// 을 통해 풍선 정보들을 받아와서
/// 2. `Stack(children: _textBubbleWidgets.values.toList())` list로 변환 후 Stack
/// 에 담아서 위젯을 그려주기
/// 3. `_textBubbleAnimationManager = ref.read(textBubbleAnimationManagerProvider.notifier)`를
/// 통해 가져온 textBubbleAnimationManager 대해
///  `_textBubbleAnimationManager.addTextBubble(...)` 함수를 호출해 위젯을 추가해주기
class TextBubbleAnimationManager extends StateNotifier<Map<Key, TextBubbleFrameWidget>> {
  TextBubbleAnimationManager() : super({});

  List<TextBubbleWidget> queue = [];

  void addTextBubble({
    required String message,
    required String imageUrl,
  }) {
    if (message == '') return;

    final widgetKey = UniqueKey();
    state.addEntries(
      {
        widgetKey: TextBubbleFrameWidget(
          key: widgetKey,
          killWidgetCallback: (Key key) {
            state.remove(key);
          },
          message: message,
          userImageUrl: imageUrl,
        ),
      }.entries,
    );
  }
}
