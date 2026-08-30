# 🔔 FCM Push Notifications Setup Guide

## ✅ **Flutter Side - COMPLETED**

The Flutter implementation is ready! Here's what I've created:

### **Files Created:**
- `lib/services/fcm_notification_service.dart` - FCM service
- `lib/features/debug/fcm_test_widget.dart` - Test widget
- `functions/index.js` - Cloud Function template
- `functions/package.json` - Dependencies

### **Files Modified:**
- `lib/main.dart` - Added FCM initialization
- `lib/services/chat_service/presentation/providers/chat_state_provider.dart` - Cleaned up

## 🚀 **Firebase Console Setup (YOU NEED TO DO THIS)**

### **1. Create Cloud Function in Firebase Console:**

Go to Firebase Console → Functions → Create Function

**Function Code:**
```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendChatNotification = functions.firestore
  .document('chat_rooms/{chatRoomId}/messages/{messageId}')
  .onCreate(async (snap, context) => {
    try {
      const message = snap.data();
      const chatRoomId = context.params.chatRoomId;
      
      console.log('New message created:', message);
      
      // Get chat room details
      const chatRoomDoc = await admin.firestore()
        .collection('chat_rooms')
        .doc(chatRoomId)
        .get();
      
      if (!chatRoomDoc.exists) {
        console.log('Chat room not found');
        return null;
      }
      
      const chatRoom = chatRoomDoc.data();
      const participants = chatRoom.participants || [];
      
      // Find the receiver (not the sender)
      const receiverId = participants.find(id => id !== message.senderId);
      
      if (!receiverId) {
        console.log('No receiver found');
        return null;
      }
      
      // Get receiver's FCM token
      const receiverDoc = await admin.firestore()
        .collection('users')
        .doc(receiverId)
        .get();
      
      if (!receiverDoc.exists) {
        console.log('Receiver user not found');
        return null;
      }
      
      const receiverData = receiverDoc.data();
      const fcmToken = receiverData.fcm_token;
      
      if (!fcmToken) {
        console.log('No FCM token for receiver');
        return null;
      }
      
      // Get sender's name
      const senderDoc = await admin.firestore()
        .collection('users')
        .doc(message.senderId)
        .get();
      
      const senderName = senderDoc.exists ? senderDoc.data().name || 'User' : 'User';
      
      // Prepare notification payload
      const payload = {
        notification: {
          title: `New message from ${senderName}`,
          body: message.text,
          icon: 'ic_launcher',
          sound: 'default',
        },
        data: {
          type: 'chat_message',
          chat_room_id: chatRoomId,
          sender_id: message.senderId,
          receiver_id: receiverId,
          message_text: message.text,
          sender_name: senderName,
        },
        token: fcmToken,
      };
      
      // Send FCM notification
      const response = await admin.messaging().send(payload);
      console.log('Successfully sent message:', response);
      
      return null;
    } catch (error) {
      console.error('Error sending notification:', error);
      return null;
    }
  });
```

### **2. Add FCM Test Widget to Your App:**

Add this to any screen (like dashboard):

```dart
import 'package:findcarsale/features/debug/fcm_test_widget.dart';

// Add this widget
const FCMTestWidget(),
```

### **3. Test the Setup:**

1. **Run the app on a physical device**
2. **Log in to your account**
3. **Add the FCM test widget to your dashboard**
4. **Click "Get FCM Token" to get your token**
5. **Check console logs for the token**
6. **Send a message in chat**
7. **Close the app completely**
8. **Send another message from a different device**
9. **Check if notification appears on the closed app**

## 📱 **Expected Results:**

### **When App is Open:**
- ✅ FCM token is generated and stored
- ✅ Console logs show token
- ✅ Messages are sent normally

### **When App is Closed/Background:**
- ✅ Cloud Function triggers when message is sent
- ✅ FCM notification is sent to receiver's device
- ✅ Notification appears on device
- ✅ Tapping notification opens the app

## 🔍 **Debug Steps:**

1. **Check Firebase Console → Functions → Logs** for Cloud Function logs
2. **Check Firebase Console → Firestore** for FCM tokens in users collection
3. **Check device console logs** for FCM token and message handling
4. **Test with two different devices** logged in as different users

## 🚨 **Common Issues:**

1. **No FCM token** - Check if user is logged in and FCM permissions are granted
2. **Cloud Function not triggering** - Check Firestore rules and function deployment
3. **Notifications not appearing** - Check device notification settings and FCM token storage

**The Flutter side is ready! Just add the Cloud Function in Firebase Console and test it.** 🚀

