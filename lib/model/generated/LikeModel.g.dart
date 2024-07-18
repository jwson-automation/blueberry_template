// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../LikeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikeModelImpl _$$LikeModelImplFromJson(Map<String, dynamic> json) =>
    _$LikeModelImpl(
      likeId: (json['likeId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      postId: (json['postId'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LikeModelImplToJson(_$LikeModelImpl instance) =>
    <String, dynamic>{
      'likeId': instance.likeId,
      'userId': instance.userId,
      'postId': instance.postId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
