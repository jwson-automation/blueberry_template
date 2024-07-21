// import 'dart:convert';
//
// import 'package:bootpay/model/extra.dart';
// import 'package:bootpay/model/item.dart';
// import 'package:bootpay/model/payload.dart';
// import 'package:bootpay/bootpay.dart';
// import 'package:bootpay/model/user.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
//
// /**
//  * PaymentService.dart
//  *
//  * Payment Service
//  * - 결제 서비스
//  * - startPayment(): 결제 시작
//  *
//  * @jwson-automation
//  */
//
// // 프로바이더로 만들지 않는 이유 : 결제는 안전을 위해 필요시에만 생성을 하는 것이 좋다.
//
// const String webApplciationId = "여기에 웹용 앱 아이디를 입력해주세요";
//
// class PaymentService {
//   void startPayment(BuildContext context, ItemDTO item) {
//     final Payload payload = getPayload(item);
//
//     if (kIsWeb) {
//       payload.extra?.openType = "iframe";
//     }
//
//     Bootpay().requestPayment(
//       context: context,
//       payload: payload,
//       showCloseButton: false,
//       // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
//       onCancel: (String data) {
//         print('------- onCancel: $data');
//       },
//       onError: (String data) {
//         print('------- onError: $data');
//       },
//       onClose: () {
//         print('------- onClose');
//         //TODO - 원하시는 라우터로 페이지 이동
//       },
//       onIssued: (String data) {
//         print('------- onIssued: $data');
//       },
//       onConfirm: (String data) {
//         print('------- onConfirm: $data');
//         /**
//             1. 바로 승인하고자 할 때
//             return true;
//          **/
//         /***
//             2. 비동기 승인 하고자 할 때
//             checkQtyFromServer(data);
//             return false;
//          ***/
//         /***
//             3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
//             return false; 후에 서버에서 결제승인 수행
//          */
//         // checkQtyFromServer(data);
//         return true;
//       },
//       onDone: (String data) {
//         print('------- onDone: $data');
//       },
//     );
//   }
//
//   Payload getPayload(ItemDTO item) {
//     Payload payload = Payload();
//     payload.webApplicationId = webApplciationId;
//
//     Item item1 = Item();
//     item1.name = item.title;
//     item1.qty = 1; // 해당 상품의 주문 수량
//     item1.id = item.itemId;
//     item1.price = item.discountedPrice.toDouble();
//     payload.orderName = item.itemId;
//     payload.price = item.discountedPrice.toDouble();
//
//     payload.orderId = DateTime.now()
//         .millisecondsSinceEpoch
//         .toString(); //주문번호, 개발사에서 고유값으로 지정해야함
//
//     payload.metadata = {
//       "callbackParam1": "value12",
//       "callbackParam2": "value34",
//       "callbackParam3": "value56",
//       "callbackParam4": "value78",
//     }; // 전달할 파라미터, 결제 후 되돌려 주는 값
//     payload.items = [item1];
//
//     User user = User(); // 구매자 정보
//     user.username = "사용자 이름";
//     user.email = "user1234@gmail.com";
//     user.area = "서울";
//     user.phone = "010-4033-4678";
//     user.addr = '서울시 동작구 상도로 222';
//
//     Extra extra = Extra(); // 결제 옵션
//     extra.appScheme = 'bootpayFlutterExample';
//     extra.cardQuota = '3';
//     // extra.openType = 'popup';
//
//     // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
//     // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능
//
//     payload.user = user;
//     payload.extra = extra;
//     return payload;
//   }
// }
