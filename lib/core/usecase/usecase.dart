import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class UseCase<Type,Params> {
  
  Future<Type> call({Params params});
}

// تعريف UseCase لتأخذ إما Failure أو Data
abstract class UseCase2<Type, Params> {
  Future<Either<Failure, Type>> call({Params? params});
}


abstract class UseCase3<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
