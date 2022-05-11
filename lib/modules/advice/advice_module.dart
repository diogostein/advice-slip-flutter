import 'package:advice_slip/modules/advice/data/advice_slip_remote_data_source_impl.dart';
import 'package:advice_slip/modules/advice/data/advice_slip_repository_impl.dart';
import 'package:advice_slip/modules/advice/presentation/store/advice_slip_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_random_advice_slip.dart';
import 'presentation/advice_slip_screen.dart';

class AdviceModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => AdviceSlipRemoteDataSourceImpl(i())),
        Bind.factory((i) => AdviceSlipRepositoryImpl(i())),
        Bind.factory((i) => GetRandomAdviceSlip(i())),
        Bind.factory((i) => AdviceSlipStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => AdviceSlipScreen()),
      ];
}
