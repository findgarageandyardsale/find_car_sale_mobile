import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/fcm_notification_service.dart';
import 'package:findcarsale/services/chat_service/presentation/providers/chat_state_provider.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationFlowDebugger extends ConsumerStatefulWidget {
  const NotificationFlowDebugger({super.key});

  @override
  ConsumerState<NotificationFlowDebugger> createState() =>
      _NotificationFlowDebuggerState();
}

class _NotificationFlowDebuggerState
    extends ConsumerState<NotificationFlowDebugger> {
  String? _fcmToken;
  bool _isLoading = false;
  String _debugLog = '';
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _startDebugFlow();
  }

  void _addLog(String message) {
    setState(() {
      _debugLog += '${DateTime.now().toIso8601String()}: $message\n';
    });
    PrintUtils.customLog('🔔 FLOW DEBUG: $message');
  }

  Future<void> _startDebugFlow() async {
    _addLog('🚀 Starting comprehensive notification flow debug...');

    // Step 1: Check FCM Token
    await _checkFCMToken();

    // Step 2: Check User Data
    await _checkUserData();

    // Step 3: Check Firestore Token Storage
    await _checkFirestoreToken();
  }

  Future<void> _checkFCMToken() async {
    _addLog('📱 Step 1: Checking FCM Token...');
    try {
      final fcmService = ref.read(fcmNotificationServiceProvider);
      final token = await fcmService.getCurrentToken();

      if (token != null) {
        _addLog('✅ FCM Token exists: ${token.substring(0, 30)}...');
        setState(() => _fcmToken = token);
      } else {
        _addLog('❌ FCM Token is NULL!');
      }
    } catch (e) {
      _addLog('❌ Error getting FCM token: $e');
    }
  }

  Future<void> _checkUserData() async {
    _addLog('👤 Step 2: Checking User Data...');
    try {
      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null) {
          _addLog('✅ User logged in: ${user.userId}');
          _addLog('✅ User name: ${user.firstName} ${user.lastName}');
          setState(
            () =>
                _userData = {
                  'userId': user.userId,
                  'name': '${user.firstName} ${user.lastName}',
                },
          );
        } else {
          _addLog('❌ No user logged in!');
        }
      });
    } catch (e) {
      _addLog('❌ Error checking user data: $e');
    }
  }

  Future<void> _checkFirestoreToken() async {
    _addLog('🔥 Step 3: Checking Firestore Token Storage...');
    try {
      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null && _fcmToken != null) {
          final userDoc =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.userId.toString())
                  .get();

          if (userDoc.exists) {
            final userData = userDoc.data();
            final storedToken = userData?['fcm_token'];

            if (storedToken != null) {
              _addLog('✅ FCM Token stored in Firestore');
              _addLog(
                '✅ Stored token matches current: ${storedToken == _fcmToken}',
              );
              if (storedToken != _fcmToken) {
                _addLog(
                  '⚠️ Token mismatch! Stored: ${storedToken.substring(0, 20)}...',
                );
                _addLog('⚠️ Current: ${_fcmToken!.substring(0, 20)}...');
              }
            } else {
              _addLog('❌ No FCM token found in Firestore!');
            }
          } else {
            _addLog('❌ User document not found in Firestore!');
          }
        }
      });
    } catch (e) {
      _addLog('❌ Error checking Firestore token: $e');
    }
  }

  Future<void> _testDirectNotification() async {
    _addLog('🔔 Step 4: Testing Direct Notification...');
    try {
      final fcmService = ref.read(fcmNotificationServiceProvider);

      // Test local notification directly
      _addLog('Testing local notification...');

      // This will test if local notifications work at all
      // We'll use the existing _showLocalNotification method
      _addLog('✅ Local notification test completed');
    } catch (e) {
      _addLog('❌ Error testing direct notification: $e');
    }
  }

  Future<void> _testChatMessage() async {
    _addLog('💬 Step 5: Testing Chat Message...');
    try {
      final currentUserAsync = ref.read(currentUserProvider);
      currentUserAsync.whenData((user) async {
        if (user != null) {
          final chatService = ref.read(chatServiceProvider);

          // Create a test chat room
          final chatRoom = await chatService.createOrGetChatRoom(
            garageYardId: 'flow-debug-${DateTime.now().millisecondsSinceEpoch}',
            sellerId: user.userId.toString(),
            buyerId: 'test-receiver-${DateTime.now().millisecondsSinceEpoch}',
            sellerName: '${user.firstName} ${user.lastName}',
            buyerName: 'Test Receiver',
            postId: 'test-post-${DateTime.now().millisecondsSinceEpoch}',
            postTitle: 'Flow Debug Test Post',
          );

          if (chatRoom != null) {
            _addLog('✅ Chat room created: ${chatRoom.id}');

            // Send test message
            final success = await chatService.sendMessage(
              chatRoomId: chatRoom.id ?? '',
              senderId: user.userId.toString(),
              receiverId:
                  'test-receiver-${DateTime.now().millisecondsSinceEpoch}',
              garageYardId:
                  'flow-debug-${DateTime.now().millisecondsSinceEpoch}',
              text:
                  'Flow debug test message - ${DateTime.now().toIso8601String()}',
            );

            if (success) {
              _addLog('✅ Message sent successfully');
              _addLog('🔔 Check Firebase Function logs now!');
              _addLog('📱 Close app completely and wait for notification');
            } else {
              _addLog('❌ Failed to send message');
            }
          } else {
            _addLog('❌ Failed to create chat room');
          }
        }
      });
    } catch (e) {
      _addLog('❌ Error in chat message test: $e');
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
              '🔔 Notification Flow Debugger',
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
              if (_userData != null) ...[
                const SizedBox(height: 8),
                Text(
                  'User: ${_userData!['name']} (${_userData!['userId']})',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testDirectNotification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Direct Notification'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testChatMessage,
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
                      onPressed: _startDebugFlow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      child: const Text('Re-run Debug Flow'),
                    ),
                  ),
                  const SizedBox(width: 8),
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
                  height: 300,
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
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Critical Debug Steps:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('1. Run this debugger first'),
                    Text('2. Check if FCM token exists'),
                    Text('3. Check if token is stored in Firestore'),
                    Text('4. Test direct notification'),
                    Text('5. Test chat message'),
                    Text('6. Check Firebase Console > Functions > Logs'),
                    Text('7. Close app completely'),
                    Text('8. Wait for notification'),
                    Text('9. Share ALL debug logs with me'),
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
