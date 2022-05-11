import 'package:advice_slip/core/failures.dart';
import 'package:advice_slip/core/use_case.dart';
import 'package:advice_slip/modules/advice/domain/advice_slip_repository.dart';
import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';
import 'package:dartz/dartz.dart';

class GetRandomAdviceSlip implements UseCase<NoParams, AdviceSlipEntity> {
  final AdviceSlipRepository repository;

  GetRandomAdviceSlip(this.repository);

  @override
  Future<Either<Failure, AdviceSlipEntity>> call(NoParams input) {
    return repository.getRandomAdviceSlip();
  }
}
