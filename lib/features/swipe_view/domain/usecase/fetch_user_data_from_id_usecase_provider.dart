import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/swipe_view/domain/repository/user_model_fetch_repository_provider.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase.dart';

final fetchUserDataFromIdUsecaseProvider =
    Provider<FetchUserDataFromIdUsecase>((ref) {
  final _repository = ref.watch(userModelFetchRepositoryProvider);
  return FetchUserDataFromIdUsecase(_repository);
});
