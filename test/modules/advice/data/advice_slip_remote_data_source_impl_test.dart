import 'package:advice_slip/core/exceptions.dart';
import 'package:advice_slip/core/http_client/http_client.dart';
import 'package:advice_slip/modules/advice/data/advice_slip_remote_data_source_impl.dart';
import 'package:advice_slip/modules/advice/domain/advice_slip_data_source.dart';
import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/advice_slip_entity_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  final HttpClient client = HttpClientMock();
  final AdviceSlipDataSource subject = AdviceSlipRemoteDataSourceImpl(client);
  final expectedResult =
      AdviceSlipEntity(id: 1, advice: 'Value the people in your life.');

  void successMock() {
    when(() => client.get(any())).thenAnswer(
      (_) async => HttpResponse(
        data: adviceSlipJson,
        statusCode: 200,
      ),
    );
  }

  test(
    'it should call the client get method',
    () async {
      // given
      successMock();

      // when
      await subject.getRandomAdviceSlip();

      // then
      verify(() => client.get(any())).called(1);
    },
  );

  test(
    'it should return the correct advice slip entity given a successful network call',
    () async {
      // given
      successMock();

      // when
      final result = await subject.getRandomAdviceSlip();

      // then
      expect(result, expectedResult);
    },
  );

  test(
    'it should throw a server exception given a unsuccessful network call',
    () {
      // given
      when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(
          data: null,
          statusCode: 500,
        ),
      );

      // when
      final result = subject.getRandomAdviceSlip();

      // then
      expect(() => result, throwsA(ServerException()));
    },
  );
}
