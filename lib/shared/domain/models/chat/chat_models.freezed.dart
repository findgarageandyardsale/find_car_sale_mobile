// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_room_id')
  String get chatRoomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  String get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiver_id')
  String get receiverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'garage_yard_id')
  String get garageYardId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_type')
  MessageType get messageType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'timestamp')
  DateTime get timestamp => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_delivered')
  bool get isDelivered => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted')
  bool get isDeleted => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_to')
  String? get replyTo => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'chat_room_id') String chatRoomId,
    @JsonKey(name: 'sender_id') String senderId,
    @JsonKey(name: 'receiver_id') String receiverId,
    @JsonKey(name: 'garage_yard_id') String garageYardId,
    String text,
    @JsonKey(name: 'message_type') MessageType messageType,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'timestamp') DateTime timestamp,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'is_delivered') bool isDelivered,
    @JsonKey(name: 'is_deleted') bool isDeleted,
    String? imageUrl,
    String? fileUrl,
    @JsonKey(name: 'reply_to') String? replyTo,
  });
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? chatRoomId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? garageYardId = null,
    Object? text = null,
    Object? messageType = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? timestamp = null,
    Object? isRead = null,
    Object? isDelivered = null,
    Object? isDeleted = null,
    Object? imageUrl = freezed,
    Object? fileUrl = freezed,
    Object? replyTo = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            chatRoomId:
                null == chatRoomId
                    ? _value.chatRoomId
                    : chatRoomId // ignore: cast_nullable_to_non_nullable
                        as String,
            senderId:
                null == senderId
                    ? _value.senderId
                    : senderId // ignore: cast_nullable_to_non_nullable
                        as String,
            receiverId:
                null == receiverId
                    ? _value.receiverId
                    : receiverId // ignore: cast_nullable_to_non_nullable
                        as String,
            garageYardId:
                null == garageYardId
                    ? _value.garageYardId
                    : garageYardId // ignore: cast_nullable_to_non_nullable
                        as String,
            text:
                null == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String,
            messageType:
                null == messageType
                    ? _value.messageType
                    : messageType // ignore: cast_nullable_to_non_nullable
                        as MessageType,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isRead:
                null == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool,
            isDelivered:
                null == isDelivered
                    ? _value.isDelivered
                    : isDelivered // ignore: cast_nullable_to_non_nullable
                        as bool,
            isDeleted:
                null == isDeleted
                    ? _value.isDeleted
                    : isDeleted // ignore: cast_nullable_to_non_nullable
                        as bool,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            fileUrl:
                freezed == fileUrl
                    ? _value.fileUrl
                    : fileUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            replyTo:
                freezed == replyTo
                    ? _value.replyTo
                    : replyTo // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'chat_room_id') String chatRoomId,
    @JsonKey(name: 'sender_id') String senderId,
    @JsonKey(name: 'receiver_id') String receiverId,
    @JsonKey(name: 'garage_yard_id') String garageYardId,
    String text,
    @JsonKey(name: 'message_type') MessageType messageType,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'timestamp') DateTime timestamp,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'is_delivered') bool isDelivered,
    @JsonKey(name: 'is_deleted') bool isDeleted,
    String? imageUrl,
    String? fileUrl,
    @JsonKey(name: 'reply_to') String? replyTo,
  });
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? chatRoomId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? garageYardId = null,
    Object? text = null,
    Object? messageType = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? timestamp = null,
    Object? isRead = null,
    Object? isDelivered = null,
    Object? isDeleted = null,
    Object? imageUrl = freezed,
    Object? fileUrl = freezed,
    Object? replyTo = freezed,
  }) {
    return _then(
      _$ChatMessageImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        chatRoomId:
            null == chatRoomId
                ? _value.chatRoomId
                : chatRoomId // ignore: cast_nullable_to_non_nullable
                    as String,
        senderId:
            null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverId:
            null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                    as String,
        garageYardId:
            null == garageYardId
                ? _value.garageYardId
                : garageYardId // ignore: cast_nullable_to_non_nullable
                    as String,
        text:
            null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        messageType:
            null == messageType
                ? _value.messageType
                : messageType // ignore: cast_nullable_to_non_nullable
                    as MessageType,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isRead:
            null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool,
        isDelivered:
            null == isDelivered
                ? _value.isDelivered
                : isDelivered // ignore: cast_nullable_to_non_nullable
                    as bool,
        isDeleted:
            null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                    as bool,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        fileUrl:
            freezed == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        replyTo:
            freezed == replyTo
                ? _value.replyTo
                : replyTo // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl with DiagnosticableTreeMixin implements _ChatMessage {
  const _$ChatMessageImpl({
    this.id,
    @JsonKey(name: 'chat_room_id') required this.chatRoomId,
    @JsonKey(name: 'sender_id') required this.senderId,
    @JsonKey(name: 'receiver_id') required this.receiverId,
    @JsonKey(name: 'garage_yard_id') required this.garageYardId,
    required this.text,
    @JsonKey(name: 'message_type') this.messageType = MessageType.text,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    @JsonKey(name: 'timestamp') required this.timestamp,
    @JsonKey(name: 'is_read') this.isRead = false,
    @JsonKey(name: 'is_delivered') this.isDelivered = false,
    @JsonKey(name: 'is_deleted') this.isDeleted = false,
    this.imageUrl,
    this.fileUrl,
    @JsonKey(name: 'reply_to') this.replyTo,
  });

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'chat_room_id')
  final String chatRoomId;
  @override
  @JsonKey(name: 'sender_id')
  final String senderId;
  @override
  @JsonKey(name: 'receiver_id')
  final String receiverId;
  @override
  @JsonKey(name: 'garage_yard_id')
  final String garageYardId;
  @override
  final String text;
  @override
  @JsonKey(name: 'message_type')
  final MessageType messageType;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'timestamp')
  final DateTime timestamp;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;
  @override
  @JsonKey(name: 'is_delivered')
  final bool isDelivered;
  @override
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @override
  final String? imageUrl;
  @override
  final String? fileUrl;
  @override
  @JsonKey(name: 'reply_to')
  final String? replyTo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessage(id: $id, chatRoomId: $chatRoomId, senderId: $senderId, receiverId: $receiverId, garageYardId: $garageYardId, text: $text, messageType: $messageType, createdAt: $createdAt, updatedAt: $updatedAt, timestamp: $timestamp, isRead: $isRead, isDelivered: $isDelivered, isDeleted: $isDeleted, imageUrl: $imageUrl, fileUrl: $fileUrl, replyTo: $replyTo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessage'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('chatRoomId', chatRoomId))
      ..add(DiagnosticsProperty('senderId', senderId))
      ..add(DiagnosticsProperty('receiverId', receiverId))
      ..add(DiagnosticsProperty('garageYardId', garageYardId))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('messageType', messageType))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('isRead', isRead))
      ..add(DiagnosticsProperty('isDelivered', isDelivered))
      ..add(DiagnosticsProperty('isDeleted', isDeleted))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('fileUrl', fileUrl))
      ..add(DiagnosticsProperty('replyTo', replyTo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.garageYardId, garageYardId) ||
                other.garageYardId == garageYardId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isDelivered, isDelivered) ||
                other.isDelivered == isDelivered) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    chatRoomId,
    senderId,
    receiverId,
    garageYardId,
    text,
    messageType,
    createdAt,
    updatedAt,
    timestamp,
    isRead,
    isDelivered,
    isDeleted,
    imageUrl,
    fileUrl,
    replyTo,
  );

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage({
    final String? id,
    @JsonKey(name: 'chat_room_id') required final String chatRoomId,
    @JsonKey(name: 'sender_id') required final String senderId,
    @JsonKey(name: 'receiver_id') required final String receiverId,
    @JsonKey(name: 'garage_yard_id') required final String garageYardId,
    required final String text,
    @JsonKey(name: 'message_type') final MessageType messageType,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
    @JsonKey(name: 'timestamp') required final DateTime timestamp,
    @JsonKey(name: 'is_read') final bool isRead,
    @JsonKey(name: 'is_delivered') final bool isDelivered,
    @JsonKey(name: 'is_deleted') final bool isDeleted,
    final String? imageUrl,
    final String? fileUrl,
    @JsonKey(name: 'reply_to') final String? replyTo,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'chat_room_id')
  String get chatRoomId;
  @override
  @JsonKey(name: 'sender_id')
  String get senderId;
  @override
  @JsonKey(name: 'receiver_id')
  String get receiverId;
  @override
  @JsonKey(name: 'garage_yard_id')
  String get garageYardId;
  @override
  String get text;
  @override
  @JsonKey(name: 'message_type')
  MessageType get messageType;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'timestamp')
  DateTime get timestamp;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead;
  @override
  @JsonKey(name: 'is_delivered')
  bool get isDelivered;
  @override
  @JsonKey(name: 'is_deleted')
  bool get isDeleted;
  @override
  String? get imageUrl;
  @override
  String? get fileUrl;
  @override
  @JsonKey(name: 'reply_to')
  String? get replyTo;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  String? get id => throw _privateConstructorUsedError;
  List<String> get participants => throw _privateConstructorUsedError;
  @JsonKey(name: 'buyer_id')
  String get buyerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'buyer_name')
  String get buyerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'buyer_unread_count')
  int get buyerUnreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'seller_id')
  String get sellerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'seller_name')
  String get sellerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'seller_unread_count')
  int get sellerUnreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_id')
  String get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_title')
  String get postTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'garage_yard_id')
  String get garageYardId => throw _privateConstructorUsedError;
  @JsonKey(name: 'garage_yard_title')
  String? get garageYardTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_initiated_by_username')
  String? get chatInitiatedByUsername => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_read_by')
  Map<String, DateTime>? get lastReadBy => throw _privateConstructorUsedError;

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call({
    String? id,
    List<String> participants,
    @JsonKey(name: 'buyer_id') String buyerId,
    @JsonKey(name: 'buyer_name') String buyerName,
    @JsonKey(name: 'buyer_unread_count') int buyerUnreadCount,
    @JsonKey(name: 'seller_id') String sellerId,
    @JsonKey(name: 'seller_name') String sellerName,
    @JsonKey(name: 'seller_unread_count') int sellerUnreadCount,
    @JsonKey(name: 'post_id') String postId,
    @JsonKey(name: 'post_title') String postTitle,
    @JsonKey(name: 'garage_yard_id') String garageYardId,
    @JsonKey(name: 'garage_yard_title') String? garageYardTitle,
    @JsonKey(name: 'chat_initiated_by_username')
    String? chatInitiatedByUsername,
    @JsonKey(name: 'last_message') ChatMessage? lastMessage,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'last_read_by') Map<String, DateTime>? lastReadBy,
  });

  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? participants = null,
    Object? buyerId = null,
    Object? buyerName = null,
    Object? buyerUnreadCount = null,
    Object? sellerId = null,
    Object? sellerName = null,
    Object? sellerUnreadCount = null,
    Object? postId = null,
    Object? postTitle = null,
    Object? garageYardId = null,
    Object? garageYardTitle = freezed,
    Object? chatInitiatedByUsername = freezed,
    Object? lastMessage = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isActive = null,
    Object? unreadCount = null,
    Object? lastReadBy = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            participants:
                null == participants
                    ? _value.participants
                    : participants // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            buyerId:
                null == buyerId
                    ? _value.buyerId
                    : buyerId // ignore: cast_nullable_to_non_nullable
                        as String,
            buyerName:
                null == buyerName
                    ? _value.buyerName
                    : buyerName // ignore: cast_nullable_to_non_nullable
                        as String,
            buyerUnreadCount:
                null == buyerUnreadCount
                    ? _value.buyerUnreadCount
                    : buyerUnreadCount // ignore: cast_nullable_to_non_nullable
                        as int,
            sellerId:
                null == sellerId
                    ? _value.sellerId
                    : sellerId // ignore: cast_nullable_to_non_nullable
                        as String,
            sellerName:
                null == sellerName
                    ? _value.sellerName
                    : sellerName // ignore: cast_nullable_to_non_nullable
                        as String,
            sellerUnreadCount:
                null == sellerUnreadCount
                    ? _value.sellerUnreadCount
                    : sellerUnreadCount // ignore: cast_nullable_to_non_nullable
                        as int,
            postId:
                null == postId
                    ? _value.postId
                    : postId // ignore: cast_nullable_to_non_nullable
                        as String,
            postTitle:
                null == postTitle
                    ? _value.postTitle
                    : postTitle // ignore: cast_nullable_to_non_nullable
                        as String,
            garageYardId:
                null == garageYardId
                    ? _value.garageYardId
                    : garageYardId // ignore: cast_nullable_to_non_nullable
                        as String,
            garageYardTitle:
                freezed == garageYardTitle
                    ? _value.garageYardTitle
                    : garageYardTitle // ignore: cast_nullable_to_non_nullable
                        as String?,
            chatInitiatedByUsername:
                freezed == chatInitiatedByUsername
                    ? _value.chatInitiatedByUsername
                    : chatInitiatedByUsername // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as ChatMessage?,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            unreadCount:
                null == unreadCount
                    ? _value.unreadCount
                    : unreadCount // ignore: cast_nullable_to_non_nullable
                        as int,
            lastReadBy:
                freezed == lastReadBy
                    ? _value.lastReadBy
                    : lastReadBy // ignore: cast_nullable_to_non_nullable
                        as Map<String, DateTime>?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
    _$ChatRoomImpl value,
    $Res Function(_$ChatRoomImpl) then,
  ) = __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    List<String> participants,
    @JsonKey(name: 'buyer_id') String buyerId,
    @JsonKey(name: 'buyer_name') String buyerName,
    @JsonKey(name: 'buyer_unread_count') int buyerUnreadCount,
    @JsonKey(name: 'seller_id') String sellerId,
    @JsonKey(name: 'seller_name') String sellerName,
    @JsonKey(name: 'seller_unread_count') int sellerUnreadCount,
    @JsonKey(name: 'post_id') String postId,
    @JsonKey(name: 'post_title') String postTitle,
    @JsonKey(name: 'garage_yard_id') String garageYardId,
    @JsonKey(name: 'garage_yard_title') String? garageYardTitle,
    @JsonKey(name: 'chat_initiated_by_username')
    String? chatInitiatedByUsername,
    @JsonKey(name: 'last_message') ChatMessage? lastMessage,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'last_read_by') Map<String, DateTime>? lastReadBy,
  });

  @override
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
    _$ChatRoomImpl _value,
    $Res Function(_$ChatRoomImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? participants = null,
    Object? buyerId = null,
    Object? buyerName = null,
    Object? buyerUnreadCount = null,
    Object? sellerId = null,
    Object? sellerName = null,
    Object? sellerUnreadCount = null,
    Object? postId = null,
    Object? postTitle = null,
    Object? garageYardId = null,
    Object? garageYardTitle = freezed,
    Object? chatInitiatedByUsername = freezed,
    Object? lastMessage = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isActive = null,
    Object? unreadCount = null,
    Object? lastReadBy = freezed,
  }) {
    return _then(
      _$ChatRoomImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        participants:
            null == participants
                ? _value._participants
                : participants // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        buyerId:
            null == buyerId
                ? _value.buyerId
                : buyerId // ignore: cast_nullable_to_non_nullable
                    as String,
        buyerName:
            null == buyerName
                ? _value.buyerName
                : buyerName // ignore: cast_nullable_to_non_nullable
                    as String,
        buyerUnreadCount:
            null == buyerUnreadCount
                ? _value.buyerUnreadCount
                : buyerUnreadCount // ignore: cast_nullable_to_non_nullable
                    as int,
        sellerId:
            null == sellerId
                ? _value.sellerId
                : sellerId // ignore: cast_nullable_to_non_nullable
                    as String,
        sellerName:
            null == sellerName
                ? _value.sellerName
                : sellerName // ignore: cast_nullable_to_non_nullable
                    as String,
        sellerUnreadCount:
            null == sellerUnreadCount
                ? _value.sellerUnreadCount
                : sellerUnreadCount // ignore: cast_nullable_to_non_nullable
                    as int,
        postId:
            null == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                    as String,
        postTitle:
            null == postTitle
                ? _value.postTitle
                : postTitle // ignore: cast_nullable_to_non_nullable
                    as String,
        garageYardId:
            null == garageYardId
                ? _value.garageYardId
                : garageYardId // ignore: cast_nullable_to_non_nullable
                    as String,
        garageYardTitle:
            freezed == garageYardTitle
                ? _value.garageYardTitle
                : garageYardTitle // ignore: cast_nullable_to_non_nullable
                    as String?,
        chatInitiatedByUsername:
            freezed == chatInitiatedByUsername
                ? _value.chatInitiatedByUsername
                : chatInitiatedByUsername // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as ChatMessage?,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        unreadCount:
            null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                    as int,
        lastReadBy:
            freezed == lastReadBy
                ? _value._lastReadBy
                : lastReadBy // ignore: cast_nullable_to_non_nullable
                    as Map<String, DateTime>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomImpl with DiagnosticableTreeMixin implements _ChatRoom {
  const _$ChatRoomImpl({
    this.id,
    required final List<String> participants,
    @JsonKey(name: 'buyer_id') required this.buyerId,
    @JsonKey(name: 'buyer_name') required this.buyerName,
    @JsonKey(name: 'buyer_unread_count') this.buyerUnreadCount = 0,
    @JsonKey(name: 'seller_id') required this.sellerId,
    @JsonKey(name: 'seller_name') required this.sellerName,
    @JsonKey(name: 'seller_unread_count') this.sellerUnreadCount = 0,
    @JsonKey(name: 'post_id') required this.postId,
    @JsonKey(name: 'post_title') required this.postTitle,
    @JsonKey(name: 'garage_yard_id') required this.garageYardId,
    @JsonKey(name: 'garage_yard_title') this.garageYardTitle,
    @JsonKey(name: 'chat_initiated_by_username') this.chatInitiatedByUsername,
    @JsonKey(name: 'last_message') this.lastMessage,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
    @JsonKey(name: 'last_read_by') final Map<String, DateTime>? lastReadBy,
  }) : _participants = participants,
       _lastReadBy = lastReadBy;

  factory _$ChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomImplFromJson(json);

  @override
  final String? id;
  final List<String> _participants;
  @override
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  @JsonKey(name: 'buyer_id')
  final String buyerId;
  @override
  @JsonKey(name: 'buyer_name')
  final String buyerName;
  @override
  @JsonKey(name: 'buyer_unread_count')
  final int buyerUnreadCount;
  @override
  @JsonKey(name: 'seller_id')
  final String sellerId;
  @override
  @JsonKey(name: 'seller_name')
  final String sellerName;
  @override
  @JsonKey(name: 'seller_unread_count')
  final int sellerUnreadCount;
  @override
  @JsonKey(name: 'post_id')
  final String postId;
  @override
  @JsonKey(name: 'post_title')
  final String postTitle;
  @override
  @JsonKey(name: 'garage_yard_id')
  final String garageYardId;
  @override
  @JsonKey(name: 'garage_yard_title')
  final String? garageYardTitle;
  @override
  @JsonKey(name: 'chat_initiated_by_username')
  final String? chatInitiatedByUsername;
  @override
  @JsonKey(name: 'last_message')
  final ChatMessage? lastMessage;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  final Map<String, DateTime>? _lastReadBy;
  @override
  @JsonKey(name: 'last_read_by')
  Map<String, DateTime>? get lastReadBy {
    final value = _lastReadBy;
    if (value == null) return null;
    if (_lastReadBy is EqualUnmodifiableMapView) return _lastReadBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatRoom(id: $id, participants: $participants, buyerId: $buyerId, buyerName: $buyerName, buyerUnreadCount: $buyerUnreadCount, sellerId: $sellerId, sellerName: $sellerName, sellerUnreadCount: $sellerUnreadCount, postId: $postId, postTitle: $postTitle, garageYardId: $garageYardId, garageYardTitle: $garageYardTitle, chatInitiatedByUsername: $chatInitiatedByUsername, lastMessage: $lastMessage, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, unreadCount: $unreadCount, lastReadBy: $lastReadBy)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatRoom'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('participants', participants))
      ..add(DiagnosticsProperty('buyerId', buyerId))
      ..add(DiagnosticsProperty('buyerName', buyerName))
      ..add(DiagnosticsProperty('buyerUnreadCount', buyerUnreadCount))
      ..add(DiagnosticsProperty('sellerId', sellerId))
      ..add(DiagnosticsProperty('sellerName', sellerName))
      ..add(DiagnosticsProperty('sellerUnreadCount', sellerUnreadCount))
      ..add(DiagnosticsProperty('postId', postId))
      ..add(DiagnosticsProperty('postTitle', postTitle))
      ..add(DiagnosticsProperty('garageYardId', garageYardId))
      ..add(DiagnosticsProperty('garageYardTitle', garageYardTitle))
      ..add(
        DiagnosticsProperty('chatInitiatedByUsername', chatInitiatedByUsername),
      )
      ..add(DiagnosticsProperty('lastMessage', lastMessage))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('isActive', isActive))
      ..add(DiagnosticsProperty('unreadCount', unreadCount))
      ..add(DiagnosticsProperty('lastReadBy', lastReadBy));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            (identical(other.buyerId, buyerId) || other.buyerId == buyerId) &&
            (identical(other.buyerName, buyerName) ||
                other.buyerName == buyerName) &&
            (identical(other.buyerUnreadCount, buyerUnreadCount) ||
                other.buyerUnreadCount == buyerUnreadCount) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.sellerName, sellerName) ||
                other.sellerName == sellerName) &&
            (identical(other.sellerUnreadCount, sellerUnreadCount) ||
                other.sellerUnreadCount == sellerUnreadCount) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.postTitle, postTitle) ||
                other.postTitle == postTitle) &&
            (identical(other.garageYardId, garageYardId) ||
                other.garageYardId == garageYardId) &&
            (identical(other.garageYardTitle, garageYardTitle) ||
                other.garageYardTitle == garageYardTitle) &&
            (identical(
                  other.chatInitiatedByUsername,
                  chatInitiatedByUsername,
                ) ||
                other.chatInitiatedByUsername == chatInitiatedByUsername) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            const DeepCollectionEquality().equals(
              other._lastReadBy,
              _lastReadBy,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_participants),
    buyerId,
    buyerName,
    buyerUnreadCount,
    sellerId,
    sellerName,
    sellerUnreadCount,
    postId,
    postTitle,
    garageYardId,
    garageYardTitle,
    chatInitiatedByUsername,
    lastMessage,
    createdAt,
    updatedAt,
    isActive,
    unreadCount,
    const DeepCollectionEquality().hash(_lastReadBy),
  ]);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomImplToJson(this);
  }
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom({
    final String? id,
    required final List<String> participants,
    @JsonKey(name: 'buyer_id') required final String buyerId,
    @JsonKey(name: 'buyer_name') required final String buyerName,
    @JsonKey(name: 'buyer_unread_count') final int buyerUnreadCount,
    @JsonKey(name: 'seller_id') required final String sellerId,
    @JsonKey(name: 'seller_name') required final String sellerName,
    @JsonKey(name: 'seller_unread_count') final int sellerUnreadCount,
    @JsonKey(name: 'post_id') required final String postId,
    @JsonKey(name: 'post_title') required final String postTitle,
    @JsonKey(name: 'garage_yard_id') required final String garageYardId,
    @JsonKey(name: 'garage_yard_title') final String? garageYardTitle,
    @JsonKey(name: 'chat_initiated_by_username')
    final String? chatInitiatedByUsername,
    @JsonKey(name: 'last_message') final ChatMessage? lastMessage,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'unread_count') final int unreadCount,
    @JsonKey(name: 'last_read_by') final Map<String, DateTime>? lastReadBy,
  }) = _$ChatRoomImpl;

  factory _ChatRoom.fromJson(Map<String, dynamic> json) =
      _$ChatRoomImpl.fromJson;

  @override
  String? get id;
  @override
  List<String> get participants;
  @override
  @JsonKey(name: 'buyer_id')
  String get buyerId;
  @override
  @JsonKey(name: 'buyer_name')
  String get buyerName;
  @override
  @JsonKey(name: 'buyer_unread_count')
  int get buyerUnreadCount;
  @override
  @JsonKey(name: 'seller_id')
  String get sellerId;
  @override
  @JsonKey(name: 'seller_name')
  String get sellerName;
  @override
  @JsonKey(name: 'seller_unread_count')
  int get sellerUnreadCount;
  @override
  @JsonKey(name: 'post_id')
  String get postId;
  @override
  @JsonKey(name: 'post_title')
  String get postTitle;
  @override
  @JsonKey(name: 'garage_yard_id')
  String get garageYardId;
  @override
  @JsonKey(name: 'garage_yard_title')
  String? get garageYardTitle;
  @override
  @JsonKey(name: 'chat_initiated_by_username')
  String? get chatInitiatedByUsername;
  @override
  @JsonKey(name: 'last_message')
  ChatMessage? get lastMessage;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  @JsonKey(name: 'last_read_by')
  Map<String, DateTime>? get lastReadBy;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) {
  return _ChatUser.fromJson(json);
}

