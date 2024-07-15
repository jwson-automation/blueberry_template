// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../FriendsModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FriendsModel _$FriendsModelFromJson(Map<String, dynamic> json) {
  return _FriendsModel.fromJson(json);
}

/// @nodoc
mixin _$FriendsModel {
  int get userId => throw _privateConstructorUsedError;
  int get friendId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FriendsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendsModelCopyWith<FriendsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendsModelCopyWith<$Res> {
  factory $FriendsModelCopyWith(
          FriendsModel value, $Res Function(FriendsModel) then) =
      _$FriendsModelCopyWithImpl<$Res, FriendsModel>;
  @useResult
  $Res call({int userId, int friendId, String status, DateTime createdAt});
}

/// @nodoc
class _$FriendsModelCopyWithImpl<$Res, $Val extends FriendsModel>
    implements $FriendsModelCopyWith<$Res> {
  _$FriendsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? friendId = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      friendId: null == friendId
          ? _value.friendId
          : friendId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendsModelImplCopyWith<$Res>
    implements $FriendsModelCopyWith<$Res> {
  factory _$$FriendsModelImplCopyWith(
          _$FriendsModelImpl value, $Res Function(_$FriendsModelImpl) then) =
      __$$FriendsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, int friendId, String status, DateTime createdAt});
}

/// @nodoc
class __$$FriendsModelImplCopyWithImpl<$Res>
    extends _$FriendsModelCopyWithImpl<$Res, _$FriendsModelImpl>
    implements _$$FriendsModelImplCopyWith<$Res> {
  __$$FriendsModelImplCopyWithImpl(
      _$FriendsModelImpl _value, $Res Function(_$FriendsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? friendId = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_$FriendsModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      friendId: null == friendId
          ? _value.friendId
          : friendId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendsModelImpl implements _FriendsModel {
  const _$FriendsModelImpl(
      {required this.userId,
      required this.friendId,
      required this.status,
      required this.createdAt});

  factory _$FriendsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendsModelImplFromJson(json);

  @override
  final int userId;
  @override
  final int friendId;
  @override
  final String status;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'FriendsModel(userId: $userId, friendId: $friendId, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendsModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.friendId, friendId) ||
                other.friendId == friendId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, friendId, status, createdAt);

  /// Create a copy of FriendsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendsModelImplCopyWith<_$FriendsModelImpl> get copyWith =>
      __$$FriendsModelImplCopyWithImpl<_$FriendsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendsModelImplToJson(
      this,
    );
  }
}

abstract class _FriendsModel implements FriendsModel {
  const factory _FriendsModel(
      {required final int userId,
      required final int friendId,
      required final String status,
      required final DateTime createdAt}) = _$FriendsModelImpl;

  factory _FriendsModel.fromJson(Map<String, dynamic> json) =
      _$FriendsModelImpl.fromJson;

  @override
  int get userId;
  @override
  int get friendId;
  @override
  String get status;
  @override
  DateTime get createdAt;

  /// Create a copy of FriendsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendsModelImplCopyWith<_$FriendsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
