// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../PostModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  int get postId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {int postId,
      int userId,
      String content,
      String? imageUrl,
      DateTime createdAt});
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userId = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostModelImplCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$$PostModelImplCopyWith(
          _$PostModelImpl value, $Res Function(_$PostModelImpl) then) =
      __$$PostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int postId,
      int userId,
      String content,
      String? imageUrl,
      DateTime createdAt});
}

/// @nodoc
class __$$PostModelImplCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$PostModelImpl>
    implements _$$PostModelImplCopyWith<$Res> {
  __$$PostModelImplCopyWithImpl(
      _$PostModelImpl _value, $Res Function(_$PostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userId = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$PostModelImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostModelImpl implements _PostModel {
  const _$PostModelImpl(
      {required this.postId,
      required this.userId,
      required this.content,
      this.imageUrl,
      required this.createdAt});

  factory _$PostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostModelImplFromJson(json);

  @override
  final int postId;
  @override
  final int userId;
  @override
  final String content;
  @override
  final String? imageUrl;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PostModel(postId: $postId, userId: $userId, content: $content, imageUrl: $imageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostModelImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, postId, userId, content, imageUrl, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      __$$PostModelImplCopyWithImpl<_$PostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostModelImplToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  const factory _PostModel(
      {required final int postId,
      required final int userId,
      required final String content,
      final String? imageUrl,
      required final DateTime createdAt}) = _$PostModelImpl;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$PostModelImpl.fromJson;

  @override
  int get postId;
  @override
  int get userId;
  @override
  String get content;
  @override
  String? get imageUrl;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
