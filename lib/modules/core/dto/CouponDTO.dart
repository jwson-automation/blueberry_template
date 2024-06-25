/**
 * CouponDTO
 * 쿠폰 정보를 담는 DTO 클래스
 *
 * @jwson-automation
 *
 */

class CouponDTO {
  String userId; // 유저의 고유 아이디
  bool isUsed; // 쿠폰 사용 여부
  num discountRate; // 할인율
  num maxDiscountAmount; // 최대 할인 금액
  DateTime dueDate;

  CouponDTO({
    required this.userId,
    this.isUsed = false,
    required this.discountRate,
    required this.maxDiscountAmount,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'isUsed': isUsed,
      'discountRate': discountRate,
      'maxDiscountAmount': maxDiscountAmount,
      'dueDate': dueDate,
    };
  }

  factory CouponDTO.fromMap(Map<String, dynamic> map) {
    return CouponDTO(
      userId: map['userId'],
      isUsed: map['isUsed'],
      discountRate: map['discountRate'],
      maxDiscountAmount: map['maxDiscountAmount'],
      dueDate: map['dueDate'],
    );
  }
}
