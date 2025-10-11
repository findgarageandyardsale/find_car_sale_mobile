import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/fcm_notification_service.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSystemTest extends ConsumerStatefulWidget {
  const NotificationSystemTest({super.key});

  @override
  ConsumerState<NotificationSystemTest> createState() =>
      _NotificationSystemTestState();
}

class _NotificationSystemTestState
    extends ConsumerState<NotificationSystemTest> {
  String? _fcmToken;
  bool _isLoading = false;
  String _testResults = '';

  @override
  void initState() {
    super.initState();
    _runSystemTest();
  }

  void _addResult(String result) {
    setState(() {
      _testResults += '$result\n';
    });
    PrintUtils.customLog('🔔 SYSTEM TEST: $result');
  }

  Future<void> _runSystemTest() async {
    _addResult('🚀 Starting Notification System Test...');
    _addResult('=====================================');

    // Test 1: FCM Token
    await _testFCMToken();

    // Test 2: Local Notifications
    await _testLocalNotifications();

    // Test 3: FCM Service Status
    await _testFCMService();

    _addResult('=====================================');
    _addResult('🏁 System Test Complete');
  }

  Future<void> _testFCMToken() async {
    _addResult('📱 Test 1: FCM Token');
    try {
      final fcmService = ref.read(fcmNotificationServiceProvider);
      final token = await fcmService.getCurrentToken();

      if (token != null) {
        _addResult('✅ FCM Token exists: ${token.substring(0, 30)}...');
        setState(() => _fcmToken = token);
      } else {
        _addResult('❌ FCM Token is NULL!');
        _addResult('🔧 This means FCM is not properly initialized');
      }
    } catch (e) {
      _addResult('❌ Error getting FCM token: $e');
    }
  }

  Future<void> _testLocalNotifications() async {
    _addResult('🔔 Test 2: Local Notifications');
    try {
      final FlutterLocalNotificationsPlugin localNotifications =
          FlutterLocalNotificationsPlugin();

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

      final initResult = await localNotifications.initialize(initSettings);
      _addResult('✅ Local notifications initialized: $initResult');

      // Test showing a notification
      const androidDetails = AndroidNotificationDetails(
        'test_channel',
        'Test Channel',
        channelDescription: 'Test notifications',
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

      await localNotifications.show(
        999,
        'Test Notification',
        'This is a test notification from the system test',
        notificationDetails,
      );

      _addResult('✅ Test notification shown successfully');
    } catch (e) {
      _addResult('❌ Error testing local notifications: $e');
    }
  }

  Future<void> _testFCMService() async {
    _addResult('🔧 Test 3: FCM Service Status');
    try {
      final fcmService = ref.read(fcmNotificationServiceProvider);
      _addResult('✅ FCM Service provider accessible');

      // Check if service is properly initialized
      final token = await fcmService.getCurrentToken();
      if (token != null) {
        _addResult('✅ FCM Service is working');
      } else {
        _addResult('❌ FCM Service not working properly');
      }
    } catch (e) {
      _addResult('❌ Error testing FCM service: $e');
    }
  }

  Future<void> _testDirectNotification() async {
    setState(() => _isLoading = true);
    _addResult('🔔 Testing Direct Notification...');

    try {
      final FlutterLocalNotificationsPlugin localNotifications =
          FlutterLocalNotificationsPlugin();

      const androidDetails = AndroidNotificationDetails(
        'direct_test',
        'Direct Test',
        channelDescription: 'Direct notification test',
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

      await localNotifications.show(
        888,
        'Direct Test Notification',
        'This is a direct test notification - ${DateTime.now().toIso8601String()}',
        notificationDetails,
      );

      _addResult('✅ Direct notification sent');
      CustomToast.showToast(
        'Direct notification sent!',
        status: ToastStatus.success,
      );
    } catch (e) {
      _addResult('❌ Error sending direct notification: $e');
      CustomToast.showToast('Error: $e', status: ToastStatus.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _clearResults() {
    setState(() {
      _testResults = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔔 Notification System Test',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              Text(
                'FCM Token: ${_fcmToken != null ? '${_fcmToken!.substring(0, 30)}...' : 'Not available'}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _testDirectNotification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Direct Notification'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _runSystemTest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      child: const Text('Re-run Tests'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _clearResults,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Clear Results'),
              ),
              if (_testResults.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 300,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _testResults,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Test Instructions:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('1. Run the system test first'),
                    Text('2. Check if FCM token exists'),
                    Text('3. Check if local notifications work'),
                    Text('4. Test direct notification'),
                    Text('5. Share ALL test results with me'),
                    Text('6. Test on physical device (not emulator)'),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
