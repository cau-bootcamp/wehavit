import 'package:flutter/material.dart';

class TextBubbleFrameWidget extends StatelessWidget {
  const TextBubbleFrameWidget({
    super.key,
    required this.killWidgetCallback,
    required this.message,
    required this.userImageUrl,
  });
  final Function killWidgetCallback;
  final String message;
  final String userImageUrl;

  void killWidget() {
    killWidgetCallback(super.key);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextBubbleWidget(
              message: message,
              userImageUrl: userImageUrl,
              killWidgetCallback: killWidget,
            ),
          ],
        ),
      ),
    );
  }
}

class TextBubbleWidget extends StatefulWidget {
  const TextBubbleWidget({
    super.key,
    required this.message,
    required this.userImageUrl,
    required this.killWidgetCallback,
  });

  final String message;
  final String userImageUrl;
  final Function killWidgetCallback;

  @override
  State<TextBubbleWidget> createState() => _TextBubbleWidgetState();
}

class _TextBubbleWidgetState extends State<TextBubbleWidget> with TickerProviderStateMixin {
  late final AnimationController _lifetimeAnimationController;
  late final AnimationController _avatarAnimationController;
  late final AnimationController _textBubbleAnimationController;
  late final AnimationController _disappearAnimationController;

  late final Animation _textBubbleAnimation;
  late final Animation _disappearAnimation;
  late final double _width;

  late final Function killWidgetCallback;

  void killWidget() {
    killWidgetCallback();
  }

  @override
  void initState() {
    super.initState();

    killWidgetCallback = widget.killWidgetCallback;

    _lifetimeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    _lifetimeAnimationController.addListener(() {
      setState(() {});
    });
    _avatarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _avatarAnimationController.addListener(() {
      setState(() {});
    });
    _textBubbleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _textBubbleAnimationController.addListener(() {
      setState(() {});
    });
    _disappearAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _disappearAnimationController.addListener(() {
      setState(() {});
    });

    _textBubbleAnimation = Tween<double>(begin: 0, end: 400).animate(
      CurvedAnimation(
        parent: _textBubbleAnimationController,
        curve: Curves.easeOutCirc,
      ),
    );
    _disappearAnimation = Tween<double>(begin: 0, end: 400).animate(
      CurvedAnimation(
        parent: _disappearAnimationController,
        curve: Curves.easeInCirc,
      ),
    );

    _avatarAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textBubbleAnimationController.forward();
      }
    });

    _lifetimeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _disappearAnimationController.forward();
      }
    });

    _disappearAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _avatarAnimationController.dispose();
        _disappearAnimationController.dispose();
        _lifetimeAnimationController.dispose();
        _textBubbleAnimationController.dispose();

        killWidget();
      }
    });

    _avatarAnimationController.forward();
    _lifetimeAnimationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _width = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 500),
      height: 500,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: _textBubbleAnimation.value - 300 + _disappearAnimation.value,
            child: GestureDetector(
              onTapUp: (details) {
                _lifetimeAnimationController.stop();
                _disappearAnimationController.forward();
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 500,
                width: _width - 16,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Opacity(
                          opacity: _textBubbleAnimationController.value - _disappearAnimationController.value,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                                bottomLeft: Radius.circular(16.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                widget.message,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: _avatarAnimationController.value * 150 + (-100),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 500,
              width: _width - 16,
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Opacity(
                        opacity: _avatarAnimationController.value - _disappearAnimationController.value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              foregroundImage: NetworkImage(widget.userImageUrl),
                            ),
                          ),
                        ),
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
