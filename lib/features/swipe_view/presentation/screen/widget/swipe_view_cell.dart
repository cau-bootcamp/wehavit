import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/presentation/model/swipe_view_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_model_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/widget/swipe_dashboard_widget.dart';

class SwipeViewCellWidget extends ConsumerStatefulWidget {
  const SwipeViewCellWidget({super.key, required this.model});

  final ConfirmPostModel model;

  @override
  ConsumerState<SwipeViewCellWidget> createState() =>
      _SwipeViewCellWidgetState();
}

class _SwipeViewCellWidgetState extends ConsumerState<SwipeViewCellWidget> {
  late final SwipeViewModel _swipeViewModel;
  late final SwipeViewModelProvider _swipeViewModelProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _swipeViewModel = ref.watch(swipeViewModelProvider);
    _swipeViewModelProvider = ref.read(swipeViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 프로필 영역
                Column(
                  children: [
                    FutureBuilder<UserModel>(
                      future: _swipeViewModel
                          .userModelList[_swipeViewModel.currentCellIndex],
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<UserModel> snapshot,
                      ) {
                        // 해당 부분은 data를 아직 받아 오지 못했을때 실행되는 코드
                        if (snapshot.hasData == false) {
                          return const SizedBox(
                            width: 65,
                            height: 65,
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError == true) {
                          return const SizedBox(
                            width: 65,
                            height: 65,
                            child: Placeholder(),
                          );
                        } else {
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                foregroundImage:
                                    NetworkImage(snapshot.data!.imageUrl),
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                snapshot.data!.displayName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              // ignore: lines_longer_than_80_chars
                              Text(
                                '· ${widget.model.resolutionGoalStatement ?? '목표를 불러오지 못했습니다'}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  widget.model.title ?? '',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  thickness: 2.5,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 16,
                ),
                // 사진 영역
                Expanded(
                  flex: 3,
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      widget.model.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Placeholder();
                      },
                      loadingBuilder: (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // 통계치 영역
                SizedBox(
                  height: _swipeViewModel.animation.value,
                  child: SwipeDashboardWidget(
                    confirmPostList: _swipeViewModel
                        .confirmPostList[_swipeViewModel.currentCellIndex],
                  ),
                ),

                const Divider(
                  thickness: 2.5,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 16,
                ),
                // 인증글 영역
                Container(
                  constraints: const BoxConstraints.expand(height: 120),
                  child: Text(
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    widget.model.content ?? '',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: _swipeViewModel.commentFieldFocus,
                        controller: _swipeViewModel.textEditingController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: '응원 메시지 남기기',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () {
                          _swipeViewModelProvider.startShrinkingLayout();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        _swipeViewModelProvider.sendTextReaction();
                      },
                      icon: const Icon(Icons.send),
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

class SwipeViewCellWidgetModel {
  SwipeViewCellWidgetModel({
    required this.confirmPostModel,
    required this.owner,
  });

  late final ConfirmPostModel confirmPostModel;
  late final UserModel owner;
}
