import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/fcm_notification_service.dart';
import 'package:findcarsale/services/chat_service/presentation/providers/chat_state_provider.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class RealNotificationTest extends ConsumerStatefulWidget {
  const RealNotificationTest({super.key});

  @override
  ConsumerState<RealNotificationTest> createState() =>
      _RealNotificationTestState();
}

class _RealNotificationTestState extends ConsumerState<RealNotificationTest> {
  String? _fcmToken;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getFCMToken();
  }

  Future<void> _getFCMToken() async {
    try {
      final fcmService = ref.read(fcmNotificationServiceProvider);
      final token = await fcmService.getCurrentToken();
      setState(() => _fcmToken = token);
      PrintUtils.customLog('🔔 REAL TEST: FCM Token: $token');
    } catch (e) {
      PrintUtils.customLog('🔔 REAL TEST: Error getting FCM token: $e');
    }
  }

  Future<void> _sendRealTestMessage() async {
    setState(() => _isLoading = true);
    try {
      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null) {
          PrintUtils.customLog('🔔 REAL TEST: User: ${user.userId}');

          final chatService = ref.read(chatServiceProvider);

          // Create a real chat room
          final chatRoom = await chatService.createOrGetChatRoom(
            garageYardId: 'real-test-${DateTime.now().millisecondsSinceEpoch}',
            sellerId: user.userId.toString(),
            buyerId: 'real-receiver-${DateTime.now().millisecondsSinceEpoch}',
            sellerName: '${user.firstName} ${user.lastName}',
            buyerName: 'Real Test Receiver',
            postId: 'real-post-${DateTime.now().millisecondsSinceEpoch}',
            postTitle: 'Real Test Post',
          );

          if (chatRoom != null) {
            PrintUtils.customLog(
              '🔔 REAL TEST: Chat room created: ${chatRoom.id}',
            );

            // Send real message
            final success = await chatService.sendMessage(
              chatRoomId: chatRoom.id ?? '',
              senderId: user.userId.toString(),
              receiverId:
                  'real-receiver-${DateTime.now().millisecondsSinceEpoch}',
              garageYardId:
                  'real-test-${DateTime.now().millisecondsSinceEpoch}',
              text: 'Real test message - ${DateTime.now().toIso8601String()}',
            );

            if (success) {
              PrintUtils.customLog('🔔 REAL TEST: Message sent successfully');
              CustomToast.showToast(
                'Message sent! Now close the app completely and wait for notification.',
                status: ToastStatus.success,
              );
            } else {
              PrintUtils.customLog('🔔 REAL TEST: Failed to send message');
              CustomToast.showToast(
                'Failed to send message',
                status: ToastStatus.error,
              );
            }
          } else {
            PrintUtils.customLog('🔔 REAL TEST: Failed to create chat room');
            CustomToast.showToast(
              'Failed to create chat room',
              status: ToastStatus.error,
            );
          }
        } else {
          PrintUtils.customLog('🔔 REAL TEST: No user logged in');
          CustomToast.showToast(
            'Please log in first',
            status: ToastStatus.error,
          );
        }
      });
    } catch (e) {
      PrintUtils.customLog('🔔 REAL TEST: Error: $e');
      CustomToast.showToast('Error: $e', status: ToastStatus.error);
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
              '🔔 Real Notification Test',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'FCM Token: ${_fcmToken != null ? '${_fcmToken!.substring(0, 30)}...' : 'Not available'}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendRealTestMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : const Text('Send Real Test Message'),
              ),
            ),
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
                    'Real Test Instructions:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('1. Make sure you are logged in'),
                  Text('2. Click "Send Real Test Message"'),
                  Text('3. CLOSE THE APP COMPLETELY'),
                  Text('4. Wait for notification to appear'),
                  Text('5. If no notification, check Firebase Console logs'),
                  Text('6. Test on physical device (not emulator)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
