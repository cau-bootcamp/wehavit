import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/features/my_page/presentation/providers/add_resolution_provider.dart';
import 'package:wehavit/features/my_page/presentation/providers/my_page_resolution_list_provider.dart';

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
      body: Column(children: [
        Text("나의 목표"),
        TextField(
          onChanged: (value) {
            ref.read(addResolutionProvider.notifier).changeGoalStatement(value);
          },
        ),
        Text("실천할 행동"),
        TextField(),
        Text("실천 주기"),
        Row(
          children: [
            Expanded(
                child: TextButton(
                    onPressed: () {
                      ref
                          .read(addResolutionProvider.notifier)
                          .changePeriodState(0);
                    },
                    child: Text(
                      'Mon',
                      style: TextStyle(
                        color: provider.isDaySelectedList[0]
                            ? Colors.red
                            : Colors.cyan,
                      ),
                    ))),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      ref
                          .read(addResolutionProvider.notifier)
                          .changePeriodState(1);
                    },
                    child: Text(
                      "Tue",
                      style: TextStyle(
                        color: provider.isDaySelectedList[1]
                            ? Colors.red
                            : Colors.cyan,
                      ),
                    ))),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      ref
                          .read(addResolutionProvider.notifier)
                          .changePeriodState(2);
                    },
                    child: Text(
                      "Wed",
                      style: TextStyle(
                        color: provider.isDaySelectedList[2]
                            ? Colors.red
                            : Colors.cyan,
                      ),
                    ))),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      ref
                          .read(addResolutionProvider.notifier)
                          .changePeriodState(3);
                    },
                    child: Text(
                      "Thu",
                      style: TextStyle(
                        color: provider.isDaySelectedList[3]
                            ? Colors.red
                            : Colors.cyan,
                      ),
                    ))),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      ref
                          .read(addResolutionProvider.notifier)
                          .changePeriodState(4);
                    },
                    child: Text(
                      "Fri",
                      style: TextStyle(
                        color: provider.isDaySelectedList[4]
                            ? Colors.red
                            : Colors.cyan,
                      ),
                    ))),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      ref
                          .read(addResolutionProvider.notifier)
                          .changePeriodState(5);
                    },
                    child: Text(
                      "Sat",
                      style: TextStyle(
                        color: provider.isDaySelectedList[5]
                            ? Colors.red
                            : Colors.cyan,
                      ),
                    ))),
            Expanded(
              child: TextButton(
                onPressed: () {
                  ref.read(addResolutionProvider.notifier).changePeriodState(6);
                },
                child: Text(
                  "Sun",
                  style: TextStyle(
                    color: provider.isDaySelectedList[6]
                        ? Colors.red
                        : Colors.cyan,
                  ),
                ),
              ),
            ),
          ],
          // TODO: 이렇게 변경하고 싶은데, 잘 작동을 안하네 흠..
          // children: Iterable<int>.generate(7).map((idx) {
          //   return Expanded(
          //     child: TextButton(
          //       onPressed: () {
          //         ref
          //             .read(addResolutionProvider.notifier)
          //             .changePeriodState(idx);
          //       },
          //       child: Text(
          //         dayList[idx],
          //         style: TextStyle(
          //           color: provider.isDaySelectedList[idx]
          //               ? Colors.red
          //               : Colors.cyan,
          //         ),
          //       ),
          //     ),
          //   );
          // }).toList(),
        ),
        Text("나의 다짐"),
        TextField(),
        ElevatedButton(
            onPressed: () async {
              ref
                  .read(addResolutionProvider.notifier)
                  .uploadResolutionModel()
                  .then(
                (result) {
                  result.fold((failure) {
                    print('DEBUG : UPLOAD FAILED - ${failure.message}');
                  }, (success) {
                    ref
                        .read(myPageResolutionListProvider.notifier)
                        .getActiveResolutionList();
                    context.pop();
                  });
                },
              );
            },
            child: Text("UPLOAD Button"))
      ]),
    );
  }
}
