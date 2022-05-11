import 'package:flutter_modular/flutter_modular.dart';

import 'core/http_client/http_client_impl.dart';
import 'modules/advice/advice_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => HttpClientImpl()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: AdviceModule()),
      ];
}
