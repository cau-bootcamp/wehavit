import 'dart:math';

import 'package:flutter/material.dart';

/// EmojiFireWork 를 통해 예쁜 이모지 폭죽을 쏠 수 있습니다!
///
/// ## 변수 리스트
/// - emojiAsset: 불꽃놀이 이펙트로 사용할 에셋을 `AssetImage` 타입으로 전달
/// - emojiLifetimeDurationSec: 이모지가 화면을 날아다니는 전체 시간 (생명시간) - default는 5
/// - emojiShootDurationSec: 이모지가 처음에 터지면서 퍼지는 시간 - default는 2
/// - emojiShootingXScale: 이모지가 처음에 퍼질 때 X축 방향으로 퍼지는 정도 - default는 3
/// - emojiShootingYScale: 이모지가 처음에 퍼질 때 Y축 방향으로 퍼지는 정도 - default는 5
/// - emojiFloatingXScale: 이모지가 퍼진 후 떠다닐 때 X축으로 움직이는 정도 - default는 20
/// - emojiShootingYScale: 이모지가 퍼진 후 떠다닐 때 Y축으로 움직이는 정도 - 음수를 넣으면 이모지가 아래로 떨어짐 - default는 1
/// - emojiSizeDeltaScale: 이모지가 퍼진 후 커졌다 작아졌다 하는 정도 - default는 0.3
/// - emojiTransparentThreshold: 이모지가 퍼진 후 애니메이션 수명이 다하기 전에 사라지는 임계 조건값 -
/// 값이 커지면 끝까지 유지되는 이모지의 수가 많아짐, 최대 1 - default는 0.9
/// - emojiSize: 파티클 이모지의 크기 - default는 40
///
/// ## 사용 방법
/// 1. `EmojiFireWork emojiFireWork = EmojiFireWork(emojiAsset: asset));` 을 위잿 내에 선언
/// 2. `Stack(children: emojiFireWork.fireworkWidgets.values.toList())` 을 builder 내 필요한 위치에 배치
/// 3. `emojiFireWork.addFireworkWidget(offset)` 으로 offset 위치에 이모지 이펙트를 생성 (top-left 기준 offset)
///
class EmojiFireWorkManager {
  EmojiFireWorkManager({
    required this.emojiAsset,
    this.emojiAmount = 30,
    this.emojiLifetimeDurationSec = 5,
    this.emojiShootDurationSec = 2,
    this.emojiShootingXScale = 3,
    this.emojiShootingYScale = 5,
    this.emojiFloatingXScale = 20,
    this.emojiFloatingYScale = 1,
    this.emojiSizeDeltaScale = 0.3,
    this.emojiTransparentThreshold = 0.9,
    this.emojiSize = 40,
  });

  // properties
  final AssetImage emojiAsset;
  final int emojiAmount;
  late Map<Key, _FireworkWidget> fireworkWidgets = {};

  final int emojiLifetimeDurationSec;
  final int emojiShootDurationSec;

  final double emojiShootingXScale;
  final double emojiShootingYScale;
  final double emojiFloatingXScale;
  final double emojiFloatingYScale;
  final double emojiSizeDeltaScale;
  final double emojiTransparentThreshold;
  final double emojiSize;

  // methods
  void addFireworkWidget(Offset offset) {
    final fireworkWidgetKey = UniqueKey();

    fireworkWidgets.addEntries(<Key, _FireworkWidget>{
      fireworkWidgetKey: _FireworkWidget(
        key: fireworkWidgetKey,
        notifyWidgetIsDisposed: (UniqueKey widgetKey) {
          fireworkWidgets.remove(widgetKey);
        },
        offset: offset,
        emojiAsset: emojiAsset,
        emojiAmount: emojiAmount,
        emojiLifetimeDurationSec: emojiLifetimeDurationSec,
        emojiShootDurationSec: emojiShootDurationSec,
        emojiShootingXScale: emojiShootingXScale,
        emojiShootingYScale: emojiShootingYScale,
        emojiFloatingXScale: emojiFloatingXScale,
        emojiFloatingYScale: emojiFloatingYScale,
        emojiSizeDeltaScale: emojiSizeDeltaScale,
        emojiTransparentThreshold: emojiTransparentThreshold,
        emojiSize: emojiSize,
      )
    }.entries);
  }
}

