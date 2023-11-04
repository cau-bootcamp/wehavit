import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/features/swipe_view/data/enitty/DEBUG_confirm_post_model.dart';

class SwipeViewCellWidget extends StatelessWidget {
  SwipeViewCellWidget({super.key, required this.model});

  ConfirmPostModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            // 프로필 영역
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  foregroundImage: NetworkImage(
                    "https://image.yes24.com/momo/TopCate55/MidCate10/5490248.jpg",
                  ),
                ),
                Text(
                  "NAME",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // 사진 영역
            // padding: const EdgeInsets.symmetric(vertical: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://t4.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2WQk/image/9bTOhsLJcfWTFwZBoTDmu1E83i8.jpg",
                    ),
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
                constraints: BoxConstraints.expand(height: 120),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("인증글 제목"),
                      ),
                      Divider(
                        thickness: 2.5,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "인증글 본문은 이렇게 작성이 길게 될 수도 있습니다. 인증글 본문은 이렇게 작성이 길게 될 수도 있습니다. 인증글 본문은 이렇게 작성이 길게 될 수도 있습니다.",
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
