class AddFriendModel {
  AddFriendModel({
    this.friendID = '',
  });

  String friendID;

  AddFriendModel copyWith({
    String? friendID,
  }) {
    return AddFriendModel(
      friendID: friendID ?? this.friendID,
    );
  }
}
