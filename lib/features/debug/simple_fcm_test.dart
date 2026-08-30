import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/simple_fcm_service.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class SimpleFCMTest extends ConsumerStatefulWidget {
  const SimpleFCMTest({super.key});

  @override
  ConsumerState<SimpleFCMTest> createState() => _SimpleFCMTestState();
}

class _SimpleFCMTestState extends ConsumerState<SimpleFCMTest> {
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
      final fcmService = ref.read(simpleFCMServiceProvider);
      final token = await fcmService.getCurrentToken();
      setState(() => _fcmToken = token);

      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) {
        setState(() => _currentUserId = user?.userId.toString());
      });

      PrintUtils.customLog('Simple FCM Token: $token');
    } catch (e) {
      PrintUtils.customLog('Error loading FCM token: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _testNotification() async {
    try {
      setState(() => _isLoading = true);

      if (_currentUserId == null) {
        CustomToast.showToast('Please log in first', status: ToastStatus.error);
        return;
      }

      final fcmService = ref.read(simpleFCMServiceProvider);

      await fcmService.sendTestNotification(
        receiverId: _currentUserId!,
        title: 'Test Notification',
        body: 'This is a test notification from Simple FCM',
      );

      CustomToast.showToast(
        'Test notification sent!',
        status: ToastStatus.success,
      );
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
              '🔔 Simple FCM Test',
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
                onPressed: _isLoading ? null : _testNotification,
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
                        : const Text('Send Test Notification'),
              ),
            ),

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
                  Text('Note:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(
                    'This is a simplified FCM test without Cloud Functions.',
                  ),
                  Text(
                    'It will store notifications in Firestore for manual processing.',
                  ),
                  Text(
                    'For real push notifications, you need Cloud Functions.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
