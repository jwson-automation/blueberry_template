// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../MBTIQuestionModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MBTIQuestionModel _$MBTIQuestionModelFromJson(Map<String, dynamic> json) {
  return _MBTIQuestionModel.fromJson(json);
}

/// @nodoc
mixin _$MBTIQuestionModel {
  String get question => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MBTIQuestionModelCopyWith<MBTIQuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MBTIQuestionModelCopyWith<$Res> {
  factory $MBTIQuestionModelCopyWith(
          MBTIQuestionModel value, $Res Function(MBTIQuestionModel) then) =
      _$MBTIQuestionModelCopyWithImpl<$Res, MBTIQuestionModel>;
  @useResult
  $Res call({String question, String type, String imageUrl});
}

/// @nodoc
class _$MBTIQuestionModelCopyWithImpl<$Res, $Val extends MBTIQuestionModel>
    implements $MBTIQuestionModelCopyWith<$Res> {
  _$MBTIQuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? type = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MBTIQuestionModelImplCopyWith<$Res>
    implements $MBTIQuestionModelCopyWith<$Res> {
  factory _$$MBTIQuestionModelImplCopyWith(_$MBTIQuestionModelImpl value,
          $Res Function(_$MBTIQuestionModelImpl) then) =
      __$$MBTIQuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, String type, String imageUrl});
}

/// @nodoc
class __$$MBTIQuestionModelImplCopyWithImpl<$Res>
    extends _$MBTIQuestionModelCopyWithImpl<$Res, _$MBTIQuestionModelImpl>
    implements _$$MBTIQuestionModelImplCopyWith<$Res> {
  __$$MBTIQuestionModelImplCopyWithImpl(_$MBTIQuestionModelImpl _value,
      $Res Function(_$MBTIQuestionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? type = null,
    Object? imageUrl = null,
  }) {
    return _then(_$MBTIQuestionModelImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MBTIQuestionModelImpl implements _MBTIQuestionModel {
  const _$MBTIQuestionModelImpl(
      {required this.question, required this.type, required this.imageUrl});

  factory _$MBTIQuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MBTIQuestionModelImplFromJson(json);

  @override
  final String question;
  @override
  final String type;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'MBTIQuestionModel(question: $question, type: $type, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MBTIQuestionModelImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, question, type, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MBTIQuestionModelImplCopyWith<_$MBTIQuestionModelImpl> get copyWith =>
      __$$MBTIQuestionModelImplCopyWithImpl<_$MBTIQuestionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MBTIQuestionModelImplToJson(
      this,
    );
  }
}

abstract class _MBTIQuestionModel implements MBTIQuestionModel {
  const factory _MBTIQuestionModel(
      {required final String question,
      required final String type,
      required final String imageUrl}) = _$MBTIQuestionModelImpl;

  factory _MBTIQuestionModel.fromJson(Map<String, dynamic> json) =
      _$MBTIQuestionModelImpl.fromJson;

  @override
  String get question;
  @override
  String get type;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$MBTIQuestionModelImplCopyWith<_$MBTIQuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
