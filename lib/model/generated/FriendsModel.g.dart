// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../FriendsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendsModelImpl _$$FriendsModelImplFromJson(Map<String, dynamic> json) =>
    _$FriendsModelImpl(
      userId: (json['userId'] as num).toInt(),
      friendId: (json['friendId'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FriendsModelImplToJson(_$FriendsModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'friendId': instance.friendId,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
