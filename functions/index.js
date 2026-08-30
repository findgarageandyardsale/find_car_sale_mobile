const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

// Cloud Function to send push notification when a chat message is created - COMMENTED OUT TO DISABLE NOTIFICATIONS
/*
exports.sendChatNotification = functions.firestore
    .document('chat_rooms/{chatRoomId}/messages/{messageId}')
    .onCreate(async (snap, context) => {
        try {
            console.log('🔔 FCM: Function triggered for message:', context.params.messageId);

            const message = snap.data();
            const chatRoomId = context.params.chatRoomId;

            // Validate required fields
            if (!message || !chatRoomId || !message.sender_id) {
                console.log('🔔 FCM: ❌ Missing required fields');
                console.log('🔔 FCM: Message exists:', !!message);
                console.log('🔔 FCM: ChatRoomId exists:', !!chatRoomId);
                console.log('🔔 FCM: SenderId exists:', !!message?.sender_id);
                console.log('🔔 FCM: Message data:', message);
                return null;
            }

            // Get chat room details
            const chatRoomDoc = await admin.firestore()
                .collection('chat_rooms')
                .doc(chatRoomId)
                .get();

            if (!chatRoomDoc.exists) {
                console.log('🔔 FCM: ❌ Chat room not found');
                return null;
            }

            const chatRoom = chatRoomDoc.data();
            const participants = chatRoom.participants || [];

            // Find the receiver (not the sender)
            const receiverId = participants.find(id => id !== message.sender_id);

            if (!receiverId) {
                console.log('🔔 FCM: ❌ No receiver found');
                return null;
            }

            // Get receiver's FCM token
            if (!receiverId || typeof receiverId !== 'string' || receiverId.trim() === '') {
                console.log('🔔 FCM: ❌ Invalid receiver ID');
                return null;
            }

            const receiverDoc = await admin.firestore()
                .collection('users')
                .doc(receiverId.trim())
                .get();

            if (!receiverDoc.exists) {
                console.log('🔔 FCM: ❌ Receiver user not found');
                return null;
            }

            const receiverData = receiverDoc.data();
            const fcmToken = receiverData.fcm_token;

            if (!fcmToken) {
                console.log('🔔 FCM: ❌ No FCM token found for receiver');
                return null;
            }

            // Get sender's name
            let senderName = 'User';

            const senderId = message.sender_id;
            if (senderId && typeof senderId === 'string' && senderId.trim() !== '') {
                try {
                    const senderDoc = await admin.firestore()
                        .collection('users')
                        .doc(senderId.trim())
                        .get();

                    if (senderDoc.exists) {
                        const senderData = senderDoc.data();
                        senderName = senderData.name || (senderData.firstName && senderData.lastName ? `${senderData.firstName} ${senderData.lastName}` : 'User');
                    }
                } catch (error) {
                    console.log('🔔 FCM: ❌ Error getting sender name:', error.message);
                    senderName = 'User';
                }
            }

            // Prepare notification payload with strict validation
            const cleanTitle = `New message from ${senderName}`.substring(0, 100);
            const cleanBody = (message.text || 'New message').substring(0, 200);

            // Ensure all data fields are valid strings and not too long
            const cleanChatRoomId = String(chatRoomId || '').substring(0, 50);
            const cleanSenderId = String(message.sender_id || '').substring(0, 50);
            const cleanReceiverId = String(receiverId || '').substring(0, 50);
            const cleanMessageText = String(message.text || '').substring(0, 100);
            const cleanSenderName = String(senderName || 'User').substring(0, 50);

            const payload = {
                notification: {
                    title: cleanTitle,
                    body: cleanBody,
                },
                data: {
                    type: 'chat_message',
                    chat_room_id: cleanChatRoomId,
                    sender_id: cleanSenderId,
                    receiver_id: cleanReceiverId,
                    message_text: cleanMessageText,
                    sender_name: cleanSenderName,
                },
                token: fcmToken,
            };

            // Final validation before sending
            if (!payload.token || !payload.notification.title || !payload.notification.body) {
                console.log('🔔 FCM: ❌ Invalid payload - missing required fields');
                return null;
            }

            // Validate FCM token format
            if (typeof payload.token !== 'string' || payload.token.length < 10) {
                console.log('🔔 FCM: ❌ Invalid FCM token format');
                return null;
            }

            // Send FCM notification
            try {
                const response = await admin.messaging().send(payload);
                console.log('🔔 FCM: ✅ Notification sent successfully');
                return null;
            } catch (fcmError) {
                console.error('🔔 FCM: ❌ Error sending notification:', fcmError.message);
                return null;
            }

        } catch (error) {
            console.error('🔔 FCM: ❌ Function error:', error.message);
            return null;
        }
    });
*/

// NOTIFICATION FUNCTION DISABLED - All notification triggers have been commented out
console.log('🔔 FCM: Notification function disabled - no notifications will be sent');