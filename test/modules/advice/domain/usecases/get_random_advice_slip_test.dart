import 'package:advice_slip/core/failures.dart';
import 'package:advice_slip/core/use_case.dart';
import 'package:advice_slip/modules/advice/domain/advice_slip_repository.dart';
import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';
import 'package:advice_slip/modules/advice/domain/usecases/get_random_advice_slip.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceSlipRepository extends Mock implements AdviceSlipRepository {}

void main() {
  late AdviceSlipRepository repository;
  late GetRandomAdviceSlip subject;
  late AdviceSlipEntity expectedAdviceSlipEntity;
  late Failure expectedFailure;

  final noParams = NoParams();

  setUp(() {
    repository = MockAdviceSlipRepository();
    subject = GetRandomAdviceSlip(repository);

    expectedAdviceSlipEntity = AdviceSlipEntity(
        id: 0, advice: 'The sun always shines above the clouds.');
    expectedFailure = ServerFailure();
  });

  test(
    'it should get a random advice slip from repository',
    () {
      // given
      when(() => repository.getRandomAdviceSlip())
          .thenAnswer((_) async => Right(expectedAdviceSlipEntity));

      // when
      subject(noParams);

      // then
      verify(() => repository.getRandomAdviceSlip()).called(1);
    },
  );

  test(
    'it should get the correct random advice slip from repository',
    () async {
      // given
      when(() => repository.getRandomAdviceSlip())
          .thenAnswer((_) async => Right(expectedAdviceSlipEntity));

      // when
      final result = await subject(noParams);

      // then
      expect(result, Right(expectedAdviceSlipEntity));
    },
  );

  test(
    'it should return a failure from repository when do not succeed',
    () async {
      // given
      when(() => repository.getRandomAdviceSlip())
          .thenAnswer((_) async => Left(expectedFailure));

      // when
      final result = await subject(noParams);

      // then
      expect(result, Left(expectedFailure));
    },
  );
}
