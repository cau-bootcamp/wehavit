import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';

class GroupMemberListCellWidget extends StatelessWidget {
  const GroupMemberListCellWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.whGrey,
          ),
          width: 60,
          height: 60,
          child: Image.network(
            fit: BoxFit.cover,
            'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
          ),
          clipBehavior: Clip.hardEdge,
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '박성민',
                style: TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              Text(
                '6개의 목표 공유중',
                style: TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        ),
        Text(
          '67%',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class GroupMemberApplyListCellWidget extends StatelessWidget {
  const GroupMemberApplyListCellWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.whGrey,
          ),
          width: 60,
          height: 60,
          child: Image.network(
            fit: BoxFit.cover,
            'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
          ),
          clipBehavior: Clip.hardEdge,
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '박성민',
                style: TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0.0),
              ),
              onPressed: () {
                print('거절');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: CustomColors.whBrightGrey,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  '거절',
                  style: TextStyle(
                    color: CustomColors.whDarkBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.0),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0.0),
              ),
              onPressed: () {
                print('수락');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: CustomColors.whYellow,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  '수락',
                  style: TextStyle(
                    color: CustomColors.whDarkBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class GroupMemberManageListCellWidget extends StatelessWidget {
  const GroupMemberManageListCellWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.whGrey,
          ),
          width: 60,
          height: 60,
          child: Image.network(
            fit: BoxFit.cover,
            'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
          ),
          clipBehavior: Clip.hardEdge,
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '박성민',
                style: TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              Text(
                '6개의 목표 공유중',
                style: TextStyle(
                  color: CustomColors.whWhite,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0.0),
              ),
              onPressed: () {
                print('내보내기');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: CustomColors.whBrightGrey,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  '내보내기',
                  style: TextStyle(
                    color: CustomColors.whDarkBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
