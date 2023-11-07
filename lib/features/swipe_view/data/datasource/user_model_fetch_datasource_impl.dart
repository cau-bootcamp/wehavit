import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/swipe_view/data/datasource/user_model_fetch_datasource.dart';

class UserModelFetchDatasourceImpl extends UserModelFetchDatasource {
  @override
  EitherFuture<UserModel> fetchUserModelFromId(String targetUserId) {
    return Future(() => right(UserModel(
        displayName: "이름",
        email: "moktak072",
        imageUrl: "https://i.stack.imgur.com/8DntB.jpg?s=64&g=1")));
  }
}
