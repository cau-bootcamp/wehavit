import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/live_writing_widget/friend_live_bubble_widget.dart';

class LiveWritingView extends StatefulWidget {
  const LiveWritingView({super.key});

  @override
  State<LiveWritingView> createState() => _LiveWritingViewState();
}

class _LiveWritingViewState extends State<LiveWritingView> {
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.black,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     icon: Icon(Icons.abc),
      //   ),
      //   elevation: 0,
      // ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: Container(
          child: Stack(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
              LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 34, bottom: 34),
                      width: double.infinity,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "남은 시간",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "00:07",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    SingleChildScrollView(
                      padding:
                          EdgeInsets.only(bottom: constraints.maxWidth * 0.84),
                      child: Column(
                        children: List<Widget>.generate(
                          4,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: FriendLivePostWidget(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              Align(
                alignment: const Alignment(1, 1),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      color: Colors.grey.shade800,
                      width: constraints.maxWidth,
                      height: constraints.maxWidth * 0.90,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 32,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text("Name"),
                                  ),
                                  Expanded(child: Container()),
                                  Text("도전 목표"),
                                ],
                              ),
                              TextFormField(
                                maxLines: 1,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "제목",
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                              Divider(
                                color: Colors.amber,
                                thickness: 2.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                    maxLines: 6,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '본문',
                                      hintStyle: TextStyle(color: Colors.white),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: 151,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 14.0,
                                            bottom: 8.0,
                                          ),
                                          child: Container(
                                            width: 151,
                                            height: 104,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            )),
                                            child: Visibility(
                                              visible: imageFile != null,
                                              child: Image(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                  File(imageFile?.path ?? ""),
                                                ),
                                              ),
                                              replacement: GestureDetector(
                                                onTapUp: (details) async {
                                                  final pickedFile =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                  if (pickedFile != null) {
                                                    setState(() {
                                                      imageFile = pickedFile;
                                                    });
                                                  } else {
                                                    debugPrint('이미지 선택안함');
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                        "Tap To Add Image"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text("휴식")),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text("완료")),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
