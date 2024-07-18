import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/ChatModel.freezed.dart';
part 'generated/ChatModel.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    required int chatId,
    required int userId,
    required int friendId,
    required String message,
    required DateTime timestamp,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);
}
