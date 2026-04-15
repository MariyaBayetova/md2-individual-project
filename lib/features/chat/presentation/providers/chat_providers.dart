import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/chat_conversation_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_repository.dart';

// ── Conversations list (real-time stream) ─────────────────────────────────────
final conversationsStreamProvider =
    StreamProvider<List<ChatConversationEntity>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return const Stream.empty();
  return sl<ChatRepository>().getConversations(user.uid);
});

// ── Messages for a specific conversation (real-time stream) ───────────────────
final messagesStreamProvider =
    StreamProvider.family<List<ChatMessageEntity>, String>(
        (ref, conversationId) {
  return sl<ChatRepository>().getMessages(conversationId);
});

// ── Open / create a conversation and return its ID ────────────────────────────
final conversationIdProvider =
    FutureProvider.family<String, Map<String, String>>((ref, params) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception('Not logged in');
  return sl<ChatRepository>().getOrCreateConversation(
    userId: user.uid,
    doctorId: params['doctorId']!,
    doctorName: params['doctorName']!,
    doctorAvatarUrl: params['doctorAvatarUrl']!,
    doctorSpecialty: params['doctorSpecialty']!,
  );
});

// ── Send message notifier ─────────────────────────────────────────────────────
class SendMessageNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> send({
    required String conversationId,
    required String text,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => sl<ChatRepository>().sendMessage(
        conversationId: conversationId,
        senderId: user.uid,
        text: text,
      ),
    );
  }
}

final sendMessageProvider =
    AsyncNotifierProvider<SendMessageNotifier, void>(SendMessageNotifier.new);