class _FireworkWidget extends StatefulWidget {
  const _FireworkWidget({
    super.key,
    required this.notifyWidgetIsDisposed,
    required this.offset,
    required this.emojiAsset,
    required this.emojiAmount,
    required this.emojiLifetimeDurationSec,
    required this.emojiShootDurationSec,
    required this.emojiShootingXScale,
    required this.emojiShootingYScale,
    required this.emojiFloatingXScale,
    required this.emojiFloatingYScale,
    required this.emojiSizeDeltaScale,
    required this.emojiTransparentThreshold,
    required this.emojiSize,
  });
  final Function notifyWidgetIsDisposed;
  final AssetImage emojiAsset;
  final Offset offset;
  final int emojiAmount;
  final int emojiLifetimeDurationSec;
  final int emojiShootDurationSec;
  final double emojiShootingXScale;
  final double emojiShootingYScale;
  final double emojiFloatingXScale;
  final double emojiFloatingYScale;
  final double emojiSizeDeltaScale;
  final double emojiTransparentThreshold;
  final double emojiSize;

  @override
  State<_FireworkWidget> createState() => _FireworkWidgetState();
}

class _FireworkWidgetState extends State<_FireworkWidget>
    with TickerProviderStateMixin {
  // 불꽃놀이에서 움직이는 각각의 위젯들을 담아두는 리스트
  late List<EmojiWidget> emojiWidgetList;

  // 3가지 움직임을 위해, 3가지 AnimationController를 선언
  late final AnimationController emojiAnimationShootController,
      emojiAnimationFloatController,
      emojiAnimationLifeTimeController;

  // AnimationController의 값에 대해 움직이는 double 값(Animation)들을 선언
  late final Animation<double> emojiShootAnimation,
      emojiFloatYAnimation,
      emojiFloatXAnimation,
      emojiLifeTimeAnimation;

  // 애니메이션 지속 시간을 결정하는 변수
  late final Duration _emojiLifetimeDuration =
      Duration(seconds: widget.emojiLifetimeDurationSec);
  late final Duration _emojiShootDuration =
      Duration(seconds: widget.emojiShootDurationSec);

  // 이펙트로 한 번에 나오는 이모지의 개수
  late final int emojiAmount = widget.emojiAmount;

  @override
  void initState() {
    super.initState();
    setAnimationController();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: List.generate(
            emojiAmount,
            (index) => EmojiWidget(
              offset: widget.offset,
              emojiAsset: widget.emojiAsset,
              emojiFloatXAnimation: emojiFloatXAnimation,
              emojiFloatYAnimation: emojiFloatYAnimation,
              emojiShootAnimation: emojiShootAnimation,
              emojiLifeTimeAnimation: emojiLifeTimeAnimation,
              emojiShootingXScale: widget.emojiShootingXScale,
              emojiShootingYScale: widget.emojiShootingYScale,
              emojiFloatingXScale: widget.emojiFloatingXScale,
              emojiFloatingYScale: widget.emojiFloatingYScale,
              emojiSizeDeltaScale: widget.emojiSizeDeltaScale,
              emojiTransparentThreshold: widget.emojiTransparentThreshold,
              emojiSize: widget.emojiSize,
            ),
          ),
        ),
      ),
    );
  }
}

extension _FireworkWidgetStateAnimations on _FireworkWidgetState {
  void setAnimationController() {
    // 이모지가 폭죽처럼 발사되는 Animation 관련 값 초기화
    emojiAnimationShootController = AnimationController(
      vsync: this,
      duration: _emojiShootDuration,
    );
    emojiShootAnimation = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: emojiAnimationShootController,
      curve: Curves.easeOutCubic,
    ));
    emojiShootAnimation.addListener(() {
      // ignore: invalid_use_of_protected_member
      setState(() {});
    });

    // 이모지가 하늘로 날아가는 Animation 관련 값 초기화
    // 가로 움직임과 세로 움직임이 별개이기 때문에, Animation을 X와 Y로 분리하였음
    emojiAnimationFloatController = AnimationController(
        vsync: this,
        duration: Duration(seconds: _emojiLifetimeDuration.inSeconds));
    emojiFloatXAnimation = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: emojiAnimationFloatController,
        curve: Curves.linear,
      ),
    );
    emojiFloatYAnimation = Tween(begin: -50.0, end: 2000.0).animate(
      CurvedAnimation(
        parent: emojiAnimationFloatController,
        curve: Curves.easeIn,
      ),
    );
    emojiFloatXAnimation.addListener(() {
      // ignore: invalid_use_of_protected_member
      setState(() {});
    });
    emojiFloatYAnimation.addListener(() {
      // ignore: invalid_use_of_protected_member
      setState(() {});
    });

    // 불꽃놀이 위젯 자체의 지속시간과 관련된 Animation 관련 값 초기화
    // 여기에서 이모지 크기를 조정할 수 있는 애니메이션을 제공한다.
    emojiAnimationLifeTimeController =
        AnimationController(vsync: this, duration: _emojiLifetimeDuration);
    emojiLifeTimeAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: emojiAnimationLifeTimeController, curve: Curves.linear));
    emojiLifeTimeAnimation.addListener(() {
      // ignore: invalid_use_of_protected_member
      setState(() {});
    });
    emojiLifeTimeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.notifyWidgetIsDisposed(widget.key);
      }
    });
  }

  void startAnimation() {
    emojiAnimationShootController.forward(from: 0.0);
    emojiAnimationFloatController.forward(from: 0.0);
    emojiAnimationLifeTimeController.forward(from: 0.0);
  }
}

