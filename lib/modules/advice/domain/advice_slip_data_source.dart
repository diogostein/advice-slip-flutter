import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';

abstract class AdviceSlipDataSource {
  Future<AdviceSlipEntity> getRandomAdviceSlip();
}
