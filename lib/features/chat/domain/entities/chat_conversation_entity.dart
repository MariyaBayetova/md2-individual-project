import 'package:equatable/equatable.dart';

class ChatConversationEntity extends Equatable {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorAvatarUrl;
  final String doctorSpecialty;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool hasUnread;

  const ChatConversationEntity({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorAvatarUrl,
    required this.doctorSpecialty,
    required this.lastMessage,
    required this.lastMessageTime,
    this.hasUnread = false,
  });

  @override
  List<Object?> get props => [id];
}
