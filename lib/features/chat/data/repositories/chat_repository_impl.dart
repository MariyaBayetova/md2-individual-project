import '../../domain/entities/chat_conversation_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource dataSource;

  ChatRepositoryImpl({required this.dataSource});

  @override
  Stream<List<ChatMessageEntity>> getMessages(String conversationId) =>
      dataSource.getMessages(conversationId);

  @override
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  }) =>
      dataSource.sendMessage(
        conversationId: conversationId,
        senderId: senderId,
        text: text,
      );

  @override
  Stream<List<ChatConversationEntity>> getConversations(String userId) =>
      dataSource.getConversations(userId);

  @override
  Future<String> getOrCreateConversation({
    required String userId,
    required String doctorId,
    required String doctorName,
    required String doctorAvatarUrl,
    required String doctorSpecialty,
  }) =>
      dataSource.getOrCreateConversation(
        userId: userId,
        doctorId: doctorId,
        doctorName: doctorName,
        doctorAvatarUrl: doctorAvatarUrl,
        doctorSpecialty: doctorSpecialty,
      );
}
