import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/reaction/presentation/provider/reaction_widget_provider.dart';

class ReactionWidget extends ConsumerStatefulWidget {
  const ReactionWidget({super.key});

  @override
  ConsumerState<ReactionWidget> createState() => _ReactionWidgetState();
}

class _ReactionWidgetState extends ConsumerState<ReactionWidget> {
  late ReactionWidgetModel _reactionWidgetModel;
  late ReactionWidgetManager _reactionWidgetManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _reactionWidgetModel = ref.watch(reactionWidgetManagerProvider);
    _reactionWidgetManager = ref.read(reactionWidgetManagerProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _reactionWidgetManager.drawReactionWidgets();
                  });
                },
                child: Text("Get Last Confirm Post's Encourage Data")),
            Positioned(
              top: 100,
              child: Container(
                color: Colors.black26,
              ),
            ),
            Container(
              constraints: const BoxConstraints.expand(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IgnorePointer(
                    child: Stack(
                      children: _reactionWidgetModel
                          .emojiFireWork.fireworkWidgets.values
                          .toList(),
                    ),
                  ),
                  Stack(
                    children:
                        _reactionWidgetModel.balloonWidgets.values.toList(),
                  ),
                ],
              ),
            ),
            Stack(
              children: _reactionWidgetModel.textBubbleWidgets.values.toList(),
            ),
          ],
        ),
      ),
    );
  }
}
