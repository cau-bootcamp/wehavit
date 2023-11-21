import 'dart:math';

import 'package:flutter/material.dart';

class LiveWaitingAvatarAnimatingWidget extends StatefulWidget {
  const LiveWaitingAvatarAnimatingWidget({super.key});

  @override
  State<LiveWaitingAvatarAnimatingWidget> createState() =>
      _LiveWaitingAvatarAnimatingWidgetState();
}

class _LiveWaitingAvatarAnimatingWidgetState
    extends State<LiveWaitingAvatarAnimatingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lifeTimeAnimationController;
  late final Animation _lifeTimeAnimation;
  late final Animation _positionXAnimation;
  late final Animation _positionYAnimation;

  final int _lifeCycleAnimationDuration = 2500; // millisecond
  double randomOffset = Random().nextDouble();

  @override
  void initState() {
    super.initState();

    _lifeTimeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _lifeCycleAnimationDuration),
    );
    _lifeTimeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _lifeTimeAnimationController,
        curve: Curves.linear,
      ),
    );
    _lifeTimeAnimationController.addListener(() {
      setState(() {});
    });
    _lifeTimeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _lifeTimeAnimationController.repeat();
      }
    });

    _positionXAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _lifeTimeAnimationController,
        curve: Curves.linear,
      ),
    );
    _positionYAnimation = Tween<double>(begin: -150, end: 1000).animate(
      CurvedAnimation(
        parent: _lifeTimeAnimationController,
        curve: Curves.easeOut,
      ),
    );

    Future.delayed(
      Duration(
        milliseconds: (2000 * randomOffset).toInt(),
      ),
      () => _lifeTimeAnimationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100 + randomOffset * 150 + sin(_positionXAnimation.value) * 30,
      bottom: _positionYAnimation.value,
      child: Opacity(
        opacity: 0.6 + (1 - _lifeTimeAnimation.value).toDouble() * 0.4,
        child: CircleAvatar(
          radius: 50 + sin(randomOffset) * 10,
          foregroundImage: const NetworkImage(
            'https://www.pumpkin.care/wp-content/uploads/2021/01/Ragdoll-Hero-jpg.webp',
          ),
        ),
      ),
    );
  }
}
