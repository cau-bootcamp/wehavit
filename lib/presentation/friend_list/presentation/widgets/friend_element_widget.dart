import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/friend_entity/friend_model.dart';

class FriendElementWidget extends StatefulWidget {
  const FriendElementWidget({super.key, required this.model});

  final FriendModel model;

  @override
  State<FriendElementWidget> createState() => _FriendElementWidgetState();
}

class _FriendElementWidgetState extends State<FriendElementWidget> {
  late String friendName = widget.model.friendName ?? 'no_name';
  late String friendImageUrl = widget.model.friendImageUrl ?? 'no_imageurl';
  int activeIndex = Random().nextInt(3) + 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 4.0, right: 16.0),
                child: CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(friendImageUrl),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friendName,
                    style: const TextStyle(
                      color: CustomColors.whWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ActiveCircle(activeIndex > 0),
              ActiveCircle(activeIndex > 1),
              ActiveCircle(activeIndex > 2),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container ActiveCircle(bool isActive) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? CustomColors.whYellow : CustomColors.whYellowDark,
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.0,
            offset: Offset(0, 2),
          )
        ],
      ),
    );
  }
}
