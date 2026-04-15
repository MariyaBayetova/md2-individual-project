import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import 'call_screen.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/chat_providers.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final String conversationId;
  final String doctorName;
  final String doctorAvatarUrl;
  final String doctorSpecialty;

  const ChatRoomScreen({
    super.key,
    required this.conversationId,
    required this.doctorName,
    required this.doctorAvatarUrl,
    required this.doctorSpecialty,
  });

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    ref.read(sendMessageProvider.notifier).send(
          conversationId: widget.conversationId,
          text: text,
        );
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesStreamProvider(widget.conversationId));
    final currentUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Auto-scroll on new messages
    ref.listen(messagesStreamProvider(widget.conversationId), (_, next) {
      next.whenData((_) => Future.delayed(
            const Duration(milliseconds: 100),
            _scrollToBottom,
          ));
    });

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryContainer,
              backgroundImage: widget.doctorAvatarUrl.isNotEmpty
                  ? CachedNetworkImageProvider(widget.doctorAvatarUrl)
                  : null,
              child: widget.doctorAvatarUrl.isEmpty
                  ? const Icon(Icons.person, size: 18, color: AppColors.primary)
                  : null,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. ${widget.doctorName}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.doctorSpecialty,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppColors.neutral400),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CallScreen(
                  doctorName: widget.doctorName,
                  doctorAvatarUrl: widget.doctorAvatarUrl,
                  doctorSpecialty: widget.doctorSpecialty,
                  isVideo: true,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CallScreen(
                  doctorName: widget.doctorName,
                  doctorAvatarUrl: widget.doctorAvatarUrl,
                  doctorSpecialty: widget.doctorSpecialty,
                  isVideo: false,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Consultation start banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: AppColors.primaryContainer,
            child: Column(
              children: [
                Text(
                  'Consultation Start',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'You can consult your problem to the doctor',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.neutral600),
                ),
              ],
            ),
          ),

          // Messages list
          Expanded(
            child: messages.when(
              loading: () => const ShimmerList(count: 4, itemHeight: 60),
              error: (e, _) =>
                  ErrorView(message: 'Could not load messages.\n$e'),
              data: (list) => ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final msg = list[index];
                  final isMe = msg.senderId == currentUid;
                  return _MessageBubble(
                    text: msg.text,
                    isMe: isMe,
                    timestamp: msg.timestamp,
                    isRead: msg.isRead,
                  );
                },
              ),
            ),
          ),

          // Input bar
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(color: AppColors.neutral200),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _send(),
                    decoration: InputDecoration(
                      hintText: 'Type message ...',
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.attach_file_outlined,
                            color: AppColors.neutral400),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final bool isRead;

  const _MessageBubble({
    required this.text,
    required this.isMe,
    required this.timestamp,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
          border: isMe
              ? null
              : Border.all(color: AppColors.neutral200),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isMe ? Colors.white : null,
                    height: 1.4,
                  ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('HH:mm').format(timestamp),
                  style: TextStyle(
                    fontSize: 10,
                    color: isMe
                        ? Colors.white.withOpacity(0.7)
                        : AppColors.neutral400,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    isRead ? Icons.done_all : Icons.done,
                    size: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
