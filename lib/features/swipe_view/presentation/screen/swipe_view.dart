import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  int _currentCellNumber = 0;
  final CarouselController _carouselController = CarouselController();

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
          (modelList) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 10,
                  color: Colors.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(
                      modelList.length,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            key: ValueKey(index),
                            // padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: _currentCellNumber == index
                                    ? Colors.amber
                                    : Colors.grey[400]),
                            height: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 1.0,
                        height: MediaQuery.of(context).size.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentCellNumber = index;
                          });
                        },
                        enableInfiniteScroll: false),
                    carouselController: _carouselController,
                    items: List<Widget>.generate(
                      modelList.length,
                      (index) {
                        return Flex(
                          direction: Axis.vertical,
                          children: [
                            SwipeViewCellWidget(
                              model: modelList[index],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
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
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
