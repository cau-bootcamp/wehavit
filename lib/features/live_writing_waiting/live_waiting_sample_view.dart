import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing_waiting/presentation/view/live_waiting_view.dart';

final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());

class LiveWaitingSampleView extends HookConsumerWidget {
  const LiveWaitingSampleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.amber,
                  ],
                ),
              ),
            ),
            const LiveWritingView(),
          ],
        ),
      ),
    );
  }
}
