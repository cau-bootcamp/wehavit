// ignore_for_file: discarded_futures
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/live_writing.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/swipe_view/domain/repository/user_model_fetch_repository_provider.dart';

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
  bool isLoadingImage = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    myUserModel = ref
        .read(userModelFetchRepositoryProvider)
        .fetchUserModelFromId(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    var titleController = useTextEditingController();
    var contentController = useTextEditingController();

    useEffect(
      () {
        titleController.addListener(() async {
          ref
              .read(liveWritingPostRepositoryProvider)
              .updateTitle(titleController.text);
        });
        contentController.addListener(() async {
          ref
              .read(liveWritingPostRepositoryProvider)
              .updateMessage(contentController.text);
        });

        return null;
      },
      [],
    );

    bool isSubmittable() {
      return !(titleController.text == '' ||
          contentController.text == '' ||
          imageFile == null ||
          isLoadingImage == true);
    }

    return Align(
      alignment: const Alignment(1, 1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Colors.grey.shade800,
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 14.0,
                                bottom: 8.0,
                              ),
                              child: imageContainerWidget(),
                            ),
                            restOrSubmitButtonsWidget(
                              isSubmittable,
                              titleController,
                              contentController,
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
          ),
        ),
        Expanded(child: Container()),
        Text(widget.resolutionModel.goalStatement),
      ],
    );
  }

  TextFormField titleTextFormFieldWidget(
      TextEditingController titleController) {
    return TextFormField(
      controller: titleController,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: '제목',
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  TextFormField contentTextFormFieldWidget(
      TextEditingController contentController) {
    return TextFormField(
      controller: contentController,
      maxLines: 6,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: '본문',
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Container imageContainerWidget() {
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
              isLoadingImage = true;
              imageUrl = await setImage(pickedFile);
              isLoadingImage = false;
            } else {
              debugPrint('이미지 선택안함');
            }
          }
        },
        child: Visibility(
          visible: imageFile != null,
          replacement: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: const Center(
              child: Text('Tap To Add Image'),
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
  ) {
    return Visibility(
      visible: !isSubmitted,
      replacement: ElevatedButton(
        onPressed: () async {
          setState(() {
            isSubmitted = false;
          });
          // 다시 편집 상태로 돌아가기
        },
        child: const Text('수정'),
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
                  resolutionGoalStatement: widget.resolutionModel.goalStatement,
                  resolutionId: widget.resolutionModel.resolutionId,
                  imageUrl: imageUrl,
                  recentStrike: 0,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  owner: '',
                  fan: [],
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
            child: Text(isLoadingImage ? '처리중' : '휴식'),
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
                  resolutionGoalStatement: widget.resolutionModel.goalStatement,
                  resolutionId: widget.resolutionModel.resolutionId,
                  imageUrl: imageUrl,
                  recentStrike: 0,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  owner: '',
                  fan: [],
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
            child: Text(isLoadingImage ? '처리중' : '완료'),
          ),
        ],
      ),
    );
  }

  Future<void> onSave() async {
    //getAllFanMarkedConfirmPosts();
    ref.read(confirmPostDatasourceProvider).getAllFanMarkedConfirmPosts();
    if (isSubmitted) {
      return;
    }

    // if (_confirmPostFormKey.currentState!.validate()) {
    //   _confirmPostFormKey.currentState!.save();
    //   isSubmitted = true;
    // onSubmit(titleController.text, contentController.text);
    // }
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
