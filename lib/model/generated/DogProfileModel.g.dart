// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../DogProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DogProfileModelImpl _$$DogProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DogProfileModelImpl(
      name: json['name'] as String,
      gender: json['gender'] as String,
      breed: json['breed'] as String,
      bio: json['bio'] as String,
      imageUrl: json['imageUrl'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$$DogProfileModelImplToJson(
        _$DogProfileModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'breed': instance.breed,
      'bio': instance.bio,
      'imageUrl': instance.imageUrl,
      'location': instance.location,
    };
