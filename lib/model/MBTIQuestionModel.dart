import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/MBTIQuestionModel.freezed.dart';
part 'generated/MBTIQuestionModel.g.dart';

@freezed
class MBTIQuestionModel with _$MBTIQuestionModel {
  const factory MBTIQuestionModel({
    required String question,
    required String type,
    required String imageUrl,
  }) = _MBTIQuestionModel;

  factory MBTIQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$MBTIQuestionModelFromJson(json);
}
