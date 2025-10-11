import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final fcmNotificationServiceProvider = Provider<FCMNotificationService>((ref) {
  return FCMNotificationService(ref);
});

class FCMNotificationService {
  final Ref _ref;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  FCMNotificationService(this._ref) {
    _initializeFCM();
  }

  /// Initialize FCM and set up message handlers
  Future<void> _initializeFCM() async {
    try {
      PrintUtils.customLog('🔔 FCM: ===== INITIALIZING FCM SERVICE =====');
      PrintUtils.customLog('🔔 FCM: Step 1: Initializing FCM service...');

      // Initialize local notifications
      PrintUtils.customLog(
        '🔔 FCM: Step 2: Initializing local notifications...',
      );
      await _initializeLocalNotifications();

      // Request permission for notifications
      PrintUtils.customLog(
        '🔔 FCM: Step 3: Requesting notification permissions...',
      );
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      PrintUtils.customLog(
        '🔔 FCM: Permission status: ${settings.authorizationStatus}',
      );
      PrintUtils.customLog('🔔 FCM: Alert permission: ${settings.alert}');
      PrintUtils.customLog('🔔 FCM: Badge permission: ${settings.badge}');
      PrintUtils.customLog('🔔 FCM: Sound permission: ${settings.sound}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        PrintUtils.customLog('🔔 FCM: Step 4: Getting FCM token...');
        // Get FCM token
        final token = await _messaging.getToken();
        PrintUtils.customLog('🔔 FCM: FCM Token: $token');

        if (token != null) {
          PrintUtils.customLog(
            '🔔 FCM: Step 5: Storing FCM token in Firestore...',
          );
          await _storeFCMToken(token);
        } else {
          PrintUtils.customLog('🔔 FCM: ❌ FCM Token is null!');
        }

        PrintUtils.customLog('🔔 FCM: Step 6: Setting up message handlers...');
        // Set up message handlers
        _setupMessageHandlers();

        PrintUtils.customLog(
          '🔔 FCM: Step 7: Setting up token refresh listener...',
        );
        // Listen for token refresh
        _listenForTokenRefresh();

        PrintUtils.customLog(
          '🔔 FCM: ===== FCM SERVICE INITIALIZED SUCCESSFULLY =====',
        );
      } else {
        PrintUtils.customLog('🔔 FCM: ❌ Notification permission not granted!');
        PrintUtils.customLog(
          '🔔 FCM: Authorization status: ${settings.authorizationStatus}',
        );
      }
    } catch (e) {
      PrintUtils.customLog('🔔 FCM: ❌ Error initializing FCM: $e');
      PrintUtils.customLog('🔔 FCM: Error type: ${e.runtimeType}');
      PrintUtils.customLog('🔔 FCM: Stack trace: ${StackTrace.current}');
    }
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    try {
      PrintUtils.customLog('🔔 FCM: Initializing local notifications...');
      const androidSettings = AndroidInitializationSettings('ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );
      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      PrintUtils.customLog(
        '🔔 FCM: Calling _localNotifications.initialize()...',
      );
      await _localNotifications.initialize(initSettings);
      PrintUtils.customLog(
        '🔔 FCM: ✅ Local notifications initialized successfully',
      );
    } catch (e) {
      PrintUtils.customLog(
        '🔔 FCM: ❌ Error initializing local notifications: $e',
      );
      PrintUtils.customLog('🔔 FCM: Error type: ${e.runtimeType}');
      PrintUtils.customLog('🔔 FCM: Stack trace: ${StackTrace.current}');
    }
  }

  /// Store FCM token in Firestore for the current user
  Future<void> _storeFCMToken(String token) async {
    try {
      PrintUtils.customLog('🔔 FCM: Storing FCM token in Firestore...');
      PrintUtils.customLog('🔔 FCM: Token to store: $token');

      final currentUserAsync = _ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null) {
          PrintUtils.customLog('🔔 FCM: Current user found: ${user.userId}');
          PrintUtils.customLog(
            '🔔 FCM: Storing token for user: ${user.userId}',
          );

          await _firestore.collection('users').doc(user.userId.toString()).set({
            'fcm_token': token,
            'updated_at': DateTime.now().toIso8601String(),
          }, SetOptions(merge: true));

          PrintUtils.customLog(
            '🔔 FCM: ✅ Token stored successfully for user: ${user.userId}',
          );
        } else {
          PrintUtils.customLog('🔔 FCM: ❌ No current user found!');
        }
      });
    } catch (e) {
      PrintUtils.customLog('🔔 FCM: ❌ Error storing FCM token: $e');
      PrintUtils.customLog('🔔 FCM: Error type: ${e.runtimeType}');
      PrintUtils.customLog('🔔 FCM: Stack trace: ${StackTrace.current}');
    }
  }

  /// Set up message handlers for different app states
  void _setupMessageHandlers() {
    PrintUtils.customLog('🔔 FCM: Setting up message handlers...');

    // Handle messages when app is in foreground
    PrintUtils.customLog('🔔 FCM: Setting up foreground message listener...');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PrintUtils.customLog('🔔 FCM: ===== FOREGROUND MESSAGE RECEIVED =====');
      PrintUtils.customLog('🔔 FCM: Message ID: ${message.messageId}');
      PrintUtils.customLog('🔔 FCM: Title: ${message.notification?.title}');
      PrintUtils.customLog('🔔 FCM: Body: ${message.notification?.body}');
      PrintUtils.customLog('🔔 FCM: Data: ${message.data}');
      PrintUtils.customLog('🔔 FCM: From: ${message.from}');
      PrintUtils.customLog('🔔 FCM: TTL: ${message.ttl}');
      PrintUtils.customLog('🔔 FCM: Sent time: ${message.sentTime}');
      PrintUtils.customLog('🔔 FCM: Collapse key: ${message.collapseKey}');
      PrintUtils.customLog('🔔 FCM: Message type: ${message.messageType}');

      // Handle the notification (show local notification, update UI, etc.)
      _handleForegroundMessage(message);
    });

    // Handle messages when app is in background
    PrintUtils.customLog('🔔 FCM: Setting up background message listener...');
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PrintUtils.customLog('🔔 FCM: ===== BACKGROUND MESSAGE RECEIVED =====');
      PrintUtils.customLog(
        '🔔 FCM: App opened from background message: ${message.messageId}',
      );
      PrintUtils.customLog('🔔 FCM: Title: ${message.notification?.title}');
      PrintUtils.customLog('🔔 FCM: Body: ${message.notification?.body}');
      PrintUtils.customLog('🔔 FCM: Data: ${message.data}');
      _handleBackgroundMessage(message);
    });

    // Handle messages when app is terminated
    PrintUtils.customLog('🔔 FCM: Setting up terminated message listener...');
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        PrintUtils.customLog('🔔 FCM: ===== TERMINATED MESSAGE RECEIVED =====');
        PrintUtils.customLog(
          '🔔 FCM: App opened from terminated state: ${message.messageId}',
        );
        PrintUtils.customLog('🔔 FCM: Title: ${message.notification?.title}');
        PrintUtils.customLog('🔔 FCM: Body: ${message.notification?.body}');
        PrintUtils.customLog('🔔 FCM: Data: ${message.data}');
        _handleTerminatedMessage(message);
      } else {
        PrintUtils.customLog('🔔 FCM: No terminated message found');
      }
    });

    PrintUtils.customLog('🔔 FCM: ✅ Message handlers set up successfully');
  }

  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    PrintUtils.customLog('🔔 FCM: ===== HANDLING FOREGROUND MESSAGE =====');
    PrintUtils.customLog('🔔 FCM: Processing foreground message...');

    // Show local notification for foreground messages
    PrintUtils.customLog(
      '🔔 FCM: Showing local notification for foreground message...',
    );
    _showLocalNotification(
      title: message.notification?.title ?? 'New Message',
      body: message.notification?.body ?? 'You have a new message',
      data: message.data,
    );
  }

  /// Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    try {
      PrintUtils.customLog('🔔 FCM: ===== SHOWING LOCAL NOTIFICATION =====');
      PrintUtils.customLog('🔔 FCM: Title: $title');
      PrintUtils.customLog('🔔 FCM: Body: $body');
      PrintUtils.customLog('🔔 FCM: Data: $data');

      const androidDetails = AndroidNotificationDetails(
        'chat_messages',
        'Chat Messages',
        channelDescription: 'Notifications for chat messages',
        priority: Priority.high,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher',
      );
      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final notificationId = DateTime.now().millisecondsSinceEpoch.remainder(
        100000,
      );
      PrintUtils.customLog('🔔 FCM: Notification ID: $notificationId');
      PrintUtils.customLog('🔔 FCM: Calling _localNotifications.show()...');

      await _localNotifications.show(
        notificationId,
        title,
        body,
        notificationDetails,
        payload: data.toString(),
      );

      PrintUtils.customLog('🔔 FCM: ✅ Local notification shown successfully!');
      PrintUtils.customLog(
        '🔔 FCM: Notification details - ID: $notificationId, Title: "$title", Body: "$body"',
      );
    } catch (e) {
      PrintUtils.customLog('🔔 FCM: ❌ Error showing local notification: $e');
      PrintUtils.customLog('🔔 FCM: Error type: ${e.runtimeType}');
      PrintUtils.customLog('🔔 FCM: Stack trace: ${StackTrace.current}');
    }
  }

  /// Handle background messages
  void _handleBackgroundMessage(RemoteMessage message) {
    PrintUtils.customLog('🔔 FCM: ===== HANDLING BACKGROUND MESSAGE =====');
    PrintUtils.customLog('🔔 FCM: Processing background message...');
    PrintUtils.customLog('🔔 FCM: Message data: ${message.data}');

    // Navigate to the appropriate screen
    // For chat messages, navigate to the chat screen
    if (message.data['type'] == 'chat_message') {
      final chatRoomId = message.data['chat_room_id'];
      final senderId = message.data['sender_id'];

      PrintUtils.customLog('🔔 FCM: Chat message detected');
      PrintUtils.customLog('🔔 FCM: Chat room ID: $chatRoomId');
      PrintUtils.customLog('🔔 FCM: Sender ID: $senderId');
      PrintUtils.customLog('🔔 FCM: TODO: Navigate to chat room: $chatRoomId');
      // TODO: Implement navigation to chat screen
    } else {
      PrintUtils.customLog(
        '🔔 FCM: Non-chat message type: ${message.data['type']}',
      );
    }
  }

  /// Handle terminated app messages
  void _handleTerminatedMessage(RemoteMessage message) {
    PrintUtils.customLog('🔔 FCM: ===== HANDLING TERMINATED MESSAGE =====');
    PrintUtils.customLog('🔔 FCM: Processing terminated message...');
    PrintUtils.customLog('🔔 FCM: Message data: ${message.data}');

    // Similar to background message handling
    if (message.data['type'] == 'chat_message') {
      final chatRoomId = message.data['chat_room_id'];
      final senderId = message.data['sender_id'];

      PrintUtils.customLog('🔔 FCM: Chat message detected');
      PrintUtils.customLog('🔔 FCM: Chat room ID: $chatRoomId');
      PrintUtils.customLog('🔔 FCM: Sender ID: $senderId');
      PrintUtils.customLog('🔔 FCM: TODO: Navigate to chat room: $chatRoomId');
      // TODO: Implement navigation to chat screen
    } else {
      PrintUtils.customLog(
        '🔔 FCM: Non-chat message type: ${message.data['type']}',
      );
    }
  }

  /// Update FCM token when it refreshes
  void _listenForTokenRefresh() {
    PrintUtils.customLog('🔔 FCM: Setting up token refresh listener...');
    _messaging.onTokenRefresh.listen((newToken) {
      PrintUtils.customLog('🔔 FCM: ===== TOKEN REFRESHED =====');
      PrintUtils.customLog('🔔 FCM: New token: $newToken');
      PrintUtils.customLog('🔔 FCM: Storing refreshed token...');
      _storeFCMToken(newToken);
    });
    PrintUtils.customLog('🔔 FCM: ✅ Token refresh listener set up');
  }

  /// Get current FCM token
  Future<String?> getCurrentToken() async {
    try {
      PrintUtils.customLog('🔔 FCM: Getting current FCM token...');
      final token = await _messaging.getToken();
      PrintUtils.customLog('🔔 FCM: Current token: $token');
      return token;
    } catch (e) {
      PrintUtils.customLog('🔔 FCM: ❌ Error getting token: $e');
      PrintUtils.customLog('🔔 FCM: Error type: ${e.runtimeType}');
      return null;
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      PrintUtils.customLog('🔔 FCM: Subscribed to topic: $topic');
    } catch (e) {
      PrintUtils.customLog('🔔 FCM: Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      PrintUtils.customLog('🔔 FCM: Unsubscribed from topic: $topic');
    } catch (e) {
      PrintUtils.customLog('🔔 FCM: Error unsubscribing from topic: $e');
    }
  }
}
