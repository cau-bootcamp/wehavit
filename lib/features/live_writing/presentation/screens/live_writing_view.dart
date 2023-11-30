import 'package:flutter/material.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/live_writing_widget/friend_live_bubble_widget.dart';

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
        minimum: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
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
            Align(
              alignment: const Alignment(1, 1),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    color: Colors.grey.shade800,
                    width: constraints.maxWidth,
                    height: constraints.maxWidth * 0.84,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text("제목"),
                            ),
                            Divider(
                              color: Colors.amber,
                              thickness: 2.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  maxLines: 5,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                )),
                                SizedBox(
                                  width: 8,
                                ),
                                Visibility(
                                    child: Container(
                                  width: 151,
                                  height: 104,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202306/25/488f9638-800c-4bac-ad65-82877fbff79b.jpg')),
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                ElevatedButton(
                                    onPressed: () {}, child: Text("휴식")),
                                SizedBox(
                                  width: 12,
                                ),
                                ElevatedButton(
                                    onPressed: () {}, child: Text("완료")),
                              ],
                            )
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
    );
  }
}
