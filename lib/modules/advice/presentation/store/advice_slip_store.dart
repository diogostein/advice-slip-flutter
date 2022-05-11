import 'package:advice_slip/core/ui_state.dart';
import 'package:advice_slip/core/use_case.dart';
import 'package:advice_slip/modules/advice/domain/usecases/get_random_advice_slip.dart';
import 'package:mobx/mobx.dart';

part 'advice_slip_store.g.dart';

class AdviceSlipStore = _AdviceSlipBaseStore with _$AdviceSlipStore;

abstract class _AdviceSlipBaseStore with Store {
  final GetRandomAdviceSlip _getRandomAdviceSlipUseCase;

  _AdviceSlipBaseStore(this._getRandomAdviceSlipUseCase);

  @observable
  UiState state = Initial();

  @action
  getRandomAdviceSlip() async {
    state = Loading();

    final result = await _getRandomAdviceSlipUseCase(NoParams());

    result.fold(
      (failure) => state = Error(failure),
      (result) => state = Success(result),
    );
  }
}
