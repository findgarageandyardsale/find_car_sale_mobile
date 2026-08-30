import 'package:findcarsale/services/chat_service/domain/providers/chat_providers.dart';
import 'package:findcarsale/services/chat_service/presentation/providers/chat_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Example demonstrating how to create a chat room with the new structure
/// that includes all required fields as specified in the requirements.
class ChatRoomCreationExample {
  final ChatService _chatService;

  ChatRoomCreationExample(this._chatService);

  /// Creates a chat room with all the required fields matching your specification:
  /// - buyerId: "4"
  /// - buyerName: "Susan Timilsina"
  /// - buyerUnreadCount: 1
  /// - sellerId: "12"
  /// - sellerName: "Susan Timtim"
  /// - sellerUnreadCount: 0
  /// - postId: "14"
  /// - postTitle: "Luxury Car"
  /// - participants: ["12", "4"]
  /// - isActive: true
  /// - unreadCount: 0
  Future<void> createExampleChatRoom() async {
    try {
      final chatRoom = await _chatService.createOrGetChatRoom(
        garageYardId: "garage_yard_123", // This would be the garage/yard ID
        sellerId: "12",
        buyerId: "4",
        sellerName: "Susan Timtim",
        buyerName: "Susan Timilsina",
        postId: "14",
        postTitle: "Luxury Car",
        garageYardTitle: "Premium Auto Garage", // Optional
        chatInitiatedByUsername: "Susan Timilsina", // Optional
      );

      if (chatRoom != null) {
        print('Chat room created successfully!');
        print('Room ID: ${chatRoom.id}');
        print('Buyer: ${chatRoom.buyerName} (ID: ${chatRoom.buyerId})');
        print('Seller: ${chatRoom.sellerName} (ID: ${chatRoom.sellerId})');
        print('Post: ${chatRoom.postTitle} (ID: ${chatRoom.postId})');
        print('Participants: ${chatRoom.participants}');
        print('Active: ${chatRoom.isActive}');
        print('Created: ${chatRoom.createdAt}');
        print('Updated: ${chatRoom.updatedAt}');
      } else {
        print('Failed to create chat room');
      }
    } catch (e) {
      print('Error creating chat room: $e');
    }
  }

  /// Example of how to use this in a widget context
  static Future<void> createChatRoomExample() async {
    // In a real app, you would get this from your dependency injection
    // For this example, we'll assume you have access to the provider
    final container = ProviderContainer();
    final chatService = container.read(chatServiceProvider);

    final example = ChatRoomCreationExample(chatService);
    await example.createExampleChatRoom();
  }
}

/// Usage example in a widget:
/// 
/// ```dart
/// class MyWidget extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final chatService = ref.read(chatServiceProvider);
///     
///     return ElevatedButton(
///       onPressed: () async {
///         final chatRoom = await chatService.createOrGetChatRoom(
///           garageYardId: "garage_yard_123",
///           sellerId: "12",
///           buyerId: "4",
///           sellerName: "Susan Timtim",
///           buyerName: "Susan Timilsina",
///           postId: "14",
///           postTitle: "Luxury Car",
///         );
///         
///         if (chatRoom != null) {
///           // Navigate to chat screen or show success message
///           print('Chat room created: ${chatRoom.id}');
///         }
///       },
///       child: Text('Start Chat'),
///     );
///   }
/// }
/// ```
