// import 'package:ecommerce_app/res/notification/push_notification.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// @pragma('vm:entry-point')
// void onReceive(NotificationResponse response) {
//   if (response.actionId == 'stop_alarm') {
//     print('Alarm STOP button pressed (BG)');
//     flutterLocalNotificationsPlugin.cancelAll();
//   }   else if (response.actionId == 'snooze_alarm') {
//     print('Alarm SNOOZE button pressed (BG)');

//   }
// }

// class CustomAlarm {
//   LocalNotification notification = LocalNotification();

//   static init() async {
//     const AndroidInitializationSettings androidInitSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

//     final DarwinInitializationSettings iOSInitSettings = DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       notificationCategories: [
//         DarwinNotificationCategory(
//           'mintalarm_channel_id',
//           actions: [
//             DarwinNotificationAction.plain(
//               'CLOSE_ACTION', // unique identifier for the action
//               'Close', // visible title
//               options: <DarwinNotificationActionOption>{
//                 DarwinNotificationActionOption.destructive,
//               },
//             ),
//           ],
//         ),
//       ],
//     );

//     InitializationSettings initializationSettings = InitializationSettings(
//       iOS: iOSInitSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onReceive,
//       onDidReceiveBackgroundNotificationResponse: onReceive,
//     );

//   }

//   static Future<void> showAlarmNotification(
//       {required String? title, required String? message, required String? id}) async {
//     const androidDetails = AndroidNotificationDetails(
//       'mintalarm_channel_id',
//       'Alarm Channel',
//       channelDescription: 'Channel for alarm-style notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       fullScreenIntent: true,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('alarm'),
//       // 🚫 Make it non-dismissible
//       ongoing: true,
//       // keeps it pinned
//       autoCancel: false,
//       // don’t auto-dismiss when tapped
//       onlyAlertOnce: false,
//       // allow repeated sound/vibration

//       icon: '@mipmap/ic_launcher',
//       category: AndroidNotificationCategory.alarm,
//       actions: <AndroidNotificationAction>[
//         AndroidNotificationAction(
//           'stop_alarm',
//           'STOP',
//           showsUserInterface: true,
//           cancelNotification: true,
//         ),

//          AndroidNotificationAction(
//           'snooze_alarm',
//           'SNOOZE',
//           showsUserInterface: true,
//           cancelNotification: true,

//         ),
//       ],
//     );

//     const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
//       sound: /*'slow_spring_board.aiff'*/ /*'notification_alarm.aiff'*/"alarm_new_notification.wav",
//       presentSound: true,
//       categoryIdentifier: 'mintalarm_channel_id',
//     );

//     const platformDetails = NotificationDetails(android: androidDetails, iOS: darwinNotificationDetails);

//     await flutterLocalNotificationsPlugin.show(
//       int.tryParse(id.toString()) ?? 0,
//       title ?? 'Alarm',
//       message ?? 'Wake up!',
//       platformDetails,
//       payload: 'alarm_payload',
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// @pragma('vm:entry-point')
// void onReceive(NotificationResponse response) async {
//   print('action ${response.actionId}');
//   // Decode payload if exists
//   Map<String, dynamic>? payloadData;
//   if (response.payload != null) {
//     try {
//       payloadData = jsonDecode(response.payload!);
//     } catch (_) {}
//   }

//   if (response.actionId == 'stop_alarm') {
//     print('Alarm STOP button pressed (BG/FG)');
//     await flutterLocalNotificationsPlugin.cancelAll();
//   } else if (response.actionId == 'snooze_alarm') {
//     print('Alarm SNOOZE button pressed (BG/FG)');

//     // Snooze for 5 minutes
//     final now = DateTime.now();
//     final String title = payloadData?['title'] ?? 'Alarm';
//     final String message = payloadData?['message'] ?? 'Wake up!';

//     // Reschedule alarm with updated info
//     await CustomAlarm.showAlarmNotification(
//       title: '$title (Snoozed)',
//       message: message,
//       id: (now.millisecondsSinceEpoch ~/ 1000).toString(),
//       payload: jsonEncode({
//         'title': title,
//         'message': message,
//       }),
//     );

//     // Cancel the current notification
//     await flutterLocalNotificationsPlugin.cancel(
//       int.tryParse(response.id.toString()) ?? 0,
//     );
//   }
// }

