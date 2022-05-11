import 'dart:convert';

import 'package:advice_slip/core/exceptions.dart';
import 'package:advice_slip/core/http_client/http_client.dart';
import 'package:advice_slip/modules/advice/domain/advice_slip_data_source.dart';
import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';

class AdviceSlipRemoteDataSourceImpl extends AdviceSlipDataSource {
  final HttpClient client;

  AdviceSlipRemoteDataSourceImpl(this.client);

  @override
  Future<AdviceSlipEntity> getRandomAdviceSlip() async {
    final response = await client.get('https://api.adviceslip.com/advice');

    if (response.statusCode == 200) {
      return AdviceSlipEntity.fromJson(jsonDecode(response.data)['slip']);
    } else {
      throw ServerException();
    }
  }
}
