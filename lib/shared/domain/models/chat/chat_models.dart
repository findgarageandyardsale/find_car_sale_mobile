// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_models.freezed.dart';
part 'chat_models.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    String? id,
    @JsonKey(name: 'chat_room_id') required String chatRoomId,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'receiver_id') required String receiverId,
    @JsonKey(name: 'garage_yard_id') required String garageYardId,
    required String text,
    @JsonKey(name: 'message_type')
    @Default(MessageType.text)
    MessageType messageType,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'timestamp') required DateTime timestamp,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'is_delivered') @Default(false) bool isDelivered,
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
    String? imageUrl,
    String? fileUrl,
    @JsonKey(name: 'reply_to') String? replyTo,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    String? id,
    required List<String> participants,
    @JsonKey(name: 'buyer_id') required String buyerId,
    @JsonKey(name: 'buyer_name') required String buyerName,
    @JsonKey(name: 'buyer_unread_count') @Default(0) int buyerUnreadCount,
    @JsonKey(name: 'seller_id') required String sellerId,
    @JsonKey(name: 'seller_name') required String sellerName,
    @JsonKey(name: 'seller_unread_count') @Default(0) int sellerUnreadCount,
    @JsonKey(name: 'post_id') required String postId,
    @JsonKey(name: 'post_title') required String postTitle,
    @JsonKey(name: 'garage_yard_id') required String garageYardId,
    @JsonKey(name: 'garage_yard_title') String? garageYardTitle,
    @JsonKey(name: 'chat_initiated_by_username')
    String? chatInitiatedByUsername,
    @JsonKey(name: 'last_message') ChatMessage? lastMessage,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'last_read_by') Map<String, DateTime>? lastReadBy,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}

@freezed
class ChatUser with _$ChatUser {
  const factory ChatUser({
    required String id,
    required String name,
    String? email,
    String? profileImage,
    @JsonKey(name: 'is_online') @Default(false) bool isOnline,
    @JsonKey(name: 'last_seen') DateTime? lastSeen,
  }) = _ChatUser;

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);
}

@freezed
class ChatNotification with _$ChatNotification {
  const factory ChatNotification({
    required String id,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'receiver_id') required String receiverId,
    @JsonKey(name: 'garage_yard_id') required String garageYardId,
    @JsonKey(name: 'garage_yard_title') required String garageYardTitle,
    required String message,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _ChatNotification;

  factory ChatNotification.fromJson(Map<String, dynamic> json) =>
      _$ChatNotificationFromJson(json);
}

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('file')
  file,
  @JsonValue('system')
  system,
}

enum ChatStatus {
  @JsonValue('active')
  active,
  @JsonValue('archived')
  archived,
  @JsonValue('blocked')
  blocked,
}
