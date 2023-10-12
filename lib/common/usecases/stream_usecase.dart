import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}
