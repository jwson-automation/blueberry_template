// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../MBTIModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MBTIModel _$MBTIModelFromJson(Map<String, dynamic> json) {
  return _MBTIModel.fromJson(json);
}

/// @nodoc
mixin _$MBTIModel {
  Extroversion get extroversion => throw _privateConstructorUsedError;
  Sensing get sensing => throw _privateConstructorUsedError;
  Thinking get thinking => throw _privateConstructorUsedError;
  Judging get judging => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MBTIModelCopyWith<MBTIModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MBTIModelCopyWith<$Res> {
  factory $MBTIModelCopyWith(MBTIModel value, $Res Function(MBTIModel) then) =
      _$MBTIModelCopyWithImpl<$Res, MBTIModel>;
  @useResult
  $Res call(
      {Extroversion extroversion,
      Sensing sensing,
      Thinking thinking,
      Judging judging});
}

/// @nodoc
class _$MBTIModelCopyWithImpl<$Res, $Val extends MBTIModel>
    implements $MBTIModelCopyWith<$Res> {
  _$MBTIModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extroversion = null,
    Object? sensing = null,
    Object? thinking = null,
    Object? judging = null,
  }) {
    return _then(_value.copyWith(
      extroversion: null == extroversion
          ? _value.extroversion
          : extroversion // ignore: cast_nullable_to_non_nullable
              as Extroversion,
      sensing: null == sensing
          ? _value.sensing
          : sensing // ignore: cast_nullable_to_non_nullable
              as Sensing,
      thinking: null == thinking
          ? _value.thinking
          : thinking // ignore: cast_nullable_to_non_nullable
              as Thinking,
      judging: null == judging
          ? _value.judging
          : judging // ignore: cast_nullable_to_non_nullable
              as Judging,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MBTIModelImplCopyWith<$Res>
    implements $MBTIModelCopyWith<$Res> {
  factory _$$MBTIModelImplCopyWith(
          _$MBTIModelImpl value, $Res Function(_$MBTIModelImpl) then) =
      __$$MBTIModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Extroversion extroversion,
      Sensing sensing,
      Thinking thinking,
      Judging judging});
}

/// @nodoc
class __$$MBTIModelImplCopyWithImpl<$Res>
    extends _$MBTIModelCopyWithImpl<$Res, _$MBTIModelImpl>
    implements _$$MBTIModelImplCopyWith<$Res> {
  __$$MBTIModelImplCopyWithImpl(
      _$MBTIModelImpl _value, $Res Function(_$MBTIModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extroversion = null,
    Object? sensing = null,
    Object? thinking = null,
    Object? judging = null,
  }) {
    return _then(_$MBTIModelImpl(
      extroversion: null == extroversion
          ? _value.extroversion
          : extroversion // ignore: cast_nullable_to_non_nullable
              as Extroversion,
      sensing: null == sensing
          ? _value.sensing
          : sensing // ignore: cast_nullable_to_non_nullable
              as Sensing,
      thinking: null == thinking
          ? _value.thinking
          : thinking // ignore: cast_nullable_to_non_nullable
              as Thinking,
      judging: null == judging
          ? _value.judging
          : judging // ignore: cast_nullable_to_non_nullable
              as Judging,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MBTIModelImpl implements _MBTIModel {
  const _$MBTIModelImpl(
      {required this.extroversion,
      required this.sensing,
      required this.thinking,
      required this.judging});

  factory _$MBTIModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MBTIModelImplFromJson(json);

  @override
  final Extroversion extroversion;
  @override
  final Sensing sensing;
  @override
  final Thinking thinking;
  @override
  final Judging judging;

  @override
  String toString() {
    return 'MBTIModel(extroversion: $extroversion, sensing: $sensing, thinking: $thinking, judging: $judging)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MBTIModelImpl &&
            (identical(other.extroversion, extroversion) ||
                other.extroversion == extroversion) &&
            (identical(other.sensing, sensing) || other.sensing == sensing) &&
            (identical(other.thinking, thinking) ||
                other.thinking == thinking) &&
            (identical(other.judging, judging) || other.judging == judging));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, extroversion, sensing, thinking, judging);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MBTIModelImplCopyWith<_$MBTIModelImpl> get copyWith =>
      __$$MBTIModelImplCopyWithImpl<_$MBTIModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MBTIModelImplToJson(
      this,
    );
  }

  @override
  MBTIType getMBTI() {
    // TODO: implement getMBTI
    throw UnimplementedError();
  }
}

abstract class _MBTIModel implements MBTIModel {
  const factory _MBTIModel(
      {required final Extroversion extroversion,
      required final Sensing sensing,
      required final Thinking thinking,
      required final Judging judging}) = _$MBTIModelImpl;

  factory _MBTIModel.fromJson(Map<String, dynamic> json) =
      _$MBTIModelImpl.fromJson;

  @override
  Extroversion get extroversion;
  @override
  Sensing get sensing;
  @override
  Thinking get thinking;
  @override
  Judging get judging;
  @override
  @JsonKey(ignore: true)
  _$$MBTIModelImplCopyWith<_$MBTIModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
