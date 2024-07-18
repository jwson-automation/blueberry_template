// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../PaymentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(Map<String, dynamic> json) =>
    _$PaymentModelImpl(
      paymentId: (json['paymentId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PaymentModelImplToJson(_$PaymentModelImpl instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'userId': instance.userId,
      'amount': instance.amount,
      'paymentMethod': instance.paymentMethod,
      'createdAt': instance.createdAt.toIso8601String(),
    };
