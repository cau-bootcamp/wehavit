class AddFriendModel {
  AddFriendModel({
    this.friendEmail = '',
  });

  String friendEmail;

  AddFriendModel copyWith({
    required String friendEmail,
  }) {
    return AddFriendModel(
      friendEmail: friendEmail,
    );
  }
}
