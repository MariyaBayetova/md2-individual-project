import '../entities/chat_conversation_entity.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatRepository {
  Stream<List<ChatMessageEntity>> getMessages(String conversationId);
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  });
  Stream<List<ChatConversationEntity>> getConversations(String userId);
  Future<String> getOrCreateConversation({
    required String userId,
    required String doctorId,
    required String doctorName,
    required String doctorAvatarUrl,
    required String doctorSpecialty,
  });
}
