import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:findcarsale/services/chat_service/domain/repositories/chat_repository.dart';
import 'package:findcarsale/shared/domain/models/chat/chat_models.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collections
  static const String _chatRoomsCollection = 'chat_rooms';
  static const String _messagesCollection = 'messages';
  static const String _usersCollection = 'chat_users';
  static const String _notificationsCollection = 'chat_notifications';

  // Check if Firebase is initialized
  Future<bool> _isFirebaseInitialized() async {
    try {
      await Firebase.app();
      return true;
    } catch (e) {
      PrintUtils.customLog('Firebase not initialized: $e');
      return false;
    }
  }

  @override
  Future<Either<String, List<ChatRoom>>> getUserChatRooms(String userId) async {
    try {
      if (!await _isFirebaseInitialized()) {
        return Left('Firebase not initialized');
      }

      final querySnapshot =
          await _firestore
              .collection(_chatRoomsCollection)
              .where('participants', arrayContains: userId)
              .where('is_active', isEqualTo: true)
              .orderBy('updated_at', descending: true)
              .get();

      final chatRooms =
          querySnapshot.docs
              .map((doc) => ChatRoom.fromJson({'id': doc.id, ...doc.data()}))
              .toList();

      return Right(chatRooms);
    } catch (e) {
      PrintUtils.customLog('Error getting user chat rooms: $e');
      return Left('Failed to get chat rooms: $e');
    }
  }

  @override
  Stream<List<ChatRoom>> getUserChatRoomsStream(String userId) {
    return Stream.fromFuture(_isFirebaseInitialized()).asyncExpand((
      isInitialized,
    ) {
      if (!isInitialized) {
        return Stream.value(<ChatRoom>[]);
      }

      // Simplified query without complex ordering to avoid index requirements
      return _firestore
          .collection(_chatRoomsCollection)
          .where('participants', arrayContains: userId)
          .where('is_active', isEqualTo: true)
          .snapshots()
          .map((snapshot) {
            final chatRooms =
                snapshot.docs
                    .map(
                      (doc) => ChatRoom.fromJson({'id': doc.id, ...doc.data()}),
                    )
                    .toList();

            // Sort by updated_at in memory to avoid index requirement
            chatRooms.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
            return chatRooms;
          });
    });
  }

  @override
  Future<Either<String, ChatRoom?>> getChatRoom(String roomId) async {
    try {
      final doc =
          await _firestore.collection(_chatRoomsCollection).doc(roomId).get();

      if (!doc.exists) {
        return Right(null);
      }

      final chatRoom = ChatRoom.fromJson({'id': doc.id, ...doc.data()!});

      return Right(chatRoom);
    } catch (e) {
      PrintUtils.customLog('Error getting chat room: $e');
      return Left('Failed to get chat room: $e');
    }
  }

  @override
  Future<Either<String, ChatRoom>> createChatRoom({
    required String garageYardId,
    required String sellerId,
    required String buyerId,
    String? garageYardTitle,
    String? chatInitiatedByUsername,
  }) async {
    try {
      if (!await _isFirebaseInitialized()) {
        return Left('Firebase not initialized');
      }

      final participants = [sellerId, buyerId];
      final now = DateTime.now();

      final chatRoomData = {
        'participants': participants,
        'garage_yard_id': garageYardId,
        'garage_yard_title': garageYardTitle,
        'chat_initiated_by_username': chatInitiatedByUsername,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
        'is_active': true,
        'unread_count': 0,
        'last_read_by': <String, String>{},
      };

      final docRef = await _firestore
          .collection(_chatRoomsCollection)
          .add(chatRoomData);

      final chatRoom = ChatRoom.fromJson({'id': docRef.id, ...chatRoomData});

      return Right(chatRoom);
    } catch (e) {
      PrintUtils.customLog('Error creating chat room: $e');
      return Left('Failed to create chat room: $e');
    }
  }

  @override
  Future<Either<String, ChatRoom?>> findExistingChatRoom({
    required String garageYardId,
    required String userId,
  }) async {
    try {
      if (!await _isFirebaseInitialized()) {
        return Left('Firebase not initialized');
      }

      final querySnapshot =
          await _firestore
              .collection(_chatRoomsCollection)
              .where('garage_yard_id', isEqualTo: garageYardId)
              .where('participants', arrayContains: userId)
              .where('is_active', isEqualTo: true)
              .limit(1)
              .get();

      if (querySnapshot.docs.isEmpty) {
        return Right(null);
      }

      final doc = querySnapshot.docs.first;
      final chatRoom = ChatRoom.fromJson({'id': doc.id, ...doc.data()});

      return Right(chatRoom);
    } catch (e) {
      PrintUtils.customLog('Error finding existing chat room: $e');
      return Left('Failed to find chat room: $e');
    }
  }

  @override
  Future<Either<String, List<ChatMessage>>> getChatMessages(
    String roomId,
  ) async {
    try {
      final querySnapshot =
          await _firestore
              .collection(_chatRoomsCollection)
              .doc(roomId)
              .collection(_messagesCollection)
              .orderBy('created_at', descending: true)
              .limit(50)
              .get();

      final messages =
          querySnapshot.docs
              .map((doc) => ChatMessage.fromJson({'id': doc.id, ...doc.data()}))
              .toList();

      return Right(messages);
    } catch (e) {
      PrintUtils.customLog('Error getting chat messages: $e');
      return Left('Failed to get messages: $e');
    }
  }

  @override
  Stream<List<ChatMessage>> getChatMessagesStream(String roomId) {
    return _firestore
        .collection(_chatRoomsCollection)
        .doc(roomId)
        .collection(_messagesCollection)
        .orderBy('created_at', descending: true)
        .limit(50)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) =>
                        ChatMessage.fromJson({'id': doc.id, ...doc.data()}),
                  )
                  .toList(),
        );
  }

  @override
  Future<Either<String, ChatMessage>> sendMessage(ChatMessage message) async {
    try {
      final messageData = message.toJson();
      messageData.remove('id');

      // Find the chat room ID by garage yard ID and participants
      final chatRoomQuery =
          await _firestore
              .collection(_chatRoomsCollection)
              .where('garage_yard_id', isEqualTo: message.garageYardId)
              .where('participants', arrayContains: message.senderId)
              .limit(1)
              .get();

      if (chatRoomQuery.docs.isEmpty) {
        return Left('Chat room not found');
      }

      final chatRoomId = chatRoomQuery.docs.first.id;

      final docRef = await _firestore
          .collection(_chatRoomsCollection)
          .doc(chatRoomId)
          .collection(_messagesCollection)
          .add(messageData);

      // Update chat room with last message
      await _firestore.collection(_chatRoomsCollection).doc(chatRoomId).update({
        'last_message': message.copyWith(id: docRef.id).toJson(),
        'updated_at': message.createdAt.toIso8601String(),
        'unread_count': FieldValue.increment(1),
      });

      final sentMessage = message.copyWith(id: docRef.id);
      return Right(sentMessage);
    } catch (e) {
      PrintUtils.customLog('Error sending message: $e');
      return Left('Failed to send message: $e');
    }
  }

  @override
  Future<Either<String, void>> markMessageAsRead(
    String messageId,
    String userId,
  ) async {
    try {
      // This would need to be implemented based on your specific requirements
      // For now, we'll update the chat room's last_read_by field
      return Right(null);
    } catch (e) {
      PrintUtils.customLog('Error marking message as read: $e');
      return Left('Failed to mark message as read: $e');
    }
  }

  @override
  Future<Either<String, void>> markAllMessagesAsRead(
    String roomId,
    String userId,
  ) async {
    try {
      await _firestore.collection(_chatRoomsCollection).doc(roomId).update({
        'last_read_by.$userId': DateTime.now().toIso8601String(),
        'unread_count': 0,
      });

      return Right(null);
    } catch (e) {
      PrintUtils.customLog('Error marking all messages as read: $e');
      return Left('Failed to mark messages as read: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteMessage(String messageId) async {
    try {
      // This would need the roomId to be passed as well
      // For now, returning success
      return Right(null);
    } catch (e) {
      PrintUtils.customLog('Error deleting message: $e');
      return Left('Failed to delete message: $e');
    }
  }

  @override
  Future<Either<String, ChatUser?>> getChatUser(String userId) async {
    try {
      final doc =
          await _firestore.collection(_usersCollection).doc(userId).get();

      if (!doc.exists) {
        return Right(null);
      }

      final user = ChatUser.fromJson({'id': doc.id, ...doc.data()!});

      return Right(user);
    } catch (e) {
      PrintUtils.customLog('Error getting chat user: $e');
      return Left('Failed to get user: $e');
    }
  }

  @override
  Future<Either<String, void>> updateUserOnlineStatus(
    String userId,
    bool isOnline,
  ) async {
    try {
      await _firestore.collection(_usersCollection).doc(userId).update({
        'is_online': isOnline,
        'last_seen': DateTime.now().toIso8601String(),
      });

      return Right(null);
    } catch (e) {
      PrintUtils.customLog('Error updating user online status: $e');
      return Left('Failed to update status: $e');
    }
  }

  @override
  Future<Either<String, void>> updateUserLastSeen(String userId) async {
    try {
      await _firestore.collection(_usersCollection).doc(userId).update({
        'last_seen': DateTime.now().toIso8601String(),
      });

      return Right(null);
    } catch (e) {
      PrintUtils.customLog('Error updating user last seen: $e');
      return Left('Failed to update last seen: $e');
    }
  }

  @override
  Future<Either<String, List<ChatNotification>>> getUserNotifications(
    String userId,
  ) async {
    try {
      final querySnapshot =
          await _firestore
              .collection(_notificationsCollection)
              .where('receiver_id', isEqualTo: userId)
              .orderBy('created_at', descending: true)
              .limit(20)
              .get();

      final notifications =
          querySnapshot.docs
              .map(
                (doc) =>
                    ChatNotification.fromJson({'id': doc.id, ...doc.data()}),
              )
              .toList();

      return Right(notifications);
    } catch (e) {
      PrintUtils.customLog('Error getting notifications: $e');
      return Left('Failed to get notifications: $e');
    }
  }

  @override
  Future<Either<String, void>> markNotificationAsRead(
    String notificationId,
  ) async {
    try {
      await _firestore
          .collection(_notificationsCollection)
          .doc(notificationId)
          .update({'is_read': true});

      return Right(null);
    } catch (e) {
      PrintUtils.customLog('Error marking notification as read: $e');
      return Left('Failed to mark notification as read: $e');
    }
  }

  @override
  Future<Either<String, void>> sendChatNotification(
    ChatNotification notification,
  ) async {
    try {
      final notificationData = notification.toJson();
      notificationData.remove('id');

      await _firestore
          .collection(_notificationsCollection)
          .add(notificationData);

      return Right(null);
    } catch (e) {
      PrintUtils.customLog('Error sending notification: $e');
      return Left('Failed to send notification: $e');
    }
  }

  @override
  Stream<ChatRoom> getChatRoomUpdates(String roomId) {
    return _firestore
        .collection(_chatRoomsCollection)
        .doc(roomId)
        .snapshots()
        .map(
          (snapshot) =>
              ChatRoom.fromJson({'id': snapshot.id, ...snapshot.data()!}),
        );
  }

  @override
  Stream<int> getUnreadCountStream(String userId) {
    return _firestore
        .collection(_chatRoomsCollection)
        .where('participants', arrayContains: userId)
        .where('is_active', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold(
            0,
            (sum, doc) => sum + (doc.data()['unread_count'] as int? ?? 0),
          ),
        );
  }
}
