import '../utils/custom_types.dart';

abstract class UseCase<Type, Params> {
  EitherFuture<Type> call(Params params);
}
