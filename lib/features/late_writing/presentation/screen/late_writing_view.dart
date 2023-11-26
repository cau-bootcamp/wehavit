import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:wehavit/features/late_writing/presentation/model/late_writing_view_model.dart';
import 'package:wehavit/features/late_writing/presentation/provider/late_writing_view_provider.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

class LateWritingView extends ConsumerStatefulWidget {
  const LateWritingView({super.key});

  @override
  ConsumerState<LateWritingView> createState() => _LateWritingViewState();
}

class _LateWritingViewState extends ConsumerState<LateWritingView> {
  late final viewModel = ref.watch(lateWritingViewModelProvider);
  late final viewModelProvider =
      ref.read(lateWritingViewModelProvider.notifier);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          left: true,
          right: true,
          minimum: EdgeInsets.all(8),
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
                      padding: EdgeInsets.only(bottom: 40),
                      child: Container(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  resolutionList[viewModel
                                                          .resolutionIndex]
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
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                TitleAndContentFormWidget(viewModel: viewModel),
                                // 사진
                                photoSelectWidget(
                                  viewModel: viewModel,
                                  viewModelProvider: viewModelProvider,
                                ),
                              ],
                            ),
                            // Expanded(
                            //   child: Container(),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                viewModelProvider.postCurrentConfirmPost();
                              },
                              child: Text("Save"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data!.isLeft()) {
                return const Center(
                  child: Text('DEBUG - SOMETHING WENT WRONG'),
                );
              } else {
                return Placeholder();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> showResolutionSelectionList(
      BuildContext context, List<ResolutionModel> resolutionList) {
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
                (index) => Container(
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
              decoration: InputDecoration(
                hintText: "제목을 입력해주세요",
                border: InputBorder.none,
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            TextFormField(
              controller: viewModel.contentTextEditingController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "오늘의 실천에 대해 한마디!",
                border: InputBorder.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class photoSelectWidget extends StatelessWidget {
  const photoSelectWidget({
    super.key,
    required this.viewModel,
    required this.viewModelProvider,
  });

  final LateWritingViewModel viewModel;
  final LateWritingViewModelProvider viewModelProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Visibility(
            visible: viewModel.imageFileUrl != null,
            replacement: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) {
                  viewModelProvider.getPhotoLibraryImage();
                },
                child: const Center(
                  child: Text('사진 추가하기'),
                )),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
    );
  }
}
