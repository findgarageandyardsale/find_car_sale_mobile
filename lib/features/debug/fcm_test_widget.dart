import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/fcm_notification_service.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class FCMTestWidget extends ConsumerStatefulWidget {
  const FCMTestWidget({super.key});

  @override
  ConsumerState<FCMTestWidget> createState() => _FCMTestWidgetState();
}

class _FCMTestWidgetState extends ConsumerState<FCMTestWidget> {
  String? _fcmToken;
  String? _currentUserId;
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

      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) {
        setState(() => _currentUserId = user?.userId.toString());
      });

      PrintUtils.customLog('FCM Token: $token');
    } catch (e) {
      PrintUtils.customLog('Error loading FCM token: $e');
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
        PrintUtils.customLog('FCM Token: $token');
      } else {
        CustomToast.showToast(
          'No FCM token available',
          status: ToastStatus.error,
        );
      }
    } catch (e) {
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
              '🔔 FCM Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              Text(
                'Current User: ${_currentUserId ?? 'Not logged in'}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),

              Text(
                'FCM Token: ${_fcmToken ?? 'Not available'}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _testFCMToken,
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
                        : const Text('Get FCM Token'),
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
                    'Instructions:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('1. Make sure you are logged in'),
                  Text('2. Click "Get FCM Token" to get your token'),
                  Text('3. Check console logs for token'),
                  Text('4. Test notifications by sending messages'),
                  Text('5. Close app and test background notifications'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
