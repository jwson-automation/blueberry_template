// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../RankingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RankingModelImpl _$$RankingModelImplFromJson(Map<String, dynamic> json) =>
    _$RankingModelImpl(
      userId: (json['userId'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      score: (json['score'] as num).toInt(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$RankingModelImplToJson(_$RankingModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'rank': instance.rank,
      'score': instance.score,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
