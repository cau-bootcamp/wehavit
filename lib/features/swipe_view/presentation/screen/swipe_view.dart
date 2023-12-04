import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';
import 'package:wehavit/features/swipe_view/presentation/model/swipe_view_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/emoji_sheet_widget.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/reaction_camera_widget.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/swipe_view_cell.dart';

class SwipeView extends ConsumerStatefulWidget {
  const SwipeView({super.key});

  @override
  ConsumerState<SwipeView> createState() {
    return SwipeViewState();
  }
}

class SwipeViewState extends ConsumerState<SwipeView>
    with SingleTickerProviderStateMixin {
  late final SwipeViewModel _swipeViewModel;
  late final SwipeViewModelProvider _swipeViewModelProvider;

  bool _initOccurred = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initOccurred) {
      _swipeViewModel = ref.watch(swipeViewModelProvider);
      _swipeViewModelProvider = ref.read(swipeViewModelProvider.notifier);
      await ref
          .read(swipeViewModelProvider.notifier)
          .getTodayConfirmPostModelList();

      await _swipeViewModelProvider.initializeCamera();

      _swipeViewModel.cameraButtonPosition =
          _swipeViewModelProvider.getCameraButtonPosition() ??
              const Offset(0, 0);

      setAnimationVariables();

      setState(() {});
      _initOccurred = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SafeArea(
              child: _swipeViewModel.confirmPostModelList.fold(
                (failure) => Container(
                  color: Colors.cyan,
                ),
                (modelList) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 10,
                        color: Colors.blueGrey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List<Widget>.generate(
                            modelList.length,
                            (modelIndex) => Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  key: ValueKey(modelIndex),
                                  decoration: BoxDecoration(
                                    color: _swipeViewModel.currentCellIndex ==
                                            modelIndex
                                        ? Colors.amber
                                        : Colors.grey[400],
                                  ),
                                  height: 8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              _swipeViewModelProvider.unfocusCommentTextForm(),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              height: MediaQuery.of(context).size.height,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _swipeViewModel.currentCellIndex = index;
                                });
                              },
                              enableInfiniteScroll: false,
                            ),
                            carouselController:
                                _swipeViewModel.carouselController,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_swipeViewModel.isCameraInitialized)
            ReactionCameraWidget(
              originPosition: _swipeViewModel.cameraButtonPosition,
              cameraController: _swipeViewModel.cameraController,
            ),
        ],
      ),
    );
  }

  void setAnimationVariables() {
    _swipeViewModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _swipeViewModel.animation = Tween<double>(begin: 0, end: 130).animate(
      CurvedAnimation(
        parent: _swipeViewModel.animationController,
        curve: Curves.linear,
      ),
    );
    _swipeViewModel.animationController.value = 1;
  }
}
