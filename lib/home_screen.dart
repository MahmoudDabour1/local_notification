import 'package:flutter/material.dart';
import 'package:local_notification/local_notification_service.dart';
import 'package:local_notification/notification_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    listenForNotificationStream();
  }

  void listenForNotificationStream() {
    LocalNotificationService.streamController.stream.listen((event) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationDetailsScreen(
            response: event,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notification Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //basic notification
            ListTile(
              onTap: () {
                LocalNotificationService.showBasicNotification(
                    title: "Hello",
                    body: "Welcome to the Local Notification Example");
              },
              leading: Icon(Icons.notifications),
              title: const Text('Basic Notification'),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.cancelNotification(0);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ),
            //repeated notification
            ListTile(
              onTap: () {
                LocalNotificationService.showRepeatedNotification(
                    title: "RepeatedHello",
                    body: "Welcome to the Local Notification Example");
              },
              leading: Icon(Icons.notifications),
              title: const Text('Repeated Notification'),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.cancelNotification(1);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ),
            //Scheduled notification
            ListTile(
              onTap: () {
                LocalNotificationService.showScheduledNotification(
                    title: "ScheduledHello",
                    body: "Welcome to the Local Notification Example");
              },
              leading: Icon(Icons.notifications),
              title: const Text('Scheduled Notification'),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.cancelNotification(2);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ),
            //cancel all notification
            ElevatedButton(
                onPressed: () {
                  LocalNotificationService.flutterLocalNotificationsPlugin
                      .cancelAll();
                },
                child: Text("Cancel All Notification")),
          ],
        ),
      ),
    );
  }
}
