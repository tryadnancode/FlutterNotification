import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void backgroundNotificationHandler(NotificationResponse notificationResponse) {
  print('Handling background notification: ${notificationResponse.payload}');
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    var androidSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");

    var iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
          // Handle notification for iOS in the foreground
        }
    );

    var initializationSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings
    );

    // Register the top-level background handler
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: backgroundNotificationHandler, // Pass the top-level handler
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId", "channelName",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails()
    );
  }

  Future showNotification({int id = 0, String? title = "Title", String? body = "Body", String? payload}) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }
}
