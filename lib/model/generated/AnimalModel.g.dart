// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../AnimalModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnimalModelImpl _$$AnimalModelImplFromJson(Map<String, dynamic> json) =>
    _$AnimalModelImpl(
      animalId: (json['animalId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      species: json['species'] as String?,
      breed: json['breed'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      profilePicture: json['profilePicture'] as String?,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$$AnimalModelImplToJson(_$AnimalModelImpl instance) =>
    <String, dynamic>{
      'animalId': instance.animalId,
      'userId': instance.userId,
      'name': instance.name,
      'species': instance.species,
      'breed': instance.breed,
      'age': instance.age,
      'gender': instance.gender,
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
    };
