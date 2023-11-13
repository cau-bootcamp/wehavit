import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/features/my_page/presentation/providers/add_resolution_provider.dart';
import 'package:wehavit/features/my_page/presentation/providers/my_page_resolution_list_provider.dart';

// 여기에 뷰가 적용되면 수정할 예정임.
class AddResolutionScreen extends ConsumerWidget {
  const AddResolutionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(addResolutionProvider);
    final dayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const Text('나의 목표'),
          TextField(
            onChanged: (value) {
              ref
                  .read(addResolutionProvider.notifier)
                  .changeGoalStatement(value);
            },
          ),
          const Text('실천할 행동'),
          TextField(
            onChanged: (value) {
              ref
                  .read(addResolutionProvider.notifier)
                  .changeActionStatement(value);
            },
          ),
          const Text('실천 주기'),
          Row(
            children: Iterable<int>.generate(7).map((idx) {
              return Expanded(
                child: TextButton(
                  onPressed: () {
                    ref
                        .read(addResolutionProvider.notifier)
                        .changePeriodState(idx);
                  },
                  child: Text(
                    dayList[idx],
                    style: TextStyle(
                      color: provider.isDaySelectedList[idx]
                          ? Colors.red
                          : Colors.cyan,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const Text('나의 다짐'),
          TextField(
            onChanged: (value) {
              ref
                  .read(addResolutionProvider.notifier)
                  .changeOathStatement(value);
            },
          ),
          ElevatedButton(
            onPressed: () async {
              ref
                  .read(addResolutionProvider.notifier)
                  .uploadResolutionModel()
                  .then(
                (result) {
                  result.fold((failure) {
                    debugPrint('DEBUG : UPLOAD FAILED - ${failure.message}');
                  }, (success) {
                    ref
                        .read(myPageResolutionListProvider.notifier)
                        .getActiveResolutionList();
                    context.pop();
                  });
                },
              );
            },
            child: const Text('UPLOAD Button'),
          ),
        ],
      ),
    );
  }
}
