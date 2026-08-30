# Chat Room Structure Documentation

## Overview

The chat room structure has been updated to include comprehensive information about buyers, sellers, and posts. This document outlines the new structure and how to use it.

## New Chat Room Fields

The `ChatRoom` model now includes the following additional fields:

### Buyer Information
- `buyerId` (String, required): Unique identifier for the buyer
- `buyerName` (String, required): Display name of the buyer
- `buyerUnreadCount` (int, default: 0): Number of unread messages for the buyer

### Seller Information
- `sellerId` (String, required): Unique identifier for the seller
- `sellerName` (String, required): Display name of the seller
- `sellerUnreadCount` (int, default: 0): Number of unread messages for the seller

### Post Information
- `postId` (String, required): Unique identifier for the post/listing
- `postTitle` (String, required): Title of the post/listing

## Example Chat Room Structure

Based on your requirements, a chat room will now contain the following structure:

```json
{
  "id": "chat_room_id",
  "participants": ["12", "4"],
  "buyerId": "4",
  "buyerName": "Susan Timilsina",
  "buyerUnreadCount": 1,
  "sellerId": "12",
  "sellerName": "Susan Timtim",
  "sellerUnreadCount": 0,
  "postId": "14",
  "postTitle": "Luxury Car",
  "garageYardId": "garage_yard_123",
  "garageYardTitle": "Premium Auto Garage",
  "chatInitiatedByUsername": "Susan Timilsina",
  "lastMessage": {
    "senderId": "4",
    "text": "hello",
    "timestamp": "October 11, 2025 at 12:49:24 AM UTC+5:45",
    "type": "text"
  },
  "createdAt": "October 11, 2025 at 12:49:18 AM UTC+5:45",
  "updatedAt": "October 11, 2025 at 12:49:24 AM UTC+5:45",
  "isActive": true,
  "unreadCount": 0
}
```

## Usage

### Creating a Chat Room

```dart
final chatService = ref.read(chatServiceProvider);

final chatRoom = await chatService.createOrGetChatRoom(
  garageYardId: "garage_yard_123",
  sellerId: "12",
  buyerId: "4",
  sellerName: "Susan Timtim",
  buyerName: "Susan Timilsina",
  postId: "14",
  postTitle: "Luxury Car",
  garageYardTitle: "Premium Auto Garage", // Optional
  chatInitiatedByUsername: "Susan Timilsina", // Optional
);
```

### Accessing Chat Room Data

```dart
// Access buyer information
print('Buyer: ${chatRoom.buyerName} (ID: ${chatRoom.buyerId})');
print('Buyer unread count: ${chatRoom.buyerUnreadCount}');

// Access seller information
print('Seller: ${chatRoom.sellerName} (ID: ${chatRoom.sellerId})');
print('Seller unread count: ${chatRoom.sellerUnreadCount}');

// Access post information
print('Post: ${chatRoom.postTitle} (ID: ${chatRoom.postId})');

// Access participants
print('Participants: ${chatRoom.participants}');
```

## Migration Notes

### Breaking Changes
- The `createChatRoom` method now requires additional parameters:
  - `sellerName` (required)
  - `buyerName` (required)
  - `postId` (required)
  - `postTitle` (required)

### Backward Compatibility
- All existing fields remain unchanged
- New fields have sensible defaults where appropriate
- Existing chat rooms will continue to work, but new ones will have the enhanced structure

## Database Schema

The Firestore document structure will include these new fields:

```javascript
// Firestore document structure
{
  participants: ["12", "4"],
  buyer_id: "4",
  buyer_name: "Susan Timilsina",
  buyer_unread_count: 1,
  seller_id: "12",
  seller_name: "Susan Timtim",
  seller_unread_count: 0,
  post_id: "14",
  post_title: "Luxury Car",
  garage_yard_id: "garage_yard_123",
  garage_yard_title: "Premium Auto Garage",
  chat_initiated_by_username: "Susan Timilsina",
  last_message: { /* message object */ },
  created_at: "2025-10-11T12:49:18.000Z",
  updated_at: "2025-10-11T12:49:24.000Z",
  is_active: true,
  unread_count: 0,
  last_read_by: {}
}
```

## Benefits

1. **Enhanced User Experience**: Users can see buyer/seller names and post information directly in the chat room
2. **Better Organization**: Clear separation of buyer and seller information
3. **Improved Analytics**: Track unread counts per user type
4. **Post Context**: Users can see what post they're discussing
5. **Scalability**: Structure supports future enhancements

## Testing

See `lib/examples/chat_room_creation_example.dart` for a complete example of how to create and use the new chat room structure.
