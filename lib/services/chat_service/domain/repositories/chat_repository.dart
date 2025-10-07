import 'package:dartz/dartz.dart';
import 'package:findcarsale/shared/domain/models/chat/chat_models.dart';

abstract class ChatRepository {
  // Chat Rooms
  Future<Either<String, List<ChatRoom>>> getUserChatRooms(String userId);
  Future<Either<String, ChatRoom?>> getChatRoom(String roomId);
  Future<Either<String, ChatRoom>> createChatRoom({
    required String garageYardId,
    required String sellerId,
    required String buyerId,
    String? garageYardTitle,
    String? chatInitiatedByUsername,
  });
  Future<Either<String, ChatRoom?>> findExistingChatRoom({
    required String garageYardId,
    required String userId,
  });

  // Messages
  Future<Either<String, List<ChatMessage>>> getChatMessages(String roomId);
  Stream<List<ChatMessage>> getChatMessagesStream(String roomId);
  Future<Either<String, ChatMessage>> sendMessage(ChatMessage message);
  Future<Either<String, void>> markMessageAsRead(
    String messageId,
    String userId,
  );
  Future<Either<String, void>> markAllMessagesAsRead(
    String roomId,
    String userId,
  );
  Future<Either<String, void>> deleteMessage(String messageId);

  // Users
  Future<Either<String, ChatUser?>> getChatUser(String userId);
  Future<Either<String, void>> updateUserOnlineStatus(
    String userId,
    bool isOnline,
  );
  Future<Either<String, void>> updateUserLastSeen(String userId);

  // Notifications
  Future<Either<String, List<ChatNotification>>> getUserNotifications(
    String userId,
  );
  Future<Either<String, void>> markNotificationAsRead(String notificationId);
  Future<Either<String, void>> sendChatNotification(
    ChatNotification notification,
  );

  // Real-time updates
  Stream<ChatRoom> getChatRoomUpdates(String roomId);
  Stream<List<ChatRoom>> getUserChatRoomsStream(String userId);
  Stream<int> getUnreadCountStream(String userId);
}
