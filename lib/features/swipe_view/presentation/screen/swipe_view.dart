import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_provider.dart';

class SwipeView extends ConsumerWidget {
  const SwipeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var swipeViewProviderList = ref.watch(swipeViewProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await ref
                    .read(swipeViewProvider.notifier)
                    .getTodayConfirmPostList();
                print(swipeViewProviderList.length());
              },
              child: Text("Tap Here")),
        ],
      )),
    );
  }
}
