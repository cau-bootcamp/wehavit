import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/my_page/presentation/providers/my_page_resolution_list_provider.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var resolutionListProvider = ref.watch(myPageResolutionListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("my page")),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextButton(
                child: Text("HELLO"),
                onPressed: () async {
                  await ref
                      .read(myPageResolutionListProvider.notifier)
                      .getActiveResolutionList();
                },
              ),
              resolutionListProvider.fold(
                (left) => null,
                (right) => Expanded(
                  child: ListView.builder(
                    itemCount: right.length,
                    itemBuilder: (context, index) {
                      return Text(right[index].goal);
                    },
                  ),
                ),
              ) as Widget,
            ],
          ),
        ),
      ),
    );
  }
}
