import 'package:cloud_firestore/cloud_firestore.dart'; // 추가

/**
 * Firestore Chat Collection DTO
 * - Firestore Chat Collection에 저장할 데이터를 담는 DTO 클래스
 * - chatId: 채팅 ID
 * - senderId: 보낸 사람 ID
 * - message: 메시지
 * - timestamp: 타임스탬프
 * - toMap(): DTO를 Map으로 변환
 * - fromMap(): Map을 DTO로 변환
 * - Firestore Timestamp 대신 DateTime 사용
 * - Firestore Timestamp과 DateTime 간 변환
 *
 * @jwson-automation
 */

class ChatDTO {
  final String chatId;
  final String senderId;
  final String message;
  final DateTime timestamp; // Firestore Timestamp 대신 DateTime 사용

  ChatDTO({
    required this.chatId,
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp), // Firestore Timestamp로 변환
    };
  }

  factory ChatDTO.fromMap(Map<String, dynamic> map, String chatId) {
    return ChatDTO(
      chatId: chatId,
      senderId: map['senderId'],
      message: map['message'],
      timestamp: (map['timestamp'] as Timestamp)
          .toDate(), // Firestore Timestamp에서 DateTime으로 변환
    );
  }
}
