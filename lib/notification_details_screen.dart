import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationResponse response;
  const NotificationDetailsScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body:  Center(
        child: Text("${response.id}:${response.payload}"),
      ),
    );
  }
}
