import 'package:advice_slip/core/exceptions.dart';
import 'package:advice_slip/core/failures.dart';
import 'package:advice_slip/modules/advice/data/advice_slip_repository_impl.dart';
import 'package:advice_slip/modules/advice/domain/advice_slip_data_source.dart';
import 'package:advice_slip/modules/advice/domain/advice_slip_repository.dart';
import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceSlipDataSource extends Mock implements AdviceSlipDataSource {}

void main() {
  late AdviceSlipDataSource remoteDataSource;
  late AdviceSlipRepository subject;

  final expectedAdviceSlipEntity = AdviceSlipEntity(
      id: 0, advice: 'The sun always shines above the clouds.');
  final expectedException = ServerException();
  final expectedFailure = ServerFailure();

  setUp(() {
    remoteDataSource = MockAdviceSlipDataSource();
    subject = AdviceSlipRepositoryImpl(remoteDataSource);
  });

  test(
    'it should get a random advice slip from remote data source',
    () {
      // given
      when(() => remoteDataSource.getRandomAdviceSlip())
          .thenAnswer((_) async => expectedAdviceSlipEntity);

      // when
      subject.getRandomAdviceSlip();

      // then
      verify(() => remoteDataSource.getRandomAdviceSlip()).called(1);
    },
  );

  test(
    'it should get the correct random advice slip from remote data source',
    () async {
      // given
      when(() => remoteDataSource.getRandomAdviceSlip())
          .thenAnswer((_) async => expectedAdviceSlipEntity);

      // when
      final result = await subject.getRandomAdviceSlip();

      // then
      expect(result, Right(expectedAdviceSlipEntity));
    },
  );

  test(
    'it should return a server failure when the remote data source throws a server exception',
    () async {
      // given
      when(() => remoteDataSource.getRandomAdviceSlip())
          .thenThrow(expectedException);

      // when
      final result = await subject.getRandomAdviceSlip();

      // then
      expect(result, Left(expectedFailure));
    },
  );
}
