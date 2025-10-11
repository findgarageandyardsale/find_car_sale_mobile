import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/services/chat_service/domain/providers/chat_providers.dart';
import 'package:findcarsale/services/chat_service/domain/providers/garage_yard_provider.dart';
import 'package:findcarsale/services/firebase_initialization_provider.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/domain/models/chat/chat_models.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/domain/models/user/user_model.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_loading.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: currentUserAsync.when(
        data: (User? user) {
          if (user == null) {
            return const Center(child: Text('Please log in to view messages'));
          }

          return _buildChatList(context, ref, user.userId.toString());
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading:
            () =>
                const CustomLoadingOverlay(isLoading: true, child: SizedBox()),
      ),
    );
  }

  Widget _buildChatList(BuildContext context, WidgetRef ref, String userId) {
    final firebaseReady = ref.watch(firebaseReadyProvider);
    final chatRoomsAsync = ref.watch(userChatRoomsProvider(userId));

    if (!firebaseReady) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Initializing Chat Screen...'),
          ],
        ),
      );
    }

    return chatRoomsAsync.when(
      data: (List<ChatRoom> chatRooms) {
        if (chatRooms.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: AppColors.lightGrey,
                ),
                Spacing.sizedBoxH_16(),
                Text(
                  'No messages yet',
                  style: TextStyle(fontSize: 18, color: AppColors.lightGrey),
                ),
                const SizedBox(height: 12),
                Text(
                  'Start a conversation about a car sale',
                  style: TextStyle(color: AppColors.lightGrey),
                ),
              ],
            ),
          );
        }

        // Separate chat rooms into seller and buyer sections
        final sellerChatRooms =
            chatRooms.where((room) => room.sellerId == userId).toList();
        final buyerChatRooms =
            chatRooms.where((room) => room.buyerId == userId).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seller Section
              if (sellerChatRooms.isNotEmpty) ...[
                _buildSectionHeader('As Seller', sellerChatRooms.length),
                Spacing.sizedBoxH_12(),
                ...sellerChatRooms.map(
                  (chatRoom) => ChatRoomTile(
                    chatRoom: chatRoom,
                    currentUserId: userId,
                    isSellerView: true,
                    onTap: () {
                      context.router.push(ChatScreen(chatRoom: chatRoom));
                    },
                  ),
                ),
                Spacing.sizedBoxH_24(),
              ],

              // Buyer Section
              if (buyerChatRooms.isNotEmpty) ...[
                _buildSectionHeader('As Buyer', buyerChatRooms.length),
                Spacing.sizedBoxH_12(),
                ...buyerChatRooms.map(
                  (chatRoom) => ChatRoomTile(
                    chatRoom: chatRoom,
                    currentUserId: userId,
                    isSellerView: false,
                    onTap: () {
                      context.router.push(ChatScreen(chatRoom: chatRoom));
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
      error:
          (error, stackTrace) =>
              Center(child: Text('Error loading chats: $error')),
      loading:
          () => const CustomLoadingOverlay(isLoading: true, child: SizedBox()),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Spacing.sizedBoxW_08(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class ChatRoomTile extends ConsumerWidget {
  final ChatRoom chatRoom;
  final String currentUserId;
  final bool isSellerView;
  final VoidCallback onTap;

  const ChatRoomTile({
    super.key,
    required this.chatRoom,
    required this.currentUserId,
    required this.isSellerView,
    required this.onTap,
  });

  String _getUserDisplayName(ChatUser? user) {
    if (user == null) return 'Anonymous User';
    return user.name;
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'USER';

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
    // Get the other user's ID and name based on the view
    final otherUserId = isSellerView ? chatRoom.buyerId : chatRoom.sellerId;
    final otherUserName =
        isSellerView ? chatRoom.buyerName : chatRoom.sellerName;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryContainer,
          child: Text(
            _getInitials(otherUserName),
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        title: _buildChatRoomTitle(),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (chatRoom.lastMessage != null) ...[
              Text(
                chatRoom.lastMessage!.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color:
                      chatRoom.unreadCount > 0
                          ? AppColors.black
                          : AppColors.lightGrey,
                ),
              ),
              Spacing.sizedBoxH_08(),
            ],
            Text(
              _formatDateTime(chatRoom.updatedAt),
              style: const TextStyle(fontSize: 12, color: AppColors.lightGrey),
            ),
          ],
        ),
        trailing:
            chatRoom.unreadCount > 0
                ? Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chatRoom.unreadCount.toString(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : null,
      ),
    );
  }

  Widget _buildChatRoomTitle() {
    // Get the post title from chat room
    final postTitle = chatRoom.postTitle;

    if (isSellerView) {
      // For seller: show "Post Title (Buyer Name)"
      return Text(
        '$postTitle (${chatRoom.buyerName})',
        style: const TextStyle(fontWeight: FontWeight.w600),
      );
    } else {
      // For buyer: show "Post Title"
      return Text(
        postTitle,
        style: const TextStyle(fontWeight: FontWeight.w600),
      );
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('MMM dd').format(dateTime);
    }
  }
}
