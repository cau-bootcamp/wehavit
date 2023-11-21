import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';

class ShootEmojiWidget extends StatefulWidget {
  const ShootEmojiWidget({
    super.key,
    required this.disposeWidgetFromParent,
    required this.currentPos,
    required this.targetPos,
    required this.emojiIndex,
  });
  final int emojiIndex;
  final Function disposeWidgetFromParent;
  final Point currentPos;
  final Point targetPos;

  @override
  State<ShootEmojiWidget> createState() => _ShootEmojiWidgetState();
}

class _ShootEmojiWidgetState extends State<ShootEmojiWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _yAnimation, _xAnimation;
  late Function disposeWidgetFromParent;
  late double targetXPos;
  final double emojiSize = 50;

  @override
  void initState() {
    super.initState();

    disposeWidgetFromParent = widget.disposeWidgetFromParent;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _yAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _xAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward(from: 0.0);
    _controller.addListener(
      () {
        if (mounted) {
          setState(() {});
        }
      },
    );
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          disposeWidgetFromParent(widget.key);
          // dispose();
          // super.dispose();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (widget.targetPos.y * 1.0 * _yAnimation.value) +
          (400) * (1 - _yAnimation.value),
      left: widget.targetPos.x.toDouble() * _xAnimation.value +
          (widget.currentPos.x.toDouble()) * (1 - _xAnimation.value) -
          emojiSize / 2,
      child: Opacity(
        opacity: _controller.status == AnimationStatus.completed ? 0.0 : 1.0,
        child: Image(
          width: emojiSize,
          height: emojiSize,
          image: AssetImage(
            Emojis.emojiList[widget.emojiIndex],
          ),
        ),
      ),
    );
  }
}
