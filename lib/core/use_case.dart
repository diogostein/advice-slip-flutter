import 'package:dartz/dartz.dart';

import 'failures.dart';

abstract class UseCase<Input, Output> {
  Future<Either<Failure, Output>> call(Input input);
}

class NoParams {}