// class CustomAlarm {
//   static Future<void> init() async {
//     final DarwinInitializationSettings iOSInitSettings = DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       notificationCategories: [
//         DarwinNotificationCategory(
//           'alarm',
//           actions: [
//             DarwinNotificationAction.plain(
//               'stop_alarm',
//               'Close',
//               options: {DarwinNotificationActionOption.destructive},
//             ),
//             DarwinNotificationAction.plain(
//               'snooze_alarm',
//               'Snooze',
//               options: {
//                 DarwinNotificationActionOption.foreground,
//               },
//             ),
//           ],
//         ),
//       ],
//     );

//     final InitializationSettings initializationSettings = InitializationSettings(iOS: iOSInitSettings);

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onReceive,
//       onDidReceiveBackgroundNotificationResponse: onReceive,
//     );
//   }

//   static Future<void> showAlarmNotification({
//     required String? title,
//     required String? message,
//     required String? id,
//     String? payload,
//   }) async {
//     const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
//       sound: 'alarm_new_notification.wav',
//       presentSound: true,
//       presentAlert: true,
//       presentBadge: true,
//       categoryIdentifier: 'alarm',
//       interruptionLevel: InterruptionLevel.critical,
//     );

//     const NotificationDetails platformDetails = NotificationDetails(iOS: darwinNotificationDetails);

//     await flutterLocalNotificationsPlugin.show(
//       int.tryParse(id ?? '0') ?? 0,
//       title ?? 'Alarm',
//       message ?? 'Wake up!',
//       platformDetails,
//       payload: payload ??
//           jsonEncode({
//             'title': title ?? 'Alarm',
//             'message': message ?? 'Wake up!',
//           }),
//     );
//   }
// }
//--------------------------------------
// import 'package:ecommerce_app/res/notification/alarm/alarm_permission.dart';
// import 'package:ecommerce_app/res/notification/push_notification.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// @pragma('vm:entry-point')
// void onReceive(NotificationResponse response) {
//   if (response.actionId == 'stop_alarm') {
//     print('Alarm STOP button pressed (BG)');
//     flutterLocalNotificationsPlugin.cancelAll();
//   }
// }

// class CustomAlarm {
//   AlarmPermissions permissions = AlarmPermissions();
//   LocalNotification notification = LocalNotification();

//   static init() async {
//     const AndroidInitializationSettings androidInitSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

//     final DarwinInitializationSettings iOSInitSettings = DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       notificationCategories: [
//         DarwinNotificationCategory(
//           'mintalarm_channel_id',
//           actions: [
//             DarwinNotificationAction.plain(
//               'CLOSE_ACTION', // unique identifier for the action
//               'Close', // visible title
//               options: <DarwinNotificationActionOption>{
//                 DarwinNotificationActionOption.destructive,
//               },
//             ),
//           ],
//         ),
//       ],
//     );

//     InitializationSettings initializationSettings = InitializationSettings(
//       android: androidInitSettings,
//       iOS: iOSInitSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onReceive,
//       onDidReceiveBackgroundNotificationResponse: onReceive,
//     );
//   }
// static Future<void> setupAlarmChannel() async {
//   const AndroidNotificationChannel alarmChannel = AndroidNotificationChannel(
//     'mintalarm_channel_id', // Same ID as in your showAlarmNotification
//     'Alarm Channel',
//     description: 'Channel for alarm-style notifications',
//     importance: Importance.max,
//     playSound: true,
//     sound: RawResourceAndroidNotificationSound('alarm'),
//   );

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(alarmChannel);
// }

//   static Future<void> showAlarmNotification(
//       {required String? title, required String? message, required String? id}) async {
//     const androidDetails = AndroidNotificationDetails(
//       'mintalarm_channel_id',
//       'Alarm Channel',
//       channelDescription: 'Channel for alarm-style notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       fullScreenIntent: true,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('alarm'),
//       // 🚫 Make it non-dismissible
//       ongoing: true,
//       // keeps it pinned
//       autoCancel: false,
//       // don’t auto-dismiss when tapped
//       onlyAlertOnce: false,
//       // allow repeated sound/vibration

//       icon: '@mipmap/ic_launcher',
//       category: AndroidNotificationCategory.alarm,
//       actions: <AndroidNotificationAction>[
//         AndroidNotificationAction(
//           'stop_alarm',
//           'STOP',
//           showsUserInterface: true,
//           cancelNotification: true,
//         ),
//       ],
//     );

