import 'package:advice_slip/core/exceptions.dart';
import 'package:advice_slip/core/failures.dart';
import 'package:advice_slip/modules/advice/domain/advice_slip_data_source.dart';
import 'package:advice_slip/modules/advice/domain/advice_slip_repository.dart';
import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';
import 'package:dartz/dartz.dart';

class AdviceSlipRepositoryImpl implements AdviceSlipRepository {
  final AdviceSlipDataSource remoteDataSource;

  AdviceSlipRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AdviceSlipEntity>> getRandomAdviceSlip() async {
    try {
      final response = await remoteDataSource.getRandomAdviceSlip();

      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
