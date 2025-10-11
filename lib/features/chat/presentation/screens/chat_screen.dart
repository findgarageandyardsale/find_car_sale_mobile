import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/chat_service/domain/providers/chat_providers.dart';
import 'package:findcarsale/services/chat_service/presentation/providers/chat_state_provider.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/services/chat_service/domain/providers/garage_yard_provider.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/domain/models/chat/chat_models.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/domain/models/user/user_model.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_loading.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ChatScreen extends ConsumerStatefulWidget {
  final ChatRoom chatRoom;

  const ChatScreen({super.key, required this.chatRoom});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _markMessagesAsRead();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _markMessagesAsRead() async {
    final currentUser = ref.read(currentUserProvider).value;
    if (currentUser != null) {
      final chatService = ref.read(chatServiceProvider);
      await chatService.markMessagesAsRead(
        widget.chatRoom.id!,
        currentUser.userId.toString(),
      );
    }
  }

  Future<void> _sendMessage() async {
    try {
      if (_messageController.text.trim().isEmpty) return;

      final currentUser = ref.read(currentUserProvider).value;
      if (currentUser == null) {
        CustomToast.showToast(
          'Please log in to send messages',
          status: ToastStatus.error,
        );
        return;
      }

      final otherUserId = widget.chatRoom.participants.firstWhere(
        (id) => id != currentUser.userId.toString(),
      );

      final chatService = ref.read(chatServiceProvider);
      final success = await chatService.sendMessage(
        chatRoomId: widget.chatRoom.id!,
        senderId: currentUser.userId.toString(),
        receiverId: otherUserId,
        garageYardId: widget.chatRoom.garageYardId,
        text: _messageController.text.trim(),
      );

      if (success) {
        _messageController.clear();
        _scrollToBottom();
      } else {
        CustomToast.showToast(
          'Failed to send message',
          status: ToastStatus.error,
        );
      }
    } catch (e) {
      CustomToast.showToast(
        'Error sending message: $e',
        status: ToastStatus.error,
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildChatTitle(
    String? currentUserId,
    AsyncValue<ChatUser?> otherUserAsync,
    AsyncValue<Garageayard?> garageYardAsync,
  ) {
    // Get the post title from chat room or garage yard data
    final postTitle =
        widget.chatRoom.garageYardTitle ??
        garageYardAsync.value?.title ??
        'Post';

    // Check if current user is the seller by comparing with garage yard owner
    final isCurrentUserSeller =
        garageYardAsync.value?.userId.toString() == currentUserId;

    return otherUserAsync.when(
      data: (otherUser) {
        if (!isCurrentUserSeller) {
          return Text(postTitle);
        }

        if (isCurrentUserSeller) {
          // For seller: show "Post Title (Chat Initiated Username)"
          // Use the chatInitiatedByUsername (the person who started the chat)
          final username = widget.chatRoom.chatInitiatedByUsername ?? '';
          return Text('$postTitle ($username)');
        } else {
          // For buyer: show "Post Title"
          return Text(postTitle);
        }
      },
      error: (_, __) => Text(postTitle),
      loading: () => Text(postTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final otherUserId = widget.chatRoom.participants.firstWhere(
      (id) => id != currentUserAsync.value?.userId.toString(),
    );
    final otherUserAsync = ref.watch(chatUserProvider(otherUserId));
    final messagesAsync = ref.watch(chatMessagesProvider(widget.chatRoom.id!));
    final garageYardAsync = ref.watch(
      garageYardProvider(widget.chatRoom.garageYardId),
    );

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: _buildChatTitle(
            currentUserAsync.value?.userId.toString(),
            otherUserAsync,
            garageYardAsync,
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                // Show chat info dialog
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: messagesAsync.when(
                data: (List<ChatMessage> messages) {
                  if (messages.isEmpty) {
                    return const Center(
                      child: Text(
                        'No messages yet\nStart the conversation!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: false,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe =
                          message.senderId ==
                          currentUserAsync.value?.userId.toString();

                      return MessageBubble(message: message, isMe: isMe);
                    },
                  );
                },
                error:
                    (error, stackTrace) =>
                        Center(child: Text('Error loading messages: $error')),
                loading:
                    () => const CustomLoadingOverlay(
                      isLoading: true,
                      child: SizedBox(),
                    ),
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.lightGrey, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppColors.lightGrey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          Spacing.sizedBoxW_12(),
          FloatingActionButton(
            mini: true,
            onPressed: _sendMessage,
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.send, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends ConsumerWidget {
  final ChatMessage message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  String _getUserDisplayName(ChatUser? user) {
    if (user == null) return 'User';
    return user.name;
  }

  String _getCurrentUserDisplayName(User? user) {
    if (user == null) return 'User';

    if (user.firstName != null && user.lastName != null) {
      return '${user.firstName} ${user.lastName}';
    } else if (user.firstName != null) {
      return user.firstName!;
    } else if (user.username != null) {
      return user.username!;
    } else {
      return 'User';
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';

    final words = name.trim().split(' ');
    if (words.length >= 2) {
      // First letter of first word + first letter of last word
      return '${words.first[0]}${words.last[0]}'.toUpperCase();
    } else {
      // Just first two letters of the single word
      return name.length >= 2
          ? name.substring(0, 2).toUpperCase()
          : name.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the other user's info for avatar
    final otherUserId = isMe ? message.receiverId : message.senderId;
    final otherUserAsync = ref.watch(chatUserProvider(otherUserId));

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryContainer,
              child: otherUserAsync.when(
                data:
                    (user) => Text(
                      _getInitials(_getUserDisplayName(user)),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                error:
                    (_, __) => Text(
                      _getInitials('U'),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                loading:
                    () => const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
              ),
            ),
            Spacing.sizedBoxW_12(),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomLeft:
                      isMe
                          ? const Radius.circular(20)
                          : const Radius.circular(4),
                  bottomRight:
                      isMe
                          ? const Radius.circular(4)
                          : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isMe ? AppColors.white : AppColors.black,
                      fontSize: 16,
                    ),
                  ),
                  Spacing.sizedBoxH_08(),
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: TextStyle(
                      color:
                          isMe
                              ? AppColors.white.withOpacity(0.7)
                              : AppColors.lightGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            Spacing.sizedBoxW_12(),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: Consumer(
                builder: (context, ref, child) {
                  final currentUserAsync = ref.watch(currentUserProvider);
                  return currentUserAsync.when(
                    data:
                        (user) => Text(
                          _getInitials(_getCurrentUserDisplayName(user)),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    error:
                        (_, __) => const Icon(
                          Icons.person,
                          color: AppColors.white,
                          size: 16,
                        ),
                    loading:
                        () => const Icon(
                          Icons.person,
                          color: AppColors.white,
                          size: 16,
                        ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
