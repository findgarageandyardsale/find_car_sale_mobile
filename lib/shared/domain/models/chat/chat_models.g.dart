// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String?,
      chatRoomId: json['chat_room_id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      garageYardId: json['garage_yard_id'] as String,
      text: json['text'] as String,
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['message_type']) ??
          MessageType.text,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['is_read'] as bool? ?? false,
      isDelivered: json['is_delivered'] as bool? ?? false,
      isDeleted: json['is_deleted'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String?,
      fileUrl: json['fileUrl'] as String?,
      replyTo: json['reply_to'] as String?,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_room_id': instance.chatRoomId,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'garage_yard_id': instance.garageYardId,
      'text': instance.text,
      'message_type': _$MessageTypeEnumMap[instance.messageType]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'timestamp': instance.timestamp.toIso8601String(),
      'is_read': instance.isRead,
      'is_delivered': instance.isDelivered,
      'is_deleted': instance.isDeleted,
      'imageUrl': instance.imageUrl,
      'fileUrl': instance.fileUrl,
      'reply_to': instance.replyTo,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.file: 'file',
  MessageType.system: 'system',
};

_$ChatRoomImpl _$$ChatRoomImplFromJson(
  Map<String, dynamic> json,
) => _$ChatRoomImpl(
  id: json['id'] as String?,
  participants:
      (json['participants'] as List<dynamic>).map((e) => e as String).toList(),
  buyerId: json['buyer_id'] as String,
  buyerName: json['buyer_name'] as String,
  buyerUnreadCount: (json['buyer_unread_count'] as num?)?.toInt() ?? 0,
  sellerId: json['seller_id'] as String,
  sellerName: json['seller_name'] as String,
  sellerUnreadCount: (json['seller_unread_count'] as num?)?.toInt() ?? 0,
  postId: json['post_id'] as String,
  postTitle: json['post_title'] as String,
  garageYardId: json['garage_yard_id'] as String,
  garageYardTitle: json['garage_yard_title'] as String?,
  chatInitiatedByUsername: json['chat_initiated_by_username'] as String?,
  lastMessage:
      json['last_message'] == null
          ? null
          : ChatMessage.fromJson(json['last_message'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  isActive: json['is_active'] as bool? ?? true,
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  lastReadBy: (json['last_read_by'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, DateTime.parse(e as String)),
  ),
);

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participants': instance.participants,
      'buyer_id': instance.buyerId,
      'buyer_name': instance.buyerName,
      'buyer_unread_count': instance.buyerUnreadCount,
      'seller_id': instance.sellerId,
      'seller_name': instance.sellerName,
      'seller_unread_count': instance.sellerUnreadCount,
      'post_id': instance.postId,
      'post_title': instance.postTitle,
      'garage_yard_id': instance.garageYardId,
      'garage_yard_title': instance.garageYardTitle,
      'chat_initiated_by_username': instance.chatInitiatedByUsername,
      'last_message': instance.lastMessage,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'is_active': instance.isActive,
      'unread_count': instance.unreadCount,
      'last_read_by': instance.lastReadBy?.map(
        (k, e) => MapEntry(k, e.toIso8601String()),
      ),
    };

_$ChatUserImpl _$$ChatUserImplFromJson(Map<String, dynamic> json) =>
    _$ChatUserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      isOnline: json['is_online'] as bool? ?? false,
      lastSeen:
          json['last_seen'] == null
              ? null
              : DateTime.parse(json['last_seen'] as String),
    );

Map<String, dynamic> _$$ChatUserImplToJson(_$ChatUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'is_online': instance.isOnline,
      'last_seen': instance.lastSeen?.toIso8601String(),
    };

_$ChatNotificationImpl _$$ChatNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$ChatNotificationImpl(
  id: json['id'] as String,
  senderId: json['sender_id'] as String,
  receiverId: json['receiver_id'] as String,
  garageYardId: json['garage_yard_id'] as String,
  garageYardTitle: json['garage_yard_title'] as String,
  message: json['message'] as String,
  isRead: json['is_read'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$ChatNotificationImplToJson(
  _$ChatNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sender_id': instance.senderId,
  'receiver_id': instance.receiverId,
  'garage_yard_id': instance.garageYardId,
  'garage_yard_title': instance.garageYardTitle,
  'message': instance.message,
  'is_read': instance.isRead,
  'created_at': instance.createdAt.toIso8601String(),
};
