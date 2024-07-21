// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../ChatModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      chatId: (json['chatId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      friendId: (json['friendId'] as num).toInt(),
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'userId': instance.userId,
      'friendId': instance.friendId,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };
