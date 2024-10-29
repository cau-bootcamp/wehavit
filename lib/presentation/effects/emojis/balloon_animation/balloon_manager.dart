import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 화면 위에서 타원모양을 그리며 터트릴 수 있는 위젯을 그려줍니다.
///
/// - radius 값을 수정하면 풍선의 크기를 조절할 수 있음
/// - onTapCallbackWithTappedPositionOffset에 콜백을 담아 tap되었을 때 tap된 위치를 활용해 로직을 호출할 수 있음
/// - addBalloon 함수를 호출하면서 imageUrl로 URL을 전달하면, 해당 이미지를 풍선 위에 그림
///
/// ## 사용 방법
/// 0. Riverpod 라이브러리를 사용하고 있어서, ConsumerStatefulWidget을 사용해줘야 함
/// 1. `_balloonWidgets = ref.watch(balloonManagerProvider);` 을 통해 풍선 정보들을 받아와서
/// 2. `Stack(children: _balloonWidgets.values.toList())` list로 변환 후 Stack 에 담아서 위젯을 그려주기
/// 3. `_balloonManager = ref.read(balloonManagerProvider.notifier)`를 통해 가져온 _ballonManagerProvider에 대해
///  `_balloonManager.addBalloon(imageUrl: url)` 함수를 호출해 풍선을 추가해주기
class BalloonManager extends StateNotifier<Map<Key, BalloonWidget>> {
  BalloonManager() : super({});

  late Function(Offset, List<int>, String, String)?
      onTapCallbackWithTappedPositionOffset;
  double radius = 130;

  void addBalloon({
    required String imageUrl,
    required List<int> emojiReactionCountList,
    required String message,
  }) {
    final balloonWidgetKey = UniqueKey();

    // 이모지 없이 사진만 온 경우에는 하트를 채워서 보여주기
    emojiReactionCountList = fillEmptyEmojiBalloon(emojiReactionCountList);

    final newBalloon = {
      balloonWidgetKey: BalloonWidget(
        key: balloonWidgetKey,
        imageUrl: imageUrl,
        notifyWidgetIsDisposed: (Key widgetKey) {
          state = Map.of(state..remove(widgetKey));
        },
        onTapWithOffset: (Offset offset) {
          onTapCallbackWithTappedPositionOffset!(
            offset,
            emojiReactionCountList,
            message,
            imageUrl,
          );
        },
        radius: radius,
      ),
    };

    state = {
      ...state,
      ...newBalloon,
    };
  }

  List<int> fillEmptyEmojiBalloon(List<int> emojiList) {
    if (emojiList.isEmpty) {
      emojiList = List<int>.filled(15, 0);
      emojiList.last = 1;
    }
    return emojiList;
  }
}

class BalloonWidget extends StatefulWidget {
  const BalloonWidget({
    required super.key,
    required this.imageUrl,
    required this.notifyWidgetIsDisposed,
    required this.onTapWithOffset,
    required this.radius,
  });

  final String imageUrl;
  final Function notifyWidgetIsDisposed;
  final Function(Offset) onTapWithOffset;
  final double radius;

  @override
  State<BalloonWidget> createState() => _BalloonWidgetState();
}

class _BalloonWidgetState extends State<BalloonWidget>
    with TickerProviderStateMixin {
  // animation variables
  late AnimationController _animationController;
  late Animation _animation;

  double wind = 0.1;
  double speed = 0.1;

  late BalloonModel balloonModel;

  late final double width;
  late final double height;

  @override
  void initState() {
    super.initState();

    // 불꽃놀이 위젯 자체의 지속시간과 관련된 Animation 관련 값 초기화
    // 여기에서 이모지 크기를 조정할 수 있는 값을 제공한다.
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.repeat();
      }
    });
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    balloonModel = BalloonModel(
      x: 50 + Random().nextDouble() * (width - 100 - 130),
      y: 100 + Random().nextDouble() * (height - 200 - 130),
    );

    _startAnimation();
  }

  void _startAnimation() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BalloonParticleWidget(
      x: balloonModel.x + 50 * sin(_animation.value),
      y: balloonModel.y + 25 * cos(_animation.value),
      imageUrl: widget.imageUrl,
      notifyWidgetIsDisposed: notifyWidgetIsDisposed,
      radius: widget.radius,
    );
  }

  void notifyWidgetIsDisposed() {
    _animationController.dispose();
    widget.onTapWithOffset(
      Offset(
        balloonModel.x + 50 * sin(_animation.value) + 65, // radius of photo
        balloonModel.y + 25 * cos(_animation.value) + 65, // radius of photo
      ),
    );
    widget.notifyWidgetIsDisposed(widget.key);
  }
}

class BalloonParticleWidget extends StatelessWidget {
  const BalloonParticleWidget({
    super.key,
    required this.x,
    required this.y,
    required this.imageUrl,
    required this.notifyWidgetIsDisposed,
    required this.radius,
  });

  final double x;
  final double y;
  final String imageUrl;
  final double radius;

  final Function notifyWidgetIsDisposed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: GestureDetector(
        onTapUp: (details) {
          notifyWidgetIsDisposed();
        },
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: radius,
            height: radius,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}

class BalloonModel {
  BalloonModel({
    required this.x,
    required this.y,
  });
  double x;
  double y;
}