//     const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
//       sound: /*'slow_spring_board.aiff'*/ /*'notification_alarm.aiff'*/"alarm_new_notification.wav",
//       presentSound: true,
//       categoryIdentifier: 'mintalarm_channel_id',
//     );

//     const platformDetails = NotificationDetails(android: androidDetails, iOS: darwinNotificationDetails);

//     await flutterLocalNotificationsPlugin.show(
//       int.tryParse(id.toString()) ?? 0,
//       title ?? 'Alarm',
//       message ?? 'Wake up!',
//       platformDetails,
//       payload: 'alarm_payload',
//     );
//   }
// }

// import 'package:ecommerce_app/data/const/export.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';

// @pragma('vm:entry-point')
// void onAlarmActionReceived(ReceivedAction action) {
//   if (action.buttonKeyPressed == 'stop_alarm') {
//     print('Alarm STOP button pressed (BG)');
//     AwesomeNotifications().cancelAll();
//   }
// }

// class CustomAlarm {
//   static Future<void> init() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: 'mintalarm_channel_id',
//           channelName: 'Alarm Channel',
//           channelDescription: 'Channel for alarm-style notifications',
//           importance: NotificationImportance.Max,
//           playSound: true,
//           soundSource: 'resource://raw/alarm',
//           defaultColor: Colors.red,
//           ledColor: Colors.red,
//           locked: true,
//         )
//       ],
//       debug: true,
//     );

//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onAlarmActionReceived,
//       onNotificationCreatedMethod: (ReceivedNotification notification) async {},
//       onNotificationDisplayedMethod: (ReceivedNotification notification) async {},
//       onDismissActionReceivedMethod: (ReceivedAction action) async {},
//     );
//   }

//   @pragma('vm:entry-point')
//   static Future<void> onAlarmActionReceived(ReceivedAction action) async {
//     if (action.buttonKeyPressed == 'stop_alarm') {
//       print('Alarm STOP button pressed (BG)');
//       await AwesomeNotifications().cancelAll();
//     }
//   }

//   static Future<void> showAlarmNotification({
//     required String? title,
//     required String? message,
//     required String? id,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: int.tryParse(id.toString()) ?? 0,
//         channelKey: 'mintalarm_channel_id',
//         title: title ?? 'Alarm',
//         body: message ?? 'Wake up!',
//         payload: {'alarm': 'true'},
//         category: NotificationCategory.Alarm,
//         autoDismissible: false,
//         wakeUpScreen: true,
//         criticalAlert: true,
//       ),
//       actionButtons: [
//         NotificationActionButton(
//           key: 'stop_alarm',
//           label: 'STOP',
//           actionType: ActionType.DismissAction,
//         ),
//       ],
//     );
//   }
// }

// import 'dart:io';
// import 'package:ecommerce_app/data/const/export.dart';
// import 'package:ecommerce_app/data/models/alarm/get_alarms/alarm_model.dart';
// import 'package:ecommerce_app/res/notification/alarm/alarm_permission.dart';
// import 'package:ecommerce_app/res/notification/push_notification.dart';
// import 'package:alarm/alarm.dart';
// import 'package:alarm/model/volume_settings.dart';
// import 'package:intl/intl.dart';

// class CustomAlarm {
//   AlarmPermissions permissions = AlarmPermissions();
//   LocalNotification notification = LocalNotification();

//   /// Add main alarm
//   addAlarm(AlarmData alarm) async {
//     sPrint.info('startAlarm');
//     bool isCheck = await permissions.checkPermissions();
//     if (isCheck) {
//       String alarmTimeRaw = alarm.alarmTime;
//       late String alarmTime;

//       try {
//         alarmTime =
//             DateFormat("HH:mm").format(DateFormat("HH:mm:ss").parse(alarmTimeRaw));
//       } catch (_) {
//         try {
//           alarmTime =
//               DateFormat("HH:mm").format(DateFormat("HH:mm").parse(alarmTimeRaw));
//         } catch (_) {
//           print("Invalid time format");
//           return;
//         }
//       }

//       List<String> parts = alarmTime.split(":");
//       int hour = int.parse(parts[0]);
//       int minute = int.parse(parts[1]);

//       sPrint.success(alarm.toJson());

