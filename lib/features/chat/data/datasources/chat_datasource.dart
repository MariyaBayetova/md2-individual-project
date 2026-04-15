import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_conversation_model.dart';
import '../models/chat_message_model.dart';

abstract class ChatDataSource {
  Stream<List<ChatMessageModel>> getMessages(String conversationId);
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  });
  Stream<List<ChatConversationModel>> getConversations(String userId);
  Future<String> getOrCreateConversation({
    required String userId,
    required String doctorId,
    required String doctorName,
    required String doctorAvatarUrl,
    required String doctorSpecialty,
  });
}

class ChatDataSourceImpl implements ChatDataSource {
  final FirebaseFirestore firestore;

  ChatDataSourceImpl({required this.firestore});

  // conversations/{userId}/chats/{conversationId}
  CollectionReference _chats(String userId) =>
      firestore.collection('conversations').doc(userId).collection('chats');

  // messages/{conversationId}/messages/{messageId}
  CollectionReference _messages(String conversationId) =>
      firestore.collection('messages').doc(conversationId).collection('msgs');

  @override
  Stream<List<ChatMessageModel>> getMessages(String conversationId) {
    return _messages(conversationId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => ChatMessageModel.fromFirestore(d)).toList());
  }

  @override
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  }) async {
    final msg = ChatMessageModel(
      id: '',
      senderId: senderId,
      text: text,
      timestamp: DateTime.now(),
    );
    await _messages(conversationId).add(msg.toFirestore());

    // Update last message in both user and doctor conversation docs
    final parts = conversationId.split('_');
    if (parts.length >= 2) {
      final update = {
        'lastMessage': text,
        'lastMessageTime': Timestamp.fromDate(DateTime.now()),
        'hasUnread': true,
      };
      await _chats(parts[0]).doc(conversationId).update(update);
    }
  }

  @override
  Stream<List<ChatConversationModel>> getConversations(String userId) {
    return _chats(userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => ChatConversationModel.fromFirestore(d))
            .toList());
  }

  @override
  Future<String> getOrCreateConversation({
    required String userId,
    required String doctorId,
    required String doctorName,
    required String doctorAvatarUrl,
    required String doctorSpecialty,
  }) async {
    final conversationId = '${userId}_$doctorId';
    final doc = await _chats(userId).doc(conversationId).get();

    if (!doc.exists) {
      final conversation = ChatConversationModel(
        id: conversationId,
        doctorId: doctorId,
        doctorName: doctorName,
        doctorAvatarUrl: doctorAvatarUrl,
        doctorSpecialty: doctorSpecialty,
        lastMessage: 'Consultation Start',
        lastMessageTime: DateTime.now(),
        hasUnread: false,
      );
      await _chats(userId).doc(conversationId).set(conversation.toFirestore());
    }

    return conversationId;
  }
}
