import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';

final simpleFCMServiceProvider = Provider<SimpleFCMService>((ref) {
  return SimpleFCMService(ref);
});

class SimpleFCMService {
  final Ref _ref;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SimpleFCMService(this._ref) {
    _initializeFCM();
  }

  /// Initialize FCM and set up message handlers
  Future<void> _initializeFCM() async {
    try {
      PrintUtils.customLog('🔔 Simple FCM: Initializing FCM service...');

      // Request permission for notifications
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      PrintUtils.customLog(
        '🔔 Simple FCM: Permission status: ${settings.authorizationStatus}',
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Get FCM token
        final token = await _messaging.getToken();
        PrintUtils.customLog('🔔 Simple FCM: FCM Token: $token');

        if (token != null) {
          await _storeFCMToken(token);
        }

        // Set up message handlers
        _setupMessageHandlers();
      }
    } catch (e) {
      PrintUtils.customLog('🔔 Simple FCM: Error initializing FCM: $e');
    }
  }

  /// Store FCM token in Firestore for the current user
  Future<void> _storeFCMToken(String token) async {
    try {
      final currentUserAsync = _ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null) {
          await _firestore.collection('users').doc(user.userId.toString()).set({
            'fcm_token': token,
            'updated_at': DateTime.now().toIso8601String(),
          }, SetOptions(merge: true));

          PrintUtils.customLog(
            '🔔 Simple FCM: Token stored for user: ${user.userId}',
          );
        }
      });
    } catch (e) {
      PrintUtils.customLog('🔔 Simple FCM: Error storing FCM token: $e');
    }
  }

  /// Set up message handlers for different app states
  void _setupMessageHandlers() {
    // Handle messages when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PrintUtils.customLog(
        '🔔 Simple FCM: Received foreground message: ${message.messageId}',
      );
      PrintUtils.customLog(
        '🔔 Simple FCM: Title: ${message.notification?.title}',
      );
      PrintUtils.customLog(
        '🔔 Simple FCM: Body: ${message.notification?.body}',
      );
      PrintUtils.customLog('🔔 Simple FCM: Data: ${message.data}');
    });

    // Handle messages when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PrintUtils.customLog(
        '🔔 Simple FCM: App opened from background message: ${message.messageId}',
      );
    });

    // Handle messages when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        PrintUtils.customLog(
          '🔔 Simple FCM: App opened from terminated state: ${message.messageId}',
        );
      }
    });
  }

  /// Get current FCM token
  Future<String?> getCurrentToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      PrintUtils.customLog('🔔 Simple FCM: Error getting token: $e');
      return null;
    }
  }

  /// Send notification manually (for testing)
  Future<void> sendTestNotification({
    required String receiverId,
    required String title,
    required String body,
  }) async {
    try {
      PrintUtils.customLog(
        '🔔 Simple FCM: Sending test notification to: $receiverId',
      );

      // Get receiver's FCM token
      final receiverDoc =
          await _firestore.collection('users').doc(receiverId).get();

      if (!receiverDoc.exists) {
        PrintUtils.customLog('🔔 Simple FCM: Receiver not found');
        return;
      }

      final receiverData = receiverDoc.data();
      final fcmToken = receiverData?['fcm_token'];

      if (fcmToken == null) {
        PrintUtils.customLog('🔔 Simple FCM: No FCM token for receiver');
        return;
      }

      // Store notification in Firestore for manual sending
      await _firestore.collection('manual_notifications').add({
        'receiver_id': receiverId,
        'fcm_token': fcmToken,
        'title': title,
        'body': body,
        'created_at': DateTime.now().toIso8601String(),
        'status': 'pending',
      });

      PrintUtils.customLog('🔔 Simple FCM: Test notification queued');
    } catch (e) {
      PrintUtils.customLog(
        '🔔 Simple FCM: Error sending test notification: $e',
      );
    }
  }
}
