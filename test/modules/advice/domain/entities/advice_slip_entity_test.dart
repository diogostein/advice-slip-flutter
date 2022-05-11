import 'dart:convert';

import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/advice_slip_entity_mock.dart';

void main() {
  final expectedAdviceSlipEntity =
      AdviceSlipEntity(id: 1, advice: 'Value the people in your life.');

  test(
    'it should return a valid advice slip entity mapped from json response',
    () {
      // given
      final resultJson = json.decode(adviceSlipJson);

      // when
      final actual = AdviceSlipEntity.fromJson(resultJson['slip']);

      // then
      expect(actual, expectedAdviceSlipEntity);
    },
  );
}
