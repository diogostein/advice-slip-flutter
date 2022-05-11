import 'package:equatable/equatable.dart';

import 'failures.dart';

abstract class UiState {}

class Initial extends UiState {}

class Loading extends Equatable implements UiState {
  @override
  List<Object?> get props => [];
}

class Error extends Equatable implements UiState {
  final Failure failure;

  Error(this.failure);

  String get message {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message ?? 'Server Failure';
      default:
        return '';
    }
  }

  @override
  List<Object?> get props => [failure, message];
}

class Success<T> extends Equatable implements UiState {
  final T? data;

  Success(this.data);

  @override
  List<Object?> get props => [data];
}
