import 'package:flutter/material.dart';

class LiveWritingView extends StatelessWidget {
  const LiveWritingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: FriendLiveBubbleWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendLiveBubbleWidget extends StatefulWidget {
  const FriendLiveBubbleWidget({super.key});

  @override
  State<FriendLiveBubbleWidget> createState() => _FriendLiveBubbleWidgetState();
}

class _FriendLiveBubbleWidgetState extends State<FriendLiveBubbleWidget> {
  LiveWritingState writingState = LiveWritingState.ready;
  LiveBubbleState bubbleState = LiveBubbleState.showingDefault;

  final double profileImageRadius = 23;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Visibility(
        visible: writingState != LiveWritingState.writing,
        replacement: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 35,
                  foregroundImage: NetworkImage(
                    'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
                  ),
                ),
              ),
              Positioned(
                left: 46,
                bottom: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xaa8C8C8C),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  width: 77,
                  height: 35,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (_) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            width: 8,
                            height: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: profileImageRadius,
                foregroundImage: NetworkImage(
                  'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 47,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    print(constraints.maxWidth);
                    return Container(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Container(
                                      constraints:
                                          BoxConstraints(minWidth: 120),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              "도전 목표",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0, 2))
                                        ]),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image(
                                      width: 50,
                                      height: 37,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    // print(constraints.maxWidth);
                    // if (constraints.maxWidth > 200) {
                    //   return Container(
                    //     decoration: BoxDecoration(color: Colors.black26),
                    //     child: Text('BIGfjdkalf;jdksla;fjdkfdfdsjasaj'),
                    //   );
                    // } else {
                    //   return Text('SMALL');
                    // }
                  },
                ),
              ),
            ),
            // Expanded(
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Expanded(
            //         child: Text(
            //           "fdjsalffdsa;fdsafdsafdafdsa",
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.all(5.0),
            //         child: Image(
            //           width: 50,
            //           height: 37,
            //           fit: BoxFit.fill,
            //           image: NetworkImage(
            //             'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Container(
            //   constraints: BoxConstraints.expand(),
            //   height: 47,
            // ),

            // child: Row(
            //   children: [
            //     Container(
            //       constraints: BoxConstraints(
            //         minHeight: 47,
            //       ),
            //       child: Container(
            //         color: Colors.black45,
            //         child: Row(
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.all(8.0),
            //               child: Container(
            //                 height: 47,
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Container(
            //                       child: Text(
            //                         "이름",
            //                       ),
            //                     ),
            //                     Text(
            //                       // maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                       "도전 목fdsfsadfdfdfffffdfdsafdsafdsasafafdsafdaafa표",
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(5.0),
            //               child: Image(
            //                 width: 50,
            //                 height: 37,
            //                 fit: BoxFit.fill,
            //                 image: NetworkImage(
            //                   'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

enum LiveWritingState { ready, writing, done }

enum LiveBubbleState {
  showingDefault,
  showingDetail,
}
