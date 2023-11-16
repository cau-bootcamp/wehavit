import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/effects/effects.dart';
import 'package:wehavit/features/effects/text_animation/text_bubble_manager.dart';
import 'package:wehavit/features/reaction/presentation/provider/reaction_widget_provider.dart';

import '../../../effects/text_animation/text_bubble_widget.dart';

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
  Widget build(BuildContext context) {
    _reactionWidgetModel = ref.watch(reactionWidgetManagerProvider);
    _reactionWidgetManager = ref.watch(reactionWidgetManagerProvider.notifier);

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                _reactionWidgetManager.getReactionsNotReadFromLastConfirmPost();
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
                  children: _reactionWidgetModel.balloonWidgets.values.toList(),
                ),
              ],
            ),
          ),
          Stack(
            children: _reactionWidgetModel.textBubbleWidgets.values.toList(),
          ),
        ],
      ),
    );
  }
}
