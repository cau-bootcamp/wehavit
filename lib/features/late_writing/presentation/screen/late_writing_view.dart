import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      appBar: AppBar(
        title: Text("title"),
      ),
      body: SafeArea(
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("작성할 목표"),
                          GestureDetector(
                            onTapUp: (details) async {
                              showResolutionSelectionList(
                                context,
                                resolutionList,
                              );
                            },
                            child: Text(
                              resolutionList[viewModel.resolutionIndex]
                                  .goalStatement,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 제목
                    Container(
                      child: Column(
                        children: [
                          Text("Title"),
                          TextFormField(
                            controller: viewModel.titleTextEditingController,
                          )
                        ],
                      ),
                    ),
                    // 내용
                    Container(
                      child: Column(
                        children: [
                          Text("Content"),
                          TextFormField(
                            controller: viewModel.contentTextEditingController,
                          )
                        ],
                      ),
                    ),
                    // 사진
                    Container(
                      child: Column(children: [
                        Visibility(
                          visible: viewModel.imageFileUrl == null,
                          child: Container(),
                          replacement: Container(),
                        )
                      ]),
                    ),

                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              viewModelProvider.postCurrentConfirmPost();
                            },
                            child: Text("Save"))),
                  ],
                ),
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
