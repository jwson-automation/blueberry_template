import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/PaymentModel.freezed.dart';
part 'generated/PaymentModel.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    required int paymentId,
    required int userId,
    required double amount,
    required String paymentMethod,
    required DateTime createdAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);
}
