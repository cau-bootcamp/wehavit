import 'dart:math';

import 'package:flutter/material.dart';

class LiveWaitingAvatarAnimatingWidget extends StatefulWidget {
  const LiveWaitingAvatarAnimatingWidget({
    super.key,
    required this.userImageUrl,
  });

  final String userImageUrl;

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

    _positionXAnimation =
        Tween<double>(begin: 0, end: Random().nextDouble() * 10).animate(
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
  void dispose() {
    _lifeTimeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100 + randomOffset * 150 + sin(_positionXAnimation.value) * 30,
      bottom: _positionYAnimation.value,
      child: Opacity(
        opacity: 0.6 + (1 - _lifeTimeAnimation.value).toDouble() * 0.4,
        child: Container(
          width: 100 + sin(randomOffset) * 20,
          height: 100 + sin(randomOffset) * 20,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: NetworkImage(
                widget.userImageUrl,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
            border: Border.all(
              color: Colors.white,
              width: 4.0,
            ),
          ),
        ),
      ),
    );
  }
}
