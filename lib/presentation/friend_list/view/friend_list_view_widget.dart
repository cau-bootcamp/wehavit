import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class FriendListFailPlaceholderWidget extends StatelessWidget {
  const FriendListFailPlaceholderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '친구들에 대한 정보를\n불러오지 못했어요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.whWhite,
            ),
          ),
          Text(
            '😭',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: CustomColors.whWhite,
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class FriendListPlaceholderWidget extends StatelessWidget {
  const FriendListPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          '친구들과 함께 도전하고 격려를 나눠보세요!\n우측 상단에서 친구 신청을 보낼 수 있어요',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: CustomColors.whWhite,
          ),
        ),
        Text(
          '😊 😊',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: CustomColors.whWhite,
          ),
        ),
      ],
    );
  }
}
