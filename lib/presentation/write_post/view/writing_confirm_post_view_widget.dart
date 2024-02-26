import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/write_post/write_post.dart';

class ShareTargetGroupCellWidget extends StatelessWidget {
  const ShareTargetGroupCellWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            '공유 대상',
            style: TextStyle(
              color: CustomColors.whWhite,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          )),
          SizedBox(
            height: 24,
          ),
          Text(
            '그룹',
            style: TextStyle(
              color: CustomColors.whWhite,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          ShareTargetGroupListCellWidget(),
          SizedBox(height: 16.0),
          ShareTargetGroupListCellWidget(),
          SizedBox(height: 16.0),
          ShareTargetGroupListCellWidget(),
        ],
      ),
    );
  }
}

class ShareTargetGroupListCellWidget extends StatelessWidget {
  const ShareTargetGroupListCellWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '갱생프로젝트',
          style: TextStyle(
            color: PointColors.pink,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              '멤버 수',
              style: TextStyle(
                color: CustomColors.whWhite,
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '17',
              style: TextStyle(
                color: CustomColors.whWhite,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ],
        ),
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              '함께 도전중인 목표 수',
              style: TextStyle(
                color: CustomColors.whWhite,
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '63',
              style: TextStyle(
                color: CustomColors.whWhite,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PhotoThumbnailWidget extends StatelessWidget {
  const PhotoThumbnailWidget({
    super.key,
    required this.viewModel,
    required this.index,
    required this.onRemove,
  });

  final WritingConfirmPostViewModel viewModel;
  final int index;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Image.file(
              File(viewModel.imageMediaList[index].path),
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.cancel,
                size: 20,
                color: CustomColors.whWhite,
              ),
            ),
            onTapUp: (details) {
              onRemove();
            },
          ),
        ],
      ),
    );
  }
}
