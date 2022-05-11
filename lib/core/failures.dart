import 'package:equatable/equatable.dart';

abstract class Failure {}

class ServerFailure extends Equatable implements Failure {
  final String? message;

  ServerFailure({this.message});

  @override
  List<Object?> get props => [message];
}
