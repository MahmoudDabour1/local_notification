import 'package:local_notification/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {


  void registerMyTask() async {
    await Workmanager().registerPeriodicTask("id1", "Show Simple Notification",
        frequency: Duration(hours: 23),
        initialDelay: Duration(seconds: 5));
  }

  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}
@pragma('vm:entry-point')
void actionTask() {
  Workmanager().executeTask((taskName, inputData) async {
    LocalNotificationService.showScheduledDailyNotification(title: "WorkManager", body: "body");
    return Future.value(true);
  });
}
