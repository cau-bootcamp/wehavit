import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';

typedef EitherFuture<T> = Future<Either<Failure, T>>;
