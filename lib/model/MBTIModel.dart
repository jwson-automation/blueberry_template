import 'package:freezed_annotation/freezed_annotation.dart';

import '../widgets/mbti/MBTIHomeWidget.dart';

part 'generated/MBTIModel.freezed.dart';
part 'generated/MBTIModel.g.dart';

@freezed
class MBTIModel with _$MBTIModel {
  const factory MBTIModel({
    required Extroversion extroversion,
    required Sensing sensing,
    required Thinking thinking,
    required Judging judging,
  }) = _MBTIModel;

  factory MBTIModel.fromJson(Map<String, dynamic> json) =>
      _$MBTIModelFromJson(json);

  // 2진수 각 자리 index 위치 MBTI 검색
  MBTIType getMBTI() {
    int index = 0;

    if (extroversion == Extroversion.E) index += 8;
    if (sensing == Sensing.S) index += 4;
    if (thinking == Thinking.T) index += 2;
    if (judging == Judging.J) index += 1;

    return MBTIType.values[index];
  }
}
