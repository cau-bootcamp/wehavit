import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class GroupMemberListBottomSheet extends StatelessWidget {
  const GroupMemberListBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradientBottomSheet(
      Container(
        height: MediaQuery.sizeOf(context).height * 0.80,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    '멤버 목록',
                    style: TextStyle(
                      color: CustomColors.whWhite,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.manage_accounts_outlined,
                      color: CustomColors.whWhite,
                      size: 24.0,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTapUp: (_) {},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '가나다 순',
                          style: TextStyle(
                            color: CustomColors.whPlaceholderGrey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: CustomColors.whPlaceholderGrey,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '이번주 목표 달성률',
                  style: TextStyle(
                    color: CustomColors.whPlaceholderGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Column(
                children: List<Widget>.generate(
                  7,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: GroupMemberManageListCellWidget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            GroupMemberListButtonWidget(
              label: '거절',
              color: CustomColors.whBrightGrey,
              onPressed: () {},
            ),
            SizedBox(width: 4.0),
            GroupMemberListButtonWidget(
              label: '수락',
              color: CustomColors.whYellow,
              onPressed: () {},
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
            GroupMemberListButtonWidget(
              label: '내보내기',
              color: CustomColors.whBrightGrey,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class GroupMemberListButtonWidget extends StatelessWidget {
  const GroupMemberListButtonWidget({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0.0),
      ),
      onPressed: onPressed(),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: CustomColors.whDarkBlack,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
