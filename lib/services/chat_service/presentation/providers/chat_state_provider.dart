import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/chat_service/domain/providers/chat_providers.dart';
import 'package:findcarsale/services/chat_service/domain/repositories/chat_repository.dart';
import 'package:findcarsale/shared/domain/models/chat/chat_models.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

// Chat Service Provider
final chatServiceProvider = Provider<ChatService>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatService(repository);
});

class ChatService {
  final ChatRepository _repository;

  ChatService(this._repository);

  // Create or get existing chat room
  Future<ChatRoom?> createOrGetChatRoom({
    required String garageYardId,
    required String sellerId,
    required String buyerId,
    String? garageYardTitle,
    String? chatInitiatedByUsername,
  }) async {
    try {
      // First, try to find existing chat room
      final existingResult = await _repository.findExistingChatRoom(
        garageYardId: garageYardId,
        userId: buyerId,
      );

      if (existingResult.isRight() &&
          existingResult.getOrElse(() => null) != null) {
        return existingResult.getOrElse(() => null);
      }

      // Create new chat room if none exists
      final createResult = await _repository.createChatRoom(
        garageYardId: garageYardId,
        sellerId: sellerId,
        buyerId: buyerId,
        garageYardTitle: garageYardTitle,
        chatInitiatedByUsername: chatInitiatedByUsername,
      );

      return createResult.fold((error) {
        PrintUtils.customLog('Error creating chat room: $error');
        return null;
      }, (chatRoom) => chatRoom);
    } catch (e) {
      PrintUtils.customLog('Error in createOrGetChatRoom: $e');
      return null;
    }
  }

  // Send message
  Future<bool> sendMessage({
    required String senderId,
    required String receiverId,
    required String garageYardId,
    required String message,
    MessageType messageType = MessageType.text,
    String? imageUrl,
    String? fileUrl,
    String? replyTo,
  }) async {
    try {
      PrintUtils.customLog(
        'Sending message: senderId=$senderId, receiverId=$receiverId, garageYardId=$garageYardId, message=$message',
      );

      final chatMessage = ChatMessage(
        senderId: senderId,
        receiverId: receiverId,
        garageYardId: garageYardId,
        message: message,
        messageType: messageType,
        createdAt: DateTime.now(),
        imageUrl: imageUrl,
        fileUrl: fileUrl,
        replyTo: replyTo,
      );

      final result = await _repository.sendMessage(chatMessage);

      return result.fold(
        (error) {
          PrintUtils.customLog('Error sending message: $error');
          return false;
        },
        (message) {
          PrintUtils.customLog('Message sent successfully: ${message.id}');
          return true;
        },
      );
    } catch (e) {
      PrintUtils.customLog('Error in sendMessage: $e');
      return false;
    }
  }

  // Mark messages as read
  Future<bool> markMessagesAsRead(String roomId, String userId) async {
    try {
      final result = await _repository.markAllMessagesAsRead(roomId, userId);
      return result.fold((error) {
        PrintUtils.customLog('Error marking messages as read: $error');
        return false;
      }, (_) => true);
    } catch (e) {
      PrintUtils.customLog('Error in markMessagesAsRead: $e');
      return false;
    }
  }

  // Update user online status
  Future<bool> updateUserOnlineStatus(String userId, bool isOnline) async {
    try {
      final result = await _repository.updateUserOnlineStatus(userId, isOnline);
      return result.fold((error) {
        PrintUtils.customLog('Error updating online status: $error');
        return false;
      }, (_) => true);
    } catch (e) {
      PrintUtils.customLog('Error in updateUserOnlineStatus: $e');
      return false;
    }
  }

  // Send notification
  Future<bool> sendNotification({
    required String senderId,
    required String receiverId,
    required String garageYardId,
    required String garageYardTitle,
    required String message,
  }) async {
    try {
      final notification = ChatNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: senderId,
        receiverId: receiverId,
        garageYardId: garageYardId,
        garageYardTitle: garageYardTitle,
        message: message,
        createdAt: DateTime.now(),
      );

      final result = await _repository.sendChatNotification(notification);
      return result.fold((error) {
        PrintUtils.customLog('Error sending notification: $error');
        return false;
      }, (_) => true);
    } catch (e) {
      PrintUtils.customLog('Error in sendNotification: $e');
      return false;
    }
  }
}
