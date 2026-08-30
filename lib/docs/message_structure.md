# Message Structure Documentation

## Overview

The chat message structure has been updated to include comprehensive information about the message, sender, receiver, and delivery status. This document outlines the new structure and how to use it.

## New Message Fields

The `ChatMessage` model now includes the following fields:

### Core Message Information
- `chatRoomId` (String, required): Unique identifier for the chat room
- `text` (String, required): The message content
- `timestamp` (DateTime, required): When the message was sent
- `messageType` (MessageType, default: text): Type of message (text, image, file, system)

### Sender/Receiver Information
- `senderId` (String, required): Unique identifier for the sender
- `receiverId` (String, required): Unique identifier for the receiver
- `garageYardId` (String, required): Associated garage/yard ID

### Delivery Status
- `isRead` (bool, default: false): Whether the message has been read
- `isDelivered` (bool, default: false): Whether the message has been delivered
- `isDeleted` (bool, default: false): Whether the message has been deleted

### Media Information
- `imageUrl` (String?, optional): URL for image messages
- `fileUrl` (String?, optional): URL for file messages
- `replyTo` (String?, optional): ID of message being replied to

### Metadata
- `id` (String?, optional): Unique identifier for the message
- `createdAt` (DateTime, required): When the message was created
- `updatedAt` (DateTime?, optional): When the message was last updated

## Example Message Structure

Based on your requirements, a message will now contain the following structure:

```json
{
  "id": "message_id",
  "chat_room_id": "BRXSpnKjPklVIvjJpzVa",
  "sender_id": "4",
  "receiver_id": "12",
  "garage_yard_id": "garage_yard_123",
  "text": "hello",
  "message_type": "text",
  "created_at": "October 11, 2025 at 12:49:24 AM UTC+5:45",
  "timestamp": "October 11, 2025 at 12:49:24 AM UTC+5:45",
  "is_read": false,
  "is_delivered": false,
  "is_deleted": false,
  "image_url": null,
  "file_url": null,
  "reply_to": null
}
```

## Usage

### Sending a Text Message

```dart
final chatService = ref.read(chatServiceProvider);

final success = await chatService.sendMessage(
  chatRoomId: "BRXSpnKjPklVIvjJpzVa",
  senderId: "4",
  receiverId: "12",
  garageYardId: "garage_yard_123",
  text: "hello",
  messageType: MessageType.text,
);
```

### Sending an Image Message

```dart
final success = await chatService.sendMessage(
  chatRoomId: "BRXSpnKjPklVIvjJpzVa",
  senderId: "4",
  receiverId: "12",
  garageYardId: "garage_yard_123",
  text: "Check out this image!",
  messageType: MessageType.image,
  imageUrl: "https://example.com/image.jpg",
);
```

### Sending a File Message

```dart
final success = await chatService.sendMessage(
  chatRoomId: "BRXSpnKjPklVIvjJpzVa",
  senderId: "4",
  receiverId: "12",
  garageYardId: "garage_yard_123",
  text: "Here's the document you requested",
  messageType: MessageType.file,
  fileUrl: "https://example.com/document.pdf",
);
```

### Accessing Message Data

```dart
// Access message information
print('Message: ${message.text}');
print('From: ${message.senderId}');
print('To: ${message.receiverId}');
print('Room: ${message.chatRoomId}');
print('Sent: ${message.timestamp}');
print('Type: ${message.messageType}');

// Check delivery status
print('Read: ${message.isRead}');
print('Delivered: ${message.isDelivered}');

// Access media
if (message.imageUrl != null) {
  print('Image: ${message.imageUrl}');
}
if (message.fileUrl != null) {
  print('File: ${message.fileUrl}');
}
```

## Migration Notes

### Breaking Changes
- The `sendMessage` method now requires a `chatRoomId` parameter
- The `message` parameter has been renamed to `text`
- New required fields: `chatRoomId`, `timestamp`
- New optional fields: `isDelivered`, `imageUrl`, `fileUrl`

### Backward Compatibility
- All existing fields remain unchanged
- New fields have sensible defaults where appropriate
- Existing messages will continue to work, but new ones will have the enhanced structure

## Database Schema

The Firestore document structure will include these fields:

```javascript
// Firestore document structure
{
  chat_room_id: "BRXSpnKjPklVIvjJpzVa",
  sender_id: "4",
  receiver_id: "12",
  garage_yard_id: "garage_yard_123",
  text: "hello",
  message_type: "text",
  created_at: "2025-10-11T12:49:24.000Z",
  timestamp: "2025-10-11T12:49:24.000Z",
  is_read: false,
  is_delivered: false,
  is_deleted: false,
  image_url: null,
  file_url: null,
  reply_to: null
}
```

## Message Types

The system supports the following message types:

- `text`: Plain text messages
- `image`: Messages with images
- `file`: Messages with file attachments
- `system`: System-generated messages

## Benefits

1. **Enhanced Tracking**: Track message delivery and read status
2. **Media Support**: Support for images and files
3. **Better Organization**: Clear separation of message metadata
4. **Improved UX**: Users can see delivery status
5. **Scalability**: Structure supports future enhancements like reactions, replies, etc.

## Real-time Updates

Messages support real-time updates through Firestore streams:

```dart
// Listen to messages in a chat room
Stream<List<ChatMessage>> messagesStream = 
    chatRepository.getChatMessagesStream(chatRoomId);

// Listen to specific message updates
Stream<ChatMessage> messageStream = 
    chatRepository.getMessageStream(messageId);
```

## Testing

See `lib/examples/message_creation_example.dart` for a complete example of how to create and use the new message structure.