//       DateTime? start = DateTime.tryParse(alarm.medicineStartDate ?? "");
//       DateTime? end = DateTime.tryParse(alarm.medicineEndDate ?? "");

//       if (start == null) {
//         sPrint.error("Invalid start date", StackTrace.current);
//         return;
//       }

//       if (Platform.isIOS) {
//         LocalNotification.scheduleDailyAlarms(
//           alarm.id!.toInt(),
//           alarm.userId!.toInt(),
//           start,
//           end,
//           hour,
//           minute,
//           title: alarm.title ?? "",
//           body: alarm.description ?? "",
//         );
//       } else {
//         startAndroidAlarm(
//           alarm.id!.toInt(),
//           alarm.userId!.toInt(),
//           start,
//           end,
//           hour,
//           minute,
//           title: alarm.title ?? "",
//           body: alarm.description ?? "",
//         );
//       }
//     } else {
//       sPrint.error("permission denied", StackTrace.current);
//       showToast("permission denied", MessageErrorType.error);
//     }
//   }

//   /// Start alarm for Android
//   startAndroidAlarm(
//     int id,
//     int userID,
//     DateTime startDate,
//     DateTime? endDate,
//     int hour,
//     int minute, {
//     String title = "",
//     String body = "",
//   }) async {
//     sPrint.info("alarm start $hour:$minute");

//     endDate = endDate ?? startDate;
//     int count = 1;
//     DateTime date =
//         DateTime(startDate.year, startDate.month, startDate.day, hour, minute);

//     do {
//       final alarmSettings = AlarmSettings(
//         id: int.parse("$userID$id$count"),
//         dateTime: date,
//         assetAudioPath: 'assets/alarm.wav',
//         loopAudio: true,
//         allowAlarmOverlap: true,
//         iOSBackgroundAudio: true,
//         vibrate: true,
//         androidFullScreenIntent: true,
//         warningNotificationOnKill: Platform.isIOS,
//         volumeSettings: VolumeSettings.fade(
//           volume: 0.8,
//           fadeDuration: const Duration(seconds: 2),
//           volumeEnforced: true,
//         ),
//        notificationSettings: NotificationSettings(
//   title: title,
//   body: body,
//   stopButton: 'Stop the alarm',

//   snoozeButton: 'Snooze 5 min', // ⏰ زر الغفوة
//   icon: 'ic_launcher',
//   iconColor: Colors.transparent,
// ),

//       );

//       await Alarm.set(alarmSettings: alarmSettings);

//       sPrint.info('alarm:: $userID$id  $count $date');
//       count++;
//       date = date.add(const Duration(days: 1));
//     } while (date.isBefore(endDate) && count < 10);

//     sPrint.success('end alarm');
//   }

//   /// 🔁 Snooze alarm by 5 minutes
//   Future<void> snoozeAlarm(AlarmSettings currentAlarm, {int minutes = 5}) async {
//     DateTime snoozeTime = DateTime.now().add(Duration(minutes: minutes));

//     final snoozeSettings = AlarmSettings(
//       id: currentAlarm.id + 9999,
//       dateTime: snoozeTime,
//       assetAudioPath: currentAlarm.assetAudioPath,
//       loopAudio: currentAlarm.loopAudio,
//       allowAlarmOverlap: currentAlarm.allowAlarmOverlap,
//       iOSBackgroundAudio: currentAlarm.iOSBackgroundAudio,
//       vibrate: currentAlarm.vibrate,
//       androidFullScreenIntent: currentAlarm.androidFullScreenIntent,
//       warningNotificationOnKill: currentAlarm.warningNotificationOnKill,
//       volumeSettings: currentAlarm.volumeSettings,
//       notificationSettings: currentAlarm.notificationSettings!.copyWith(
//         title: "Snoozed: ${currentAlarm.notificationSettings?.title ?? ''}",
//         body: "This is a snoozed alarm",
//       ),
//     );

//     await Alarm.set(alarmSettings: snoozeSettings);
//     sPrint.success("Snoozed alarm set for ${snoozeTime.toLocal()}");
//   }

//   void getAllAlarms() {
//     sPrint.info('get all alarms');
//     Alarm.getAlarms().asStream().listen((value) {
//       for (var e in value) {
//         sPrint.warning(e.toJson());
//       }
//     });
//   }

//   void clearAll() {
//     Alarm.stopAll();
//     sPrint.success('All alarms stopped');
//   }
// }