class EmojiWidget extends StatefulWidget {
  const EmojiWidget({
    super.key,
    required this.emojiShootAnimation,
    required this.emojiFloatYAnimation,
    required this.emojiFloatXAnimation,
    required this.emojiLifeTimeAnimation,
    required this.emojiAsset,
    required this.offset,
    required this.emojiShootingXScale,
    required this.emojiShootingYScale,
    required this.emojiFloatingXScale,
    required this.emojiFloatingYScale,
    required this.emojiSizeDeltaScale,
    required this.emojiTransparentThreshold,
    required this.emojiSize,
  });

  final AssetImage emojiAsset;
  final Animation<double> emojiShootAnimation,
      emojiFloatYAnimation,
      emojiFloatXAnimation,
      emojiLifeTimeAnimation;
  final Offset offset;

  final double emojiShootingXScale;
  final double emojiShootingYScale;
  final double emojiFloatingXScale;
  final double emojiFloatingYScale;
  final double emojiSizeDeltaScale;
  final double emojiTransparentThreshold;
  final double emojiSize;

  @override
  State<EmojiWidget> createState() => EmojiWidgetState();
}

class EmojiWidgetState extends State<EmojiWidget> {
  late final double randomScaleX, randomScaleY, distinctiveRandomSeed;

  late final double emojiShootingXScale;
  late final double emojiShootingYScale;
  late final double emojiFloatingXScale;
  late final double emojiFloatingYScale;
  late final double emojiSizeDeltaScale;
  late final double emojiTransparentThreshold;
  late final double emojiSize;

  @override
  void initState() {
    super.initState();

    emojiShootingXScale = widget.emojiShootingXScale;
    emojiShootingYScale = widget.emojiShootingYScale;
    emojiFloatingXScale = widget.emojiFloatingXScale;
    emojiFloatingYScale = widget.emojiFloatingYScale;
    emojiSizeDeltaScale = widget.emojiSizeDeltaScale;
    emojiTransparentThreshold = widget.emojiTransparentThreshold;
    emojiSize = widget.emojiSize;

    randomScaleX = Random().nextDouble() * 2 - 1;
    randomScaleY = Random().nextDouble() * 2 - 1;
    distinctiveRandomSeed = Random().nextDouble();
  }

  @override
  Widget build(BuildContext context) {
    var emojiAnimationShootX =
        widget.emojiShootAnimation.value * emojiShootingXScale * randomScaleX;
    var emojiAnimationShootY =
        widget.emojiShootAnimation.value * emojiShootingYScale * randomScaleY;

    var emojiAnimationFloatX =
        sin(widget.emojiFloatXAnimation.value + distinctiveRandomSeed) *
            emojiFloatingXScale;
    var emojiAnimationFloatY = widget.emojiFloatYAnimation.value < 0
        ? 0
        : widget.emojiFloatYAnimation.value * -1 * emojiFloatingYScale;

    var emojiAnimationPositionX =
        widget.offset.dx + emojiAnimationShootX + emojiAnimationFloatX;
    var emojiAnimationPositionY =
        widget.offset.dy + emojiAnimationShootY + emojiAnimationFloatY;

    var emojiScale = sin(
                (widget.emojiLifeTimeAnimation.value + distinctiveRandomSeed) *
                    10) *
            emojiSizeDeltaScale +
        1;
    bool isEmojiTransparent =
        (widget.emojiLifeTimeAnimation.value + distinctiveRandomSeed) / 2 >
            emojiTransparentThreshold;

    return Positioned(
      left: emojiAnimationPositionX - emojiSize / 2,
      top: emojiAnimationPositionY - emojiSize / 2,
      child: Opacity(
        opacity: isEmojiTransparent ? 0.0 : 1.0,
        child: Image(
          image: widget.emojiAsset,
          width: emojiSize * emojiScale,
          height: emojiSize * emojiScale,
        ),
      ),
    );
  }
}
