import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase_provider.dart';
import 'package:wehavit/features/swipe_view/presentation/provider/swipe_view_cell_user_model_provider.dart';

class SwipeViewCellWidget extends ConsumerStatefulWidget {
  SwipeViewCellWidget({super.key, required this.model});

  ConfirmPostModel model;

  @override
  ConsumerState<SwipeViewCellWidget> createState() =>
      _SwipeViewCellWidgetState();
}

class _SwipeViewCellWidgetState extends ConsumerState<SwipeViewCellWidget> {
  late FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);

    // TODO : User
    return Expanded(
      child: Center(
        child: Column(
          children: [
            // 프로필 영역
            Column(
              children: [
                FutureBuilder(
                  future: _fetchUserDataFromIdUsecase.call(
                    widget.model.roles!.keys.firstWhere(
                      (element) => widget.model.roles![element] == "owner",
                    ),
                  ),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                    if (snapshot.hasData == false) {
                      return Container(
                        width: 80,
                        height: 100,
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError == true) {
                      return Container(
                        width: 80,
                        height: 100,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            foregroundImage: snapshot.data.fold(
                              (failure) => null,
                              (model) => NetworkImage(
                                model.imageUrl,
                              ),
                            ),
                            backgroundColor: Colors.grey,
                          ),
                          Text(
                            snapshot.data.fold(
                              (failure) => "NoName",
                              (model) => model.displayName,
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
            // 사진 영역
            // padding: const EdgeInsets.symmetric(vertical: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  child: Image.network(
                    widget.model.imageUrl ?? "",
                    errorBuilder: (context, error, stackTrace) {
                      return Placeholder();
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 120,
                child: Container(color: Colors.amber),
              ),
            ),
            // 인증글 영역
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                color: Colors.pink.shade200,
                constraints: const BoxConstraints.expand(height: 120),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(widget.model.title ?? ""),
                      ),
                      Divider(
                        thickness: 2.5,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          widget.model.content ?? "",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwipeViewCellWidgetModel {
  SwipeViewCellWidgetModel(
      {required this.confirmPostModel, required this.owner});

  late final ConfirmPostModel confirmPostModel;
  late final UserModel owner;
}
