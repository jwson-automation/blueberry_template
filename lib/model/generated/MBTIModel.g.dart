// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../MBTIModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MBTIModelImpl _$$MBTIModelImplFromJson(Map<String, dynamic> json) =>
    _$MBTIModelImpl(
      extroversion: $enumDecode(_$ExtroversionEnumMap, json['extroversion']),
      sensing: $enumDecode(_$SensingEnumMap, json['sensing']),
      thinking: $enumDecode(_$ThinkingEnumMap, json['thinking']),
      judging: $enumDecode(_$JudgingEnumMap, json['judging']),
    );

Map<String, dynamic> _$$MBTIModelImplToJson(_$MBTIModelImpl instance) =>
    <String, dynamic>{
      'extroversion': _$ExtroversionEnumMap[instance.extroversion]!,
      'sensing': _$SensingEnumMap[instance.sensing]!,
      'thinking': _$ThinkingEnumMap[instance.thinking]!,
      'judging': _$JudgingEnumMap[instance.judging]!,
    };

const _$ExtroversionEnumMap = {
  Extroversion.E: 'E',
  Extroversion.I: 'I',
};

const _$SensingEnumMap = {
  Sensing.S: 'S',
  Sensing.N: 'N',
};

const _$ThinkingEnumMap = {
  Thinking.T: 'T',
  Thinking.F: 'F',
};

const _$JudgingEnumMap = {
  Judging.J: 'J',
  Judging.P: 'P',
};
