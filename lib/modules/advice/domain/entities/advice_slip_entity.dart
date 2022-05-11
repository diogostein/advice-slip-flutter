import 'package:equatable/equatable.dart';

class AdviceSlipEntity extends Equatable {
  final int id;
  final String advice;

  AdviceSlipEntity({required this.id, required this.advice});

  factory AdviceSlipEntity.fromJson(Map<String, dynamic> json) =>
      AdviceSlipEntity(
        id: json['id'],
        advice: json['advice'],
      );

  @override
  List<Object?> get props => [id, advice];
}
