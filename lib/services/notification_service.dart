import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:findcarsale/services/deeplink_handler_service.dart';

final notificationServiceProvider = ChangeNotifierProvider(
  (ref) => NotificationService(ref),
);

class NotificationService extends ChangeNotifier {
  NotificationService(this.ref);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final Ref ref;

  late BuildContext context;
  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
    bool isEmployee,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder:
          (BuildContext context) => CupertinoAlertDialog(
            title: Text(title ?? ''),
            content: Text(body ?? ''),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Ok'),
                onPressed: () async {
                  if (payload != null) {
                    onSelectNotification(payload);
                  }
                },
              ),
            ],
          ),
    );
  }

  init(BuildContext buildContext) {
    context = buildContext;
    customNotifyListeners();
    requestPermissions();
    var androidSettings = const AndroidInitializationSettings('ic_launcher');
    var iOSSettings = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initSetttings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );
    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) {
        onSelectNotification(notificationResponse.payload);
      },
    );
  }

  Future<dynamic> onSelectNotification(String? payload) async {
    try {
      if (payload != null) {
        Map<String, dynamic> data = json.decode(payload);
        if (data.containsKey('data')) {
          DeepLinkHandler.handleUrl(data['data'], context);
        }
      }
    } catch (e) {
      PrintUtils.customLog('Error handling notification: $e');
    }
  }

  showFirebaseNotification(Map<String, dynamic> mapData, String title) async {
    try {
      var androidDetails = const AndroidNotificationDetails(
        'firebase_channel',
        'Firebase Notification',
        channelDescription: 'Use to send download notification',
        priority: Priority.high,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher',
        styleInformation: BigTextStyleInformation(''),
      );

      String subtitle =
          mapData['data'] == null
              ? mapData['body'] ?? 'title'
              : json.decode(mapData['data'])['short_message'].toString();

      Map<String, dynamic> data = {'data': mapData};
      int randInt = Random().nextInt(10000);

      var iOSDetails = const DarwinNotificationDetails();
      var platformDetails = new NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      );
      await flutterLocalNotificationsPlugin.show(
        randInt,
        title,
        subtitle,
        platformDetails,
        payload: jsonEncode(data),
      );
    } catch (e) {
      PrintUtils.customLog(e.toString());
    }
  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  bool _isDisposed = false;

  // use the customNotifyListeners as below
  customNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}
