import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    await _requestPermissions();
    await registerFCMToken();

    _subscribeToTopic();

    _handleInitialMessage();
    _listenToForegroundMessages();
    _handleMessageOpenedApp();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    try {
      await FirebaseMessaging.instance.requestPermission(provisional: true);
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
    FirebaseMessaging.instance.subscribeToTopic('default');
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
      final notification = message.notification;
      final data =
          message.data.isEmpty ? notification?.toMap() ?? {} : message.data;
      ref
          .read(notificationServiceProvider)
          .showFirebaseNotification(data, notification?.title ?? '');
    });
  }

  /// Handle background-tapped notifications
  void _handleMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationData(message.data);
    });
  }

  /// Common logic to parse & handle notification data
  void _handleNotificationData(Map<String, dynamic> data) {
    DeepLinkHandler.handleUrl(data, context);
  }

  /// Unsubscribe and unregister token
  Future<void> unsubscribeFromTopic() async {
    final token = await FirebaseMessaging.instance.getToken();

    if (token != null) {}
    await FirebaseMessaging.instance.unsubscribeFromTopic('default');
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
  await FirebaseMessaging.instance;
  // Handle background logic here if needed
}
