import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
