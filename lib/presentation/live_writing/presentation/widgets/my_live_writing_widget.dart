// ignore_for_file: discarded_futures
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';
import 'package:wehavit/domain/entities/resolution_model.dart';
import 'package:wehavit/domain/repositories/live_writing_mine_repository_provider.dart';
import 'package:wehavit/domain/repositories/user_model_fetch_repository.dart';
import 'package:wehavit/domain/usecases/confirm_post_usecase.dart';
import 'package:wehavit/presentation/live_writing/live_writing.dart';

class MyLiveWritingWidget extends StatefulHookConsumerWidget {
  const MyLiveWritingWidget({
    required this.resolutionModel,
    super.key,
  });

  final ResolutionModel resolutionModel;

  @override
  ConsumerState<MyLiveWritingWidget> createState() =>
      _MyLiveWritingWidgetState();
}

class _MyLiveWritingWidgetState extends ConsumerState<MyLiveWritingWidget> {
  // final _confirmPostFormKey = GlobalKey<FormState>();
  bool isSubmitted = false;
  late EitherFuture<UserModel> myUserModel;
  XFile? imageFile;
  String imageUrl = '';

  // bool isLoadingImage = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    myUserModel = ref
        .read(userModelFetchRepositoryProvider)
        .fetchUserModelFromId(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final isLoadingImage = useState(false);
    final hasDoneSubmit = useState(false);

    bool isSubmittable() {
      return titleController.text != '' &&
          contentController.text != '' &&
          imageFile != null;
    }

    useEffect(
      () {
        titleController.addListener(() async {
          ref
              .read(liveWritingPostRepositoryProvider)
              .updateTitle(titleController.text);

          hasDoneSubmit.value = isSubmittable();
        });

        contentController.addListener(() async {
          ref
              .read(liveWritingPostRepositoryProvider)
              .updateMessage(contentController.text);

          hasDoneSubmit.value = isSubmittable();
        });

        return null;
      },
      [],
    );

    return Align(
      alignment: const Alignment(1, 1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: CustomColors.whSemiBlack,
            ),
            width: constraints.maxWidth,
            height: 320,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  informationBarWidget(),
                  titleTextFormFieldWidget(titleController),
                  const Divider(
                    color: Colors.amber,
                    thickness: 2.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: contentTextFormFieldWidget(contentController),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 151,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 14.0,
                                bottom: 8.0,
                              ),
                              child: imageContainerWidget(
                                  isLoadingImage, isSubmittable),
                            ),
                            restOrSubmitButtonsWidget(
                              isSubmittable,
                              titleController,
                              contentController,
                              isLoadingImage,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row informationBarWidget() {
    return Row(
      children: [
        FutureBuilder(
          future: myUserModel,
          builder: (context, snapshot) {
            Widget subwidget;
            if (snapshot.hasData) {
              subwidget = snapshot.data!.fold(
                (l) => Container(),
                (r) => CircleAvatar(
                  // radius: 32,
                  foregroundImage: NetworkImage(r.imageUrl),
                ),
              );
            } else if (snapshot.hasError) {
              subwidget = const Placeholder();
            } else {
              subwidget = const CircularProgressIndicator();
            }
            return SizedBox(
              width: 64,
              height: 64,
              child: subwidget,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            FirebaseAuth.instance.currentUser!.displayName!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: CustomColors.whWhite,
            ),
          ),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            '· ${widget.resolutionModel.goalStatement}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CustomColors.whYellow,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  TextFormField titleTextFormFieldWidget(
    TextEditingController titleController,
  ) {
    return TextFormField(
      controller: titleController,
      readOnly: isSubmitted,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: CustomColors.whWhite,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '어떤 노력을 하셨나요?',
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: CustomColors.whSemiWhite.withAlpha(0xa0),
        ),
      ),
    );
  }

  TextFormField contentTextFormFieldWidget(
      TextEditingController contentController) {
    return TextFormField(
      controller: contentController,
      readOnly: isSubmitted,
      maxLines: 6,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: CustomColors.whWhite,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '오늘의 이야기를 들려주세요',
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: CustomColors.whWhite.withAlpha(0xa0),
        ),
      ),
    );
  }

  Container imageContainerWidget(
      ValueNotifier<bool> isLoadingImage, bool Function() isSubmittable) {
    return Container(
      width: 151,
      height: 104,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: GestureDetector(
        onTapUp: (details) async {
          if (!isSubmitted) {
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            if (pickedFile != null) {
              isLoadingImage.value = true;
              imageUrl = await setImage(pickedFile);
              isLoadingImage.value = false;
              isSubmittable();
            } else {
              debugPrint('이미지 선택안함');
            }
          }
        },
        child: Visibility(
          visible: imageFile != null,
          replacement: Container(
            decoration: BoxDecoration(
              color: CustomColors.whYellowBright,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 2,
                color: CustomColors.whYellow,
              ),
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_library_outlined),
                  SizedBox(width: 4),
                  Text(
                    '사진 추가하기',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whDarkBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: Image(
            fit: BoxFit.cover,
            image: FileImage(
              File(imageFile?.path ?? ''),
            ),
          ),
        ),
      ),
    );
  }

  Widget restOrSubmitButtonsWidget(
    bool Function() isSubmittable,
    TextEditingController titleController,
    TextEditingController contentController,
    ValueNotifier<bool> isLoadingImage,
  ) {
    if (isLoadingImage.value) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LinearProgressIndicator(
            color: CustomColors.whYellow,
            backgroundColor: CustomColors.whYellowBright,
          ),
          SizedBox(height: 5.0),
          Text(
            '사진을 공유하고 있습니다',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: CustomColors.whWhite,
            ),
          ),
        ],
      );
    } else {
      return Visibility(
        visible: !isSubmitted,
        replacement: ProviderScope(
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                isSubmitted = false;
              });
              // 다시 편집 상태로 돌아가기
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.whYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 15.0,
            ),
            child: const Text(
              '수정',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: CustomColors.whBlack,
              ),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () async {
                if (isSubmittable()) {
                  setState(() {
                    isSubmitted = true;
                  });

                  ConfirmPostModel cf = ConfirmPostModel(
                    title: titleController.text,
                    content: contentController.text,
                    resolutionGoalStatement:
                        widget.resolutionModel.goalStatement,
                    resolutionId: widget.resolutionModel.resolutionId,
                    imageUrl: imageUrl,
                    recentStrike: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    // repository impl에서 자동으로 채워짐
                    owner: '',
                    fan: widget.resolutionModel.fanList,
                    attributes: {
                      'has_participated_live': true,
                      'has_rested': true,
                    },
                  );

                  (await ref.read(
                    createPostUseCaseProvider,
                  )(cf))
                      .fold(
                    (l) {
                      debugPrint(
                        Failure(l.message).toString(),
                      );
                    },
                    (r) => () {},
                  );
                } else {
                  // 제출할 수 없음
                  debugPrint(
                    '제목, 내용, 사진이 모두 입력되지 않아 저장하지 않음',
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isSubmittable() ? CustomColors.whRed : CustomColors.whGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 15.0,
              ),
              child: const Text(
                '휴식',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.whWhite,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (isSubmittable()) {
                  setState(() {
                    isSubmitted = true;
                  });
                  ConfirmPostModel cf = ConfirmPostModel(
                    title: titleController.text,
                    content: contentController.text,
                    resolutionGoalStatement:
                        widget.resolutionModel.goalStatement,
                    resolutionId: widget.resolutionModel.resolutionId,
                    imageUrl: imageUrl,
                    recentStrike: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    owner: '',
                    fan: widget.resolutionModel.fanList,
                    attributes: {
                      'has_participated_live': true,
                      'has_rested': false,
                    },
                  );

                  (await ref.read(
                    createPostUseCaseProvider,
                  )(cf))
                      .fold(
                    (l) {
                      debugPrint(
                        Failure(l.message).toString(),
                      );
                    },
                    (r) => () {},
                  );
                } else {
                  // 제출할 수 없음
                  debugPrint(
                    '제목, 내용, 사진이 모두 입력되지 않아 저장하지 않음',
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSubmittable()
                    ? CustomColors.whYellow
                    : CustomColors.whGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 15.0,
              ),
              child: Text(
                '완료',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: isSubmittable()
                      ? CustomColors.whBlack
                      : CustomColors.whWhite,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> onSave() async {
    //getAllFanMarkedConfirmPosts();
    ref.read(confirmPostDatasourceProvider).getAllFanMarkedConfirmPosts();
    if (isSubmitted) {
      return;
    }
  }

  Future<String> setImage(XFile pickedFile) async {
    setState(() {
      imageFile = pickedFile;
    });
    return ref
        .read(
          liveWritingPostRepositoryProvider,
        )
        .updatePostImage(
          pickedFile.path,
        );
  }
}