/// @nodoc
mixin _$ChatUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_online')
  bool get isOnline => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_seen')
  DateTime? get lastSeen => throw _privateConstructorUsedError;

  /// Serializes this ChatUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatUserCopyWith<ChatUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatUserCopyWith<$Res> {
  factory $ChatUserCopyWith(ChatUser value, $Res Function(ChatUser) then) =
      _$ChatUserCopyWithImpl<$Res, ChatUser>;
  @useResult
  $Res call({
    String id,
    String name,
    String? email,
    String? profileImage,
    @JsonKey(name: 'is_online') bool isOnline,
    @JsonKey(name: 'last_seen') DateTime? lastSeen,
  });
}

/// @nodoc
class _$ChatUserCopyWithImpl<$Res, $Val extends ChatUser>
    implements $ChatUserCopyWith<$Res> {
  _$ChatUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? profileImage = freezed,
    Object? isOnline = null,
    Object? lastSeen = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            profileImage:
                freezed == profileImage
                    ? _value.profileImage
                    : profileImage // ignore: cast_nullable_to_non_nullable
                        as String?,
            isOnline:
                null == isOnline
                    ? _value.isOnline
                    : isOnline // ignore: cast_nullable_to_non_nullable
                        as bool,
            lastSeen:
                freezed == lastSeen
                    ? _value.lastSeen
                    : lastSeen // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatUserImplCopyWith<$Res>
    implements $ChatUserCopyWith<$Res> {
  factory _$$ChatUserImplCopyWith(
    _$ChatUserImpl value,
    $Res Function(_$ChatUserImpl) then,
  ) = __$$ChatUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? email,
    String? profileImage,
    @JsonKey(name: 'is_online') bool isOnline,
    @JsonKey(name: 'last_seen') DateTime? lastSeen,
  });
}

