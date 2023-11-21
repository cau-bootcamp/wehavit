import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/presentation/model/swipe_view_model.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_model_provider.dart';

class SwipeViewCellWidget extends ConsumerStatefulWidget {
  const SwipeViewCellWidget({super.key, required this.model});

  final ConfirmPostModel model;

  @override
  ConsumerState<SwipeViewCellWidget> createState() =>
      _SwipeViewCellWidgetState();
}

class _SwipeViewCellWidgetState extends ConsumerState<SwipeViewCellWidget> {
  late final SwipeViewModel _swipeViewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _swipeViewModel = ref.watch(swipeViewModelProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
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
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError == true) {
                      return const SizedBox(
                        width: 100,
                        height: 100,
                        child: Placeholder(),
                      );
                    } else {
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            foregroundImage:
                                NetworkImage(snapshot.data!.imageUrl),
                            backgroundColor: Colors.grey,
                          ),
                          Text(
                            snapshot.data!.displayName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
            // 사진 영역
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  constraints: const BoxConstraints.expand(),
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
            ),
            // 통계치 영역
            SizedBox(
              height: _swipeViewModel.animation.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  color: Colors.amber,
                ),
              ),
            ),

            // 인증글 영역
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                color: Colors.pink.shade200,
                constraints: const BoxConstraints.expand(height: 120),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(widget.model.title ?? ''),
                      ),
                      const Divider(
                        thickness: 2.5,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.model.content ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
