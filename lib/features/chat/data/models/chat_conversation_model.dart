import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/chat_conversation_entity.dart';

class ChatConversationModel extends ChatConversationEntity {
  const ChatConversationModel({
    required super.id,
    required super.doctorId,
    required super.doctorName,
    required super.doctorAvatarUrl,
    required super.doctorSpecialty,
    required super.lastMessage,
    required super.lastMessageTime,
    super.hasUnread,
  });

  factory ChatConversationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatConversationModel(
      id: doc.id,
      doctorId: data['doctorId'] as String? ?? '',
      doctorName: data['doctorName'] as String? ?? '',
      doctorAvatarUrl: data['doctorAvatarUrl'] as String? ?? '',
      doctorSpecialty: data['doctorSpecialty'] as String? ?? '',
      lastMessage: data['lastMessage'] as String? ?? '',
      lastMessageTime:
          (data['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      hasUnread: data['hasUnread'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'doctorId': doctorId,
        'doctorName': doctorName,
        'doctorAvatarUrl': doctorAvatarUrl,
        'doctorSpecialty': doctorSpecialty,
        'lastMessage': lastMessage,
        'lastMessageTime': Timestamp.fromDate(lastMessageTime),
        'hasUnread': hasUnread,
      };
}
