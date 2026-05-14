import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmScheduler {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
    );

    final androidPlugin =
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.requestNotificationsPermission();

    final bool exactAlarmGranted =
        await androidPlugin?.canScheduleExactNotifications() ?? false;

    if (!exactAlarmGranted) {
      await androidPlugin?.requestExactAlarmsPermission();
    }

    tz.initializeTimeZones();

    final String currentTimeZone =
        (await FlutterTimezone.getLocalTimezone()).identifier;

    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  static Future<void> scheduleAlarm({
    required Duration duration,
    required String title,
    String body = '',
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'alarm_channel_id',
      'Alarms',
      channelDescription: 'Alarm notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final scheduledDate =
    tz.TZDateTime.now(tz.local).add(duration);

    await _notificationsPlugin.zonedSchedule(
      id: 1,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode:
      AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> cancelAlarm(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }

  static Future<void> cancelAllAlarms() async {
    await _notificationsPlugin.cancelAll();
  }
}