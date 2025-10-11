import 'package:findcarsale/services/chat_service/domain/providers/chat_providers.dart';
import 'package:findcarsale/services/chat_service/presentation/providers/chat_state_provider.dart';
import 'package:findcarsale/shared/domain/models/chat/chat_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Example demonstrating how to create a message with the new structure
/// that includes all required fields as specified in the requirements.
class MessageCreationExample {
  final ChatService _chatService;

  MessageCreationExample(this._chatService);

  /// Creates a message with all the required fields matching your specification:
  /// - chatRoomId: "BRXSpnKjPklVIvjJpzVa"
  /// - senderId: "4"
  /// - receiverId: "12"
  /// - text: "hello"
  /// - timestamp: October 11, 2025 at 12:49:24 AM UTC+5:45
  /// - type: "text"
  /// - isDelivered: false
  /// - isRead: false
  /// - fileUrl: null
  /// - imageUrl: null
  Future<void> createExampleMessage() async {
    try {
      final success = await _chatService.sendMessage(
        chatRoomId: "BRXSpnKjPklVIvjJpzVa",
        senderId: "4",
        receiverId: "12",
        garageYardId: "garage_yard_123",
        text: "hello",
        messageType: MessageType.text,
        imageUrl: null,
        fileUrl: null,
      );

      if (success) {
        print('Message sent successfully!');
        print('Message structure matches your requirements:');
        print('- chatRoomId: BRXSpnKjPklVIvjJpzVa');
        print('- senderId: 4');
        print('- receiverId: 12');
        print('- text: hello');
        print('- type: text');
        print('- isDelivered: false');
        print('- isRead: false');
        print('- fileUrl: null');
        print('- imageUrl: null');
      } else {
        print('Failed to send message');
      }
    } catch (e) {
      print('Error creating message: $e');
    }
  }

  /// Example of creating a message with image
  Future<void> createImageMessage() async {
    try {
      final success = await _chatService.sendMessage(
        chatRoomId: "BRXSpnKjPklVIvjJpzVa",
        senderId: "4",
        receiverId: "12",
        garageYardId: "garage_yard_123",
        text: "Check out this image!",
        messageType: MessageType.image,
        imageUrl: "https://example.com/image.jpg",
        fileUrl: null,
      );

      if (success) {
        print('Image message sent successfully!');
      } else {
        print('Failed to send image message');
      }
    } catch (e) {
      print('Error creating image message: $e');
    }
  }

  /// Example of creating a message with file
  Future<void> createFileMessage() async {
    try {
      final success = await _chatService.sendMessage(
        chatRoomId: "BRXSpnKjPklVIvjJpzVa",
        senderId: "4",
        receiverId: "12",
        garageYardId: "garage_yard_123",
        text: "Here's the document you requested",
        messageType: MessageType.file,
        imageUrl: null,
        fileUrl: "https://example.com/document.pdf",
      );

      if (success) {
        print('File message sent successfully!');
      } else {
        print('Failed to send file message');
      }
    } catch (e) {
      print('Error creating file message: $e');
    }
  }

  /// Example of how to use this in a widget context
  static Future<void> createMessageExample() async {
    // In a real app, you would get this from your dependency injection
    // For this example, we'll assume you have access to the provider
    final container = ProviderContainer();
    final chatService = container.read(chatServiceProvider);

    final example = MessageCreationExample(chatService);
    await example.createExampleMessage();
  }
}

/// Usage example in a widget:
/// 
/// ```dart
/// class ChatScreen extends ConsumerWidget {
///   final String chatRoomId;
///   final String senderId;
///   final String receiverId;
///   final String garageYardId;
///   
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final chatService = ref.read(chatServiceProvider);
///     
///     return Column(
///       children: [
///         // Chat messages list
///         Expanded(child: ChatMessagesList()),
///         
///         // Message input
///         MessageInput(
///           onSendMessage: (text) async {
///             final success = await chatService.sendMessage(
///               chatRoomId: chatRoomId,
///               senderId: senderId,
///               receiverId: receiverId,
///               garageYardId: garageYardId,
///               text: text,
///             );
///             
///             if (success) {
///               // Show success feedback
///               ScaffoldMessenger.of(context).showSnackBar(
///                 SnackBar(content: Text('Message sent!')),
///               );
///             }
///           },
///         ),
///       ],
///     );
///   }
/// }
/// ```

/// Example of the complete message structure that will be stored in Firestore:
/// 
/// ```json
/// {
///   "id": "message_id",
///   "chat_room_id": "BRXSpnKjPklVIvjJpzVa",
///   "sender_id": "4",
///   "receiver_id": "12",
///   "garage_yard_id": "garage_yard_123",
///   "text": "hello",
///   "message_type": "text",
///   "created_at": "2025-10-11T12:49:24.000Z",
///   "timestamp": "2025-10-11T12:49:24.000Z",
///   "is_read": false,
///   "is_delivered": false,
///   "is_deleted": false,
///   "image_url": null,
///   "file_url": null,
///   "reply_to": null
/// }
/// ```