/// @nodoc
class __$$ChatUserImplCopyWithImpl<$Res>
    extends _$ChatUserCopyWithImpl<$Res, _$ChatUserImpl>
    implements _$$ChatUserImplCopyWith<$Res> {
  __$$ChatUserImplCopyWithImpl(
    _$ChatUserImpl _value,
    $Res Function(_$ChatUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? profileImage = freezed,
    Object? isOnline = null,
    Object? lastSeen = freezed,
  }) {
    return _then(
      _$ChatUserImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        profileImage:
            freezed == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                    as String?,
        isOnline:
            null == isOnline
                ? _value.isOnline
                : isOnline // ignore: cast_nullable_to_non_nullable
                    as bool,
        lastSeen:
            freezed == lastSeen
                ? _value.lastSeen
                : lastSeen // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatUserImpl with DiagnosticableTreeMixin implements _ChatUser {
  const _$ChatUserImpl({
    required this.id,
    required this.name,
    this.email,
    this.profileImage,
    @JsonKey(name: 'is_online') this.isOnline = false,
    @JsonKey(name: 'last_seen') this.lastSeen,
  });

  factory _$ChatUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatUserImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? email;
  @override
  final String? profileImage;
  @override
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @override
  @JsonKey(name: 'last_seen')
  final DateTime? lastSeen;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatUser(id: $id, name: $name, email: $email, profileImage: $profileImage, isOnline: $isOnline, lastSeen: $lastSeen)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatUser'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('profileImage', profileImage))
      ..add(DiagnosticsProperty('isOnline', isOnline))
      ..add(DiagnosticsProperty('lastSeen', lastSeen));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    profileImage,
    isOnline,
    lastSeen,
  );

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatUserImplCopyWith<_$ChatUserImpl> get copyWith =>
      __$$ChatUserImplCopyWithImpl<_$ChatUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatUserImplToJson(this);
  }
}

