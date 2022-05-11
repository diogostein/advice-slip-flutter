// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advice_slip_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AdviceSlipStore on _AdviceSlipBaseStore, Store {
  late final _$stateAtom =
      Atom(name: '_AdviceSlipBaseStore.state', context: context);

  @override
  UiState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UiState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$getRandomAdviceSlipAsyncAction =
      AsyncAction('_AdviceSlipBaseStore.getRandomAdviceSlip', context: context);

  @override
  Future getRandomAdviceSlip() {
    return _$getRandomAdviceSlipAsyncAction
        .run(() => super.getRandomAdviceSlip());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
