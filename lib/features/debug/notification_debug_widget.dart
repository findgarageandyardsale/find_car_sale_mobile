import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/fcm_notification_service.dart';
import 'package:findcarsale/services/chat_service/presentation/providers/chat_state_provider.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class NotificationDebugWidget extends ConsumerStatefulWidget {
  const NotificationDebugWidget({super.key});

  @override
  ConsumerState<NotificationDebugWidget> createState() =>
      _NotificationDebugWidgetState();
}

class _NotificationDebugWidgetState
    extends ConsumerState<NotificationDebugWidget> {
  String? _fcmToken;
  bool _isLoading = false;

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
      PrintUtils.customLog('🔔 DEBUG: FCM Token loaded: $_fcmToken');
    } catch (e) {
      PrintUtils.customLog('🔔 DEBUG: Error loading FCM token: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testFCMToken() async {
    try {
      setState(() => _isLoading = true);
      final fcmService = ref.read(fcmNotificationServiceProvider);
      final token = await fcmService.getCurrentToken();

      if (token != null) {
        CustomToast.showToast('FCM Token: $token', status: ToastStatus.success);
        PrintUtils.customLog('🔔 DEBUG: FCM Token: $token');
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
      PrintUtils.customLog('🔔 DEBUG: Error getting FCM token: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testChatMessage() async {
    try {
      setState(() => _isLoading = true);

      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null) {
          final chatService = ref.read(chatServiceProvider);

          // Create a test chat room and send a message
          final chatRoom = await chatService.createOrGetChatRoom(
            garageYardId: 'test-garage-123',
            sellerId: user.userId.toString(),
            buyerId: 'test-buyer-456',
            sellerName: '${user.firstName} ${user.lastName}',
            buyerName: 'Test Buyer',
            postId: 'test-post-789',
            postTitle: 'Test Post',
          );

          if (chatRoom != null) {
            final success = await chatService.sendMessage(
              chatRoomId: chatRoom.id ?? '',
              senderId: user.userId.toString(),
              receiverId: 'test-buyer-456',
              garageYardId: 'test-garage-123',
              text: 'This is a test message to trigger notifications!',
            );

            if (success) {
              CustomToast.showToast(
                'Test message sent! Check Firebase Function logs.',
                status: ToastStatus.success,
              );
              PrintUtils.customLog('🔔 DEBUG: Test message sent successfully');
            } else {
              CustomToast.showToast(
                'Failed to send test message',
                status: ToastStatus.error,
              );
            }
          } else {
            CustomToast.showToast(
              'Failed to create test chat room',
              status: ToastStatus.error,
            );
          }
        } else {
          CustomToast.showToast(
            'Please log in first',
            status: ToastStatus.error,
          );
        }
      });
    } catch (e) {
      CustomToast.showToast('Error: $e', status: ToastStatus.error);
      PrintUtils.customLog('🔔 DEBUG: Error in test chat message: $e');
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
              '🔔 Notification Debug Widget',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              Text(
                'FCM Token: ${_fcmToken ?? 'Not available'}',
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
                      onPressed: _isLoading ? null : _testChatMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Chat Message'),
                    ),
                  ),
                ],
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
                  Text('1. Click "Get FCM Token" to get your token'),
                  Text('2. Click "Test Chat Message" to send a test message'),
                  Text('3. Check console logs for debug info'),
                  Text('4. Check Firebase Function logs in Firebase Console'),
                  Text('5. Test on physical device (not emulator)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
