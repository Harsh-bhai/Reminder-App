import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_app/models/reminder.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // initialize the local notifications plugin
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: ((id, title, body, payload) => {}));
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: ((response) => {}));
  }

  // show a simple notification
  static Future showSimpleNotification(ReminderModel reminder) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
await _flutterLocalNotificationsPlugin.show(
    reminder.id, reminder.title, 'plain body', notificationDetails,
    payload: 'item x');
  }

  // show notification daily
  //REVIEW - check this one
  static Future showNotificationDaily(ReminderModel reminder) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        reminder.id, reminder.title, 'plain body', RepeatInterval.daily,
        notificationDetails,
        payload: 'item x');
  }
  // show notification daily
  // FIXME: not working
  static Future showPeriodicNotification(ReminderModel reminder) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        reminder.id, reminder.title, 'plain body', RepeatInterval.daily,
        notificationDetails,
        payload: 'item x');
  }

  // close a specific channel notification
  static Future closeNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the noficitaions
  static Future closeAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
