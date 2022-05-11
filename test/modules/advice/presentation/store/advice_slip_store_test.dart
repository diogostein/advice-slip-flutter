import 'package:advice_slip/core/failures.dart';
import 'package:advice_slip/core/ui_state.dart';
import 'package:advice_slip/core/use_case.dart';
import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';
import 'package:advice_slip/modules/advice/domain/usecases/get_random_advice_slip.dart';
import 'package:advice_slip/modules/advice/presentation/store/advice_slip_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart';

class MockGetRandomAdviceSlip extends Mock implements GetRandomAdviceSlip {}

abstract class Callable<T> {
  void call([T? arg]) {}
}

class MockCallable<T> extends Mock implements Callable<T> {}

void main() {
  late GetRandomAdviceSlip mockGetRandomAdviceSlip;
  late AdviceSlipStore subject;

  final expectedEntity =
      AdviceSlipEntity(id: 1, advice: 'Value the people in your life.');
  final expectedUiStateSuccess = Success(expectedEntity);
  final expectedFailure = ServerFailure();
  final expectedUiStateError = Error(expectedFailure);

  setUp(() {
    mockGetRandomAdviceSlip = MockGetRandomAdviceSlip();
    subject = AdviceSlipStore(mockGetRandomAdviceSlip);

    registerFallbackValue(NoParams());
  });

  MockCallable<UiState> _mockCallable() {
    final stateChanged = MockCallable<UiState>();

    mobx.reaction<UiState>(
        (_) => subject.state, (value) => stateChanged(value));

    return stateChanged;
  }

  test(
    'it should return a advice slip entity from use case',
    () async {
      // given
      when(() => mockGetRandomAdviceSlip(any()))
          .thenAnswer((_) async => Right(expectedEntity));

      // when
      await subject.getRandomAdviceSlip();

      // then
      verify(() => mockGetRandomAdviceSlip(any())).called(1);
    },
  );

  test(
    'it should return a success state with advice slip entity data encapsulated',
    () async {
      // given
      when(() => mockGetRandomAdviceSlip(any()))
          .thenAnswer((_) async => Right(expectedEntity));

      final stateChanged = _mockCallable();

      // when
      await subject.getRandomAdviceSlip();

      // then
      verifyInOrder([
        () => stateChanged(Loading()),
        () => stateChanged(expectedUiStateSuccess),
      ]);
    },
  );

  test(
    'it should return a error state with a message string encapsulated',
    () async {
      // given
      when(() => mockGetRandomAdviceSlip(any()))
          .thenAnswer((_) async => Left(expectedFailure));

      final stateChanged = _mockCallable();

      // when
      await subject.getRandomAdviceSlip();

      // then
      verifyInOrder([
        () => stateChanged(Loading()),
        () => stateChanged(expectedUiStateError),
      ]);
    },
  );
}
