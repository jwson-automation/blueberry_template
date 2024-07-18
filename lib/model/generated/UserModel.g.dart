// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      age: (json['age'] as num).toInt(),
      profileImageUrl: json['profileImageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
      'profileImageUrl': instance.profileImageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
