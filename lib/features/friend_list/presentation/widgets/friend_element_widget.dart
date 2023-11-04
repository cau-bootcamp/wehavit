import 'package:flutter/material.dart';
import 'package:wehavit/features/friend_list/domain/models/friend_model.dart';

class FriendElementWidget extends StatefulWidget {
  const FriendElementWidget({Key? key, required this.model})
      : super(key: key);

  final FriendModel model;

  @override
  State<FriendElementWidget> createState() =>
      _FriendElementWidgetState();
}

class _FriendElementWidgetState extends State<FriendElementWidget> {
  late String friendName = widget.model.friendName;
  late String friendImageUrl = widget.model.friendImageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(friendImageUrl),
      ),
      title: Text(friendName),
    );
  }
}
