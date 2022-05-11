import 'package:advice_slip/core/failures.dart';
import 'package:dartz/dartz.dart';

import 'entities/advice_slip_entity.dart';

abstract class AdviceSlipRepository {
  Future<Either<Failure, AdviceSlipEntity>> getRandomAdviceSlip();
}
