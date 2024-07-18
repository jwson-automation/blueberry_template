import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/RankingModel.freezed.dart';
part 'generated/RankingModel.g.dart';

@freezed
class RankingModel with _$RankingModel {
  const factory RankingModel({
    required int userId,
    required int rank,
    required int score,
    required DateTime updatedAt,
  }) = _RankingModel;

  factory RankingModel.fromJson(Map<String, dynamic> json) => _$RankingModelFromJson(json);
}
