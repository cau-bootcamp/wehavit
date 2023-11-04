import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/data/enitty/DEBUG_confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/widget/swipe_view_cell.dart';

class SwipeView extends ConsumerStatefulWidget {
  SwipeView({super.key});

  @override
  ConsumerState<SwipeView> createState() {
    // TODO: implement createState
    return SwipeViewState();
  }
}

class SwipeViewState extends ConsumerState<SwipeView> {
  @override
  Widget build(BuildContext context) {
    var swipeViewProviderList = ref.watch(swipeViewProvider);

    return Scaffold(
      // appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(swipeViewProvider.notifier).getTodayConfirmPostList();
      }),
      body: SafeArea(
        child: swipeViewProviderList.fold(
          (failure) => Container(
            color: Colors.cyan,
          ),
          (modelList) => Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: List<Widget>.generate(
                          modelList.length,
                          (index) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 20,
                                    color: Colors.blueGrey,
                                  ),
                                  SwipeViewCellWidget(
                                    model: modelList[index],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: Container()),
                                          ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.emoji_emotions),
                                            label: Text(""),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.emoji_emotions),
                                            label: Text(""),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
