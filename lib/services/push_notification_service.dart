import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/deeplink_handler_service.dart';
import 'package:findcarsale/services/notification_service.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

final pushNotificationProvider =
    ChangeNotifierProvider.family<PushNotificationProvider, BuildContext>(
      (ref, context) => PushNotificationProvider(ref, context),
    );

class PushNotificationProvider extends ChangeNotifier {
  final Ref ref;
  final BuildContext context;
  bool _isDisposed = false;

  PushNotificationProvider(this.ref, this.context);

  /// Setup FCM & handle foreground/initial/background messages
  Future<void> setupFirebaseMessage() async {
    try {
      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        PrintUtils.customLog('Firebase not initialized, skipping FCM setup');
        return;
      }

      await _requestPermissions();
      await registerFCMToken();

      _subscribeToTopic();

      _handleInitialMessage();
      _listenToForegroundMessages();
      _handleMessageOpenedApp();

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    } catch (e) {
      PrintUtils.customLog('Error setting up Firebase messaging: $e');
    }
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    try {
      // Check current permission status first
      final settings =
          await FirebaseMessaging.instance.getNotificationSettings();

      if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
      }
    } catch (e) {
      PrintUtils.customLog('Error requesting notification permissions: $e');
    }
  }

  /// Get and register the FCM token
  Future<String?> registerFCMToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      PrintUtils.customLog('FCM token: $token');
      return token;
    } catch (e) {
      PrintUtils.customLog('Error getting FCM token: $e');
      return null;
    }
  }

  /// Subscribe to default topic
  void _subscribeToTopic() {
    try {
      FirebaseMessaging.instance.subscribeToTopic('default');
    } catch (e) {
      PrintUtils.customLog('Error subscribing to topic: $e');
    }
  }

  /// Handle app opened via notification when terminated
  Future<void> _handleInitialMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationData(initialMessage.data);
    }
  }

  /// Listen to foreground notifications
  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((message) {
      try {
        if (!_isDisposed && context.mounted) {
          final notification = message.notification;
          final data =
              message.data.isEmpty ? notification?.toMap() ?? {} : message.data;
          ref
              .read(notificationServiceProvider)
              .showFirebaseNotification(data, notification?.title ?? '');
        }
      } catch (e) {
        PrintUtils.customLog('Error handling foreground message: $e');
      }
    });
  }

  /// Handle background-tapped notifications
  void _handleMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      try {
        if (!_isDisposed && context.mounted) {
          _handleNotificationData(message.data);
        }
      } catch (e) {
        PrintUtils.customLog('Error handling message opened app: $e');
      }
    });
  }

  /// Common logic to parse & handle notification data
  void _handleNotificationData(Map<String, dynamic> data) {
    try {
      if (!_isDisposed && context.mounted) {
        DeepLinkHandler.handleUrl(data, context);
      }
    } catch (e) {
      PrintUtils.customLog('Error handling notification data: $e');
    }
  }

  /// Unsubscribe and unregister token
  Future<void> unsubscribeFromTopic() async {
    try {
      if (Firebase.apps.isNotEmpty) {
        await FirebaseMessaging.instance.unsubscribeFromTopic('default');
        PrintUtils.customLog('Successfully unsubscribed from default topic');
      }
    } catch (e) {
      PrintUtils.customLog('Error unsubscribing from topic: $e');
    }
  }

  /// Only notify if not disposed
  void customNotifyListeners() {
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}

/// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    // Ensure Firebase is initialized in background
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    PrintUtils.customLog("Handling background message: ${message.messageId}");
    // Handle background logic here if needed
  } catch (e) {
    PrintUtils.customLog('Error in background message handler: $e');
  }
}
