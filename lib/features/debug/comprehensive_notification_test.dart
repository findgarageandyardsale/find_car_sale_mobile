import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/fcm_notification_service.dart';
import 'package:findcarsale/services/chat_service/presentation/providers/chat_state_provider.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComprehensiveNotificationTest extends ConsumerStatefulWidget {
  const ComprehensiveNotificationTest({super.key});

  @override
  ConsumerState<ComprehensiveNotificationTest> createState() =>
      _ComprehensiveNotificationTestState();
}

class _ComprehensiveNotificationTestState
    extends ConsumerState<ComprehensiveNotificationTest> {
  String? _fcmToken;
  bool _isLoading = false;
  String _testResults = '';

  @override
  void initState() {
    super.initState();
    _loadFCMToken();
  }

  Future<void> _loadFCMToken() async {
    setState(() => _isLoading = true);
    try {
      final fcmService = ref.read(fcmNotificationServiceProvider);
      final token = await fcmService.getCurrentToken();
      setState(() => _fcmToken = token);
      PrintUtils.customLog('🔔 COMPREHENSIVE: FCM Token loaded: $_fcmToken');
    } catch (e) {
      PrintUtils.customLog('🔔 COMPREHENSIVE: Error loading FCM token: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testCompleteFlow() async {
    setState(() {
      _isLoading = true;
      _testResults = 'Starting comprehensive test...\n';
    });

    try {
      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null) {
          _addTestResult('✅ User logged in: ${user.userId}');

          // Test 1: Check FCM Token
          final fcmService = ref.read(fcmNotificationServiceProvider);
          final token = await fcmService.getCurrentToken();
          if (token != null) {
            _addTestResult(
              '✅ FCM Token available: ${token.substring(0, 20)}...',
            );
          } else {
            _addTestResult('❌ FCM Token not available');
            return;
          }

          // Test 2: Check if token is stored in Firestore
          final userDoc =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.userId.toString())
                  .get();

          if (userDoc.exists && userDoc.data()?['fcm_token'] != null) {
            _addTestResult('✅ FCM Token stored in Firestore');
          } else {
            _addTestResult('❌ FCM Token not stored in Firestore');
          }

          // Test 3: Create test chat room
          final chatService = ref.read(chatServiceProvider);
          final chatRoom = await chatService.createOrGetChatRoom(
            garageYardId:
                'comprehensive-test-${DateTime.now().millisecondsSinceEpoch}',
            sellerId: user.userId.toString(),
            buyerId: 'test-receiver-${DateTime.now().millisecondsSinceEpoch}',
            sellerName: '${user.firstName} ${user.lastName}',
            buyerName: 'Test Receiver',
            postId: 'test-post-${DateTime.now().millisecondsSinceEpoch}',
            postTitle: 'Comprehensive Test Post',
          );

          if (chatRoom != null) {
            _addTestResult('✅ Test chat room created: ${chatRoom.id}');

            // Test 4: Send test message
            final success = await chatService.sendMessage(
              chatRoomId: chatRoom.id ?? '',
              senderId: user.userId.toString(),
              receiverId:
                  'test-receiver-${DateTime.now().millisecondsSinceEpoch}',
              garageYardId:
                  'comprehensive-test-${DateTime.now().millisecondsSinceEpoch}',
              text:
                  'Comprehensive test message - ${DateTime.now().toIso8601String()}',
            );

            if (success) {
              _addTestResult('✅ Test message sent successfully');
              _addTestResult(
                '🔔 Check Firebase Function logs for notification processing',
              );
              _addTestResult('📱 If app is closed, notification should appear');
            } else {
              _addTestResult('❌ Failed to send test message');
            }
          } else {
            _addTestResult('❌ Failed to create test chat room');
          }
        } else {
          _addTestResult('❌ User not logged in');
        }
      });
    } catch (e) {
      _addTestResult('❌ Error in comprehensive test: $e');
      PrintUtils.customLog('🔔 COMPREHENSIVE: Error in test: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _addTestResult(String result) {
    setState(() {
      _testResults += '$result\n';
    });
    PrintUtils.customLog('🔔 COMPREHENSIVE: $result');
  }

  Future<void> _testFCMToken() async {
    try {
      setState(() => _isLoading = true);
      final fcmService = ref.read(fcmNotificationServiceProvider);
      final token = await fcmService.getCurrentToken();

      if (token != null) {
        CustomToast.showToast(
          'FCM Token: ${token.substring(0, 30)}...',
          status: ToastStatus.success,
        );
        setState(() => _fcmToken = token);
      } else {
        CustomToast.showToast(
          'No FCM token available',
          status: ToastStatus.error,
        );
      }
    } catch (e) {
      CustomToast.showToast(
        'Error getting FCM token: $e',
        status: ToastStatus.error,
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
              '🔔 Comprehensive Notification Test',
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
                      onPressed: _isLoading ? null : _testFCMToken,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      child: const Text('Get FCM Token'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _testCompleteFlow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Run Full Test'),
                    ),
                  ),
                ],
              ),
              if (_testResults.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    _testResults,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test Instructions:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('1. Click "Get FCM Token" to verify token generation'),
                    Text('2. Click "Run Full Test" to test complete flow'),
                    Text('3. Check console logs for detailed debug info'),
                    Text('4. Test on physical device (not emulator)'),
                    Text('5. Close app completely after sending message'),
                    Text('6. Check if notification appears'),
                    Text('7. Check Firebase Function logs in Firebase Console'),
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
