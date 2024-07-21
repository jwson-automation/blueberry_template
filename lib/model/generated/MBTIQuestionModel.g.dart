// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../MBTIQuestionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MBTIQuestionModelImpl _$$MBTIQuestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MBTIQuestionModelImpl(
      question: json['question'] as String,
      type: json['type'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$MBTIQuestionModelImplToJson(
        _$MBTIQuestionModelImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
    };
