import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/fcm_notification_service.dart';
import 'package:findcarsale/services/chat_service/presentation/providers/chat_state_provider.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class NotificationDebugSimple extends ConsumerStatefulWidget {
  const NotificationDebugSimple({super.key});

  @override
  ConsumerState<NotificationDebugSimple> createState() =>
      _NotificationDebugSimpleState();
}

class _NotificationDebugSimpleState
    extends ConsumerState<NotificationDebugSimple> {
  String? _fcmToken;
  bool _isLoading = false;
  String _debugLog = '';

  @override
  void initState() {
    super.initState();
    _loadFCMToken();
  }

  void _addLog(String message) {
    setState(() {
      _debugLog += '${DateTime.now().toIso8601String()}: $message\n';
    });
    PrintUtils.customLog('🔔 DEBUG: $message');
  }

  Future<void> _loadFCMToken() async {
    setState(() => _isLoading = true);
    _addLog('Loading FCM token...');
    try {
      final fcmService = ref.read(fcmNotificationServiceProvider);
      final token = await fcmService.getCurrentToken();
      setState(() => _fcmToken = token);
      if (token != null) {
        _addLog('✅ FCM Token loaded: ${token.substring(0, 30)}...');
      } else {
        _addLog('❌ FCM Token is null');
      }
    } catch (e) {
      _addLog('❌ Error loading FCM token: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testFCMToken() async {
    setState(() => _isLoading = true);
    _addLog('Testing FCM token...');
    try {
      final fcmService = ref.read(fcmNotificationServiceProvider);
      final token = await fcmService.getCurrentToken();

      if (token != null) {
        CustomToast.showToast(
          'FCM Token: ${token.substring(0, 30)}...',
          status: ToastStatus.success,
        );
        _addLog('✅ FCM Token: ${token.substring(0, 30)}...');
        setState(() => _fcmToken = token);
      } else {
        CustomToast.showToast(
          'No FCM token available',
          status: ToastStatus.error,
        );
        _addLog('❌ No FCM token available');
      }
    } catch (e) {
      CustomToast.showToast(
        'Error getting FCM token: $e',
        status: ToastStatus.error,
      );
      _addLog('❌ Error getting FCM token: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testChatMessage() async {
    setState(() => _isLoading = true);
    _addLog('Testing chat message...');
    try {
      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null) {
          _addLog('✅ User logged in: ${user.userId}');

          final chatService = ref.read(chatServiceProvider);
          final chatRoom = await chatService.createOrGetChatRoom(
            garageYardId: 'debug-test-${DateTime.now().millisecondsSinceEpoch}',
            sellerId: user.userId.toString(),
            buyerId: 'test-receiver-${DateTime.now().millisecondsSinceEpoch}',
            sellerName: '${user.firstName} ${user.lastName}',
            buyerName: 'Test Receiver',
            postId: 'test-post-${DateTime.now().millisecondsSinceEpoch}',
            postTitle: 'Debug Test Post',
          );

          if (chatRoom != null) {
            _addLog('✅ Chat room created: ${chatRoom.id}');

            final success = await chatService.sendMessage(
              chatRoomId: chatRoom.id ?? '',
              senderId: user.userId.toString(),
              receiverId:
                  'test-receiver-${DateTime.now().millisecondsSinceEpoch}',
              garageYardId:
                  'debug-test-${DateTime.now().millisecondsSinceEpoch}',
              text: 'Debug test message - ${DateTime.now().toIso8601String()}',
            );

            if (success) {
              _addLog('✅ Message sent successfully');
              _addLog(
                '🔔 Check Firebase Function logs for detailed debug info',
              );
              CustomToast.showToast(
                'Test message sent! Check logs.',
                status: ToastStatus.success,
              );
            } else {
              _addLog('❌ Failed to send message');
              CustomToast.showToast(
                'Failed to send test message',
                status: ToastStatus.error,
              );
            }
          } else {
            _addLog('❌ Failed to create chat room');
            CustomToast.showToast(
              'Failed to create test chat room',
              status: ToastStatus.error,
            );
          }
        } else {
          _addLog('❌ User not logged in');
          CustomToast.showToast(
            'Please log in first',
            status: ToastStatus.error,
          );
        }
      });
    } catch (e) {
      _addLog('❌ Error in test: $e');
      CustomToast.showToast('Error: $e', status: ToastStatus.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _clearLog() {
    setState(() {
      _debugLog = '';
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
              '🔔 Notification Debug (Simple)',
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
                      child: const Text('Test FCM Token'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _testChatMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Chat Message'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _clearLog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Clear Log'),
                    ),
                  ),
                ],
              ),
              if (_debugLog.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _debugLog,
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
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Debug Steps:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('1. Click "Test FCM Token" to verify token'),
                    Text('2. Click "Test Chat Message" to send test message'),
                    Text('3. Check this debug log for Flutter app logs'),
                    Text(
                      '4. Check Firebase Console > Functions > Logs for Cloud Function logs',
                    ),
                    Text('5. Test on physical device (not emulator)'),
                    Text('6. Close app completely after sending message'),
                    Text('7. Check if notification appears'),
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
