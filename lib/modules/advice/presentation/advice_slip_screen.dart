import 'package:advice_slip/core/ui_state.dart';
import 'package:advice_slip/modules/advice/domain/entities/advice_slip_entity.dart';
import 'package:advice_slip/modules/advice/presentation/store/advice_slip_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AdviceSlipScreen extends StatefulWidget {
  const AdviceSlipScreen({Key? key}) : super(key: key);

  @override
  _AdviceSlipScreenState createState() => _AdviceSlipScreenState();
}

class _AdviceSlipScreenState
    extends ModularState<AdviceSlipScreen, AdviceSlipStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advice Slip'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(
                builder: (context) {
                  if (store.state is Loading) {
                    return CircularProgressIndicator();
                  } else if (store.state is Error) {
                    return _buildText((store.state as Error).message);
                  } else if (store.state is Success) {
                    return _buildText((store.state as Success<AdviceSlipEntity>)
                        .data!
                        .advice);
                  } else {
                    return _buildText('Click below to get a new random advice');
                  }
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => store.getRandomAdviceSlip(),
                child: Text('Generate new random advice slip'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String message) {
    return Text(
      message,
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }
}