abstract class _ChatUser implements ChatUser {
  const factory _ChatUser({
    required final String id,
    required final String name,
    final String? email,
    final String? profileImage,
    @JsonKey(name: 'is_online') final bool isOnline,
    @JsonKey(name: 'last_seen') final DateTime? lastSeen,
  }) = _$ChatUserImpl;

  factory _ChatUser.fromJson(Map<String, dynamic> json) =
      _$ChatUserImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get email;
  @override
  String? get profileImage;
  @override
  @JsonKey(name: 'is_online')
  bool get isOnline;
  @override
  @JsonKey(name: 'last_seen')
  DateTime? get lastSeen;

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatUserImplCopyWith<_$ChatUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatNotification _$ChatNotificationFromJson(Map<String, dynamic> json) {
  return _ChatNotification.fromJson(json);
}

/// @nodoc
mixin _$ChatNotification {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  String get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiver_id')
  String get receiverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'garage_yard_id')
  String get garageYardId => throw _privateConstructorUsedError;
  @JsonKey(name: 'garage_yard_title')
  String get garageYardTitle => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChatNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatNotificationCopyWith<ChatNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatNotificationCopyWith<$Res> {
  factory $ChatNotificationCopyWith(
    ChatNotification value,
    $Res Function(ChatNotification) then,
  ) = _$ChatNotificationCopyWithImpl<$Res, ChatNotification>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'sender_id') String senderId,
    @JsonKey(name: 'receiver_id') String receiverId,
    @JsonKey(name: 'garage_yard_id') String garageYardId,
    @JsonKey(name: 'garage_yard_title') String garageYardTitle,
    String message,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$ChatNotificationCopyWithImpl<$Res, $Val extends ChatNotification>
    implements $ChatNotificationCopyWith<$Res> {
  _$ChatNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? garageYardId = null,
    Object? garageYardTitle = null,
    Object? message = null,
    Object? isRead = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            senderId:
                null == senderId
                    ? _value.senderId
                    : senderId // ignore: cast_nullable_to_non_nullable
                        as String,
            receiverId:
                null == receiverId
                    ? _value.receiverId
                    : receiverId // ignore: cast_nullable_to_non_nullable
                        as String,
            garageYardId:
                null == garageYardId
                    ? _value.garageYardId
                    : garageYardId // ignore: cast_nullable_to_non_nullable
                        as String,
            garageYardTitle:
                null == garageYardTitle
                    ? _value.garageYardTitle
                    : garageYardTitle // ignore: cast_nullable_to_non_nullable
                        as String,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            isRead:
                null == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatNotificationImplCopyWith<$Res>
    implements $ChatNotificationCopyWith<$Res> {
  factory _$$ChatNotificationImplCopyWith(
    _$ChatNotificationImpl value,
    $Res Function(_$ChatNotificationImpl) then,
  ) = __$$ChatNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'sender_id') String senderId,
    @JsonKey(name: 'receiver_id') String receiverId,
    @JsonKey(name: 'garage_yard_id') String garageYardId,
    @JsonKey(name: 'garage_yard_title') String garageYardTitle,
    String message,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$ChatNotificationImplCopyWithImpl<$Res>
    extends _$ChatNotificationCopyWithImpl<$Res, _$ChatNotificationImpl>
    implements _$$ChatNotificationImplCopyWith<$Res> {
  __$$ChatNotificationImplCopyWithImpl(
    _$ChatNotificationImpl _value,
    $Res Function(_$ChatNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? garageYardId = null,
    Object? garageYardTitle = null,
    Object? message = null,
    Object? isRead = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ChatNotificationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        senderId:
            null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                    as String,
        receiverId:
            null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                    as String,
        garageYardId:
            null == garageYardId
                ? _value.garageYardId
                : garageYardId // ignore: cast_nullable_to_non_nullable
                    as String,
        garageYardTitle:
            null == garageYardTitle
                ? _value.garageYardTitle
                : garageYardTitle // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        isRead:
            null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatNotificationImpl
    with DiagnosticableTreeMixin
    implements _ChatNotification {
  const _$ChatNotificationImpl({
    required this.id,
    @JsonKey(name: 'sender_id') required this.senderId,
    @JsonKey(name: 'receiver_id') required this.receiverId,
    @JsonKey(name: 'garage_yard_id') required this.garageYardId,
    @JsonKey(name: 'garage_yard_title') required this.garageYardTitle,
    required this.message,
    @JsonKey(name: 'is_read') this.isRead = false,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$ChatNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatNotificationImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'sender_id')
  final String senderId;
  @override
  @JsonKey(name: 'receiver_id')
  final String receiverId;
  @override
  @JsonKey(name: 'garage_yard_id')
  final String garageYardId;
  @override
  @JsonKey(name: 'garage_yard_title')
  final String garageYardTitle;
  @override
  final String message;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatNotification(id: $id, senderId: $senderId, receiverId: $receiverId, garageYardId: $garageYardId, garageYardTitle: $garageYardTitle, message: $message, isRead: $isRead, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatNotification'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('senderId', senderId))
      ..add(DiagnosticsProperty('receiverId', receiverId))
      ..add(DiagnosticsProperty('garageYardId', garageYardId))
      ..add(DiagnosticsProperty('garageYardTitle', garageYardTitle))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('isRead', isRead))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.garageYardId, garageYardId) ||
                other.garageYardId == garageYardId) &&
            (identical(other.garageYardTitle, garageYardTitle) ||
                other.garageYardTitle == garageYardTitle) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    receiverId,
    garageYardId,
    garageYardTitle,
    message,
    isRead,
    createdAt,
  );

  /// Create a copy of ChatNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatNotificationImplCopyWith<_$ChatNotificationImpl> get copyWith =>
      __$$ChatNotificationImplCopyWithImpl<_$ChatNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatNotificationImplToJson(this);
  }
}

abstract class _ChatNotification implements ChatNotification {
  const factory _ChatNotification({
    required final String id,
    @JsonKey(name: 'sender_id') required final String senderId,
    @JsonKey(name: 'receiver_id') required final String receiverId,
    @JsonKey(name: 'garage_yard_id') required final String garageYardId,
    @JsonKey(name: 'garage_yard_title') required final String garageYardTitle,
    required final String message,
    @JsonKey(name: 'is_read') final bool isRead,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$ChatNotificationImpl;

  factory _ChatNotification.fromJson(Map<String, dynamic> json) =
      _$ChatNotificationImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'sender_id')
  String get senderId;
  @override
  @JsonKey(name: 'receiver_id')
  String get receiverId;
  @override
  @JsonKey(name: 'garage_yard_id')
  String get garageYardId;
  @override
  @JsonKey(name: 'garage_yard_title')
  String get garageYardTitle;
  @override
  String get message;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of ChatNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatNotificationImplCopyWith<_$ChatNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
