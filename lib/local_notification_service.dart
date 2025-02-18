import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

// Basic notification
  static Future<void> showBasicNotification({
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('sound.mp3'.split('.')[0]),
    );

    NotificationDetails details =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      details,
      payload: 'Basic Notification',
    );
  }

// Repeated notification
  static Future<void> showRepeatedNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1',
      'Repeated name',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.everyMinute,
      details,
      payload: 'Repeated Notification',
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  // Scheduled notification
  static Future<void> showScheduledNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '2',
      'Scheduled name',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    final tz.TZDateTime scheduledDate = tz.TZDateTime.now(tz.local).add(
      const Duration(seconds: 5), // Schedule 5 seconds from now
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      scheduledDate,
      details,
      payload: 'Scheduled Notification',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
