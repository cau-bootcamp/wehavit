import 'package:flutter/material.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';

class FriendElementWidget extends StatefulWidget {
  const FriendElementWidget({super.key, required this.model});

  final FriendModel model;

  @override
  State<FriendElementWidget> createState() => _FriendElementWidgetState();
}

class _FriendElementWidgetState extends State<FriendElementWidget> {
  late String friendName = widget.model.friendName;
  late String friendImageUrl = widget.model.friendImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 4.0, right: 10.0),
            child: CircleAvatar(
              radius: 30,
              foregroundImage: NetworkImage(friendImageUrl),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(friendName),
            ],
          ),
        ],
      ),
    );
  }
}
