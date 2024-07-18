import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/PostModel.freezed.dart';
part 'generated/PostModel.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required int postId,
    required int userId,
    required String content,
    String? imageUrl,
    required DateTime createdAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
}
