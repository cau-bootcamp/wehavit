import '../utils/custom_types.dart';

abstract class FutureUseCase<Type, Params> {
  EitherFuture<Type> call(Params params);
}
