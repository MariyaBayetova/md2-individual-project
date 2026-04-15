import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/chat_providers.dart';

class MessageHistoryScreen extends ConsumerWidget {
  const MessageHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(conversationsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: conversations.when(
        loading: () => const ShimmerList(count: 6, itemHeight: 80),
        error: (e, _) => ErrorView(message: 'Could not load messages.\n$e'),
        data: (list) => list.isEmpty
            ? const EmptyView(
                message:
                    'No conversations yet.\nStart a chat from a doctor\'s profile.',
                icon: Icons.chat_bubble_outline,
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: list.length,
                separatorBuilder: (_, __) => const Divider(
                  indent: 80,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final conv = list[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.primaryContainer,
                      backgroundImage: conv.doctorAvatarUrl.isNotEmpty
                          ? CachedNetworkImageProvider(conv.doctorAvatarUrl)
                          : null,
                      child: conv.doctorAvatarUrl.isEmpty
                          ? const Icon(Icons.person, color: AppColors.primary)
                          : null,
                    ),
                    title: Text(
                      'Dr. ${conv.doctorName}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: conv.hasUnread
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                    ),
                    subtitle: Text(
                      conv.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: conv.hasUnread
                                ? AppColors.primary
                                : AppColors.neutral400,
                          ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatTime(conv.lastMessageTime),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppColors.neutral400),
                        ),
                        if (conv.hasUnread) ...[
                          const SizedBox(height: 4),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    onTap: () => context.push(
                      Routes.chatRoom,
                      extra: {
                        'conversationId': conv.id,
                        'doctorName': conv.doctorName,
                        'doctorAvatarUrl': conv.doctorAvatarUrl,
                        'doctorSpecialty': conv.doctorSpecialty,
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.doctors),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.chat_outlined, color: Colors.white),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    if (now.difference(dt).inDays == 0) {
      return DateFormat('HH:mm').format(dt);
    } else if (now.difference(dt).inDays == 1) {
      return 'Yesterday';
    }
    return DateFormat('dd/MM').format(dt);
  }
}
