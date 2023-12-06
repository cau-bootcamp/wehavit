import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/late_writing/presentation/model/late_writing_view_model.dart';
import 'package:wehavit/features/late_writing/presentation/provider/late_writing_view_provider.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

class LateWritingView extends ConsumerStatefulWidget {
  const LateWritingView({super.key});

  @override
  ConsumerState<LateWritingView> createState() => _LateWritingViewState();
}

class _LateWritingViewState extends ConsumerState<LateWritingView> {
  late LateWritingViewModel viewModel;
  late LateWritingViewModelProvider viewModelProvider;

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(lateWritingViewModelProvider);
    viewModelProvider = ref.read(lateWritingViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('늦은 인증글 작성'),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          minimum: const EdgeInsets.all(8),
          child: FutureBuilder(
            future: viewModel.resolutionList,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isRight()) {
                final resolutionList = snapshot.data!
                    .getRight()
                    .fold(() => [], (t) => t) as List<ResolutionModel>;
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      '작성할 목표',
                                      style: TextStyle(fontSize: 24.0),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTapUp: (details) async {
                                      showResolutionSelectionList(
                                        context,
                                        resolutionList,
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              resolutionList[
                                                      viewModel.resolutionIndex]
                                                  .goalStatement,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TitleAndContentFormWidget(viewModel: viewModel),
                              // 사진
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTapUp: (details) async {
                                      viewModel.imageFileUrl =
                                          await viewModelProvider
                                              .getPhotoLibraryImage();
                                      setState(() {});
                                    },
                                    child: Visibility(
                                      visible: viewModel.imageFileUrl != null,
                                      replacement: const Center(
                                        child: Text('사진 추가하기'),
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image(
                                          image: FileImage(
                                            File(viewModel.imageFileUrl ?? ''),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          // Expanded(
                          //   child: Container(),
                          // ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              viewModelProvider.postCurrentConfirmPost();
                              // 인증글 작성 완료 다이얼로그(임시)
                              await showLatePostCompleteDialog(context);
                              viewModel.contentTextEditingController.clear();
                              viewModel.titleTextEditingController.clear();
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data!.isLeft()) {
                return const Center(
                  child: Text('DEBUG - SOMETHING WENT WRONG'),
                );
              } else {
                return const Placeholder();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> showLatePostCompleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('인증글 작성 완료!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showResolutionSelectionList(
    BuildContext context,
    List<ResolutionModel> resolutionList,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: List<Widget>.generate(
                resolutionList.length,
                (index) => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        viewModel.resolutionIndex = index;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      resolutionList[index].goalStatement,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TitleAndContentFormWidget extends StatelessWidget {
  const TitleAndContentFormWidget({
    super.key,
    required this.viewModel,
  });

  final LateWritingViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: viewModel.titleTextEditingController,
              decoration: const InputDecoration(
                hintText: '제목을 입력해주세요',
                border: InputBorder.none,
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
            TextFormField(
              controller: viewModel.contentTextEditingController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '오늘의 실천에 대해 한마디!',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
