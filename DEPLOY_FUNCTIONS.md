# 🚀 Deploy Firebase Cloud Functions

## 📋 **Prerequisites**

Make sure you have:
- ✅ Firebase CLI installed
- ✅ Node.js installed
- ✅ Firebase project set up

## 🔧 **Step 1: Install Firebase CLI (if not installed)**

```bash
npm install -g firebase-tools
```

## 🔧 **Step 2: Login to Firebase**

```bash
firebase login
```

## 🔧 **Step 3: Install Functions Dependencies**

```bash
cd functions
npm install
cd ..
```

## 🚀 **Step 4: Deploy Functions**

```bash
firebase deploy --only functions
```

## 📱 **Step 5: Test the Setup**

1. **Add the test widget to your app:**
   ```dart
   import 'package:findcarsale/features/debug/fcm_test_widget.dart';
   
   // Add this widget to any screen (like dashboard)
   const FCMTestWidget(),
   ```

2. **Run the app on a physical device**
3. **Log in to your account**
4. **Click "Get FCM Token"** in the test widget
5. **Check console logs** for the FCM token
6. **Send a message in chat**
7. **Close the app completely**
8. **Send another message from a different device**
9. **Check if notification appears**

## 🔍 **Check Deployment Status**

```bash
firebase functions:log
```

## 📊 **Expected Results**

### **Console Logs (Flutter App):**
```
🔔 FCM: FCM Token: [your-token]
🔔 FCM: Token stored for user: [user-id]
```

### **Console Logs (Firebase Function):**
```
🔔 FCM: New message created: [message-data]
🔔 FCM: Receiver ID: [receiver-id]
🔔 FCM: FCM token found for receiver
🔔 FCM: Sender name: [sender-name]
🔔 FCM: Successfully sent notification: [response]
```

### **Device Notification:**
- ✅ **Notification appears** when app is closed
- ✅ **Title**: "New message from [sender name]"
- ✅ **Body**: The actual message text
- ✅ **Tapping opens the app**

## 🚨 **Troubleshooting**

1. **Deployment fails**: Check if you're logged in to Firebase
2. **Function not triggering**: Check Firestore rules
3. **No FCM token**: Check if user is logged in
4. **Notifications not appearing**: Check device notification settings

## 🔄 **Update Functions (if needed)**

```bash
firebase deploy --only functions
```

**That's it! Your Cloud Functions are now deployed and ready to send push notifications.** 🎉

