import 'package:flutter/material.dart';

import 'local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                }, child: Text("Cancel All Notification")),
          ],
        ),
      ),
    );
  }
}
