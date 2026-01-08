
// import 'dart:io';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// const String alarmChannel = 'mint_alarm_channel';
// const String alarmSound = "alarm";

// class CustomAlarmAwesome {

//   static const int snoozeMinutes = 1;
//   static const int maxSnoozeCount = 3; //0 1 2

//   static Future<void> init() async {
//     await _initializeNotificationChannel();

//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: _onActionReceived,
//     );
//   }

//   static Future<void> _initializeNotificationChannel() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: alarmChannel,
//           channelName: 'Mint Alarm Channel',
//           channelDescription: 'High priority channel for alarm notifications',
//           importance: NotificationImportance.Max,
//           playSound: true,
//           soundSource: 'resource://raw/$alarmSound',
//           defaultRingtoneType: DefaultRingtoneType.Alarm,
//           criticalAlerts: true,
//           locked: true,
//           enableVibration: true,
//           enableLights: true,
//           ledColor: Colors.red,
//         )
//       ],
//       debug: true,
//     );
//   }

//   static Future<void> requestPermissions() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) {
//       await AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//     if (Platform.isAndroid) {
//       if (await Permission.scheduleExactAlarm.isDenied) {
//         await Permission.scheduleExactAlarm.request();
//       }
      
//       if (await Permission.ignoreBatteryOptimizations.isDenied) {
//         await Permission.ignoreBatteryOptimizations.request();
//       }
//     }
//   }

//   @pragma("vm:entry-point")
//   static Future<void> _onActionReceived(ReceivedAction receivedAction) async {

//     try {
//       final payload = receivedAction.payload ?? {};
//       final notificationId = int.tryParse(payload['id'] ?? '') ?? receivedAction.id ?? 0;
//       final currentSnoozeCount = int.tryParse(payload['snooze_count'] ?? '0') ?? 0;

//       switch (receivedAction.buttonKeyPressed) {
//   case 'snooze_alarm':
//     await handleSnooze(
//       title: payload['title'] ?? 'Alarm',
//       message: payload['message'] ?? 'Wake up!',
//       currentSnoozeCount: currentSnoozeCount,
//       currentId: notificationId,
//   );
//     break;

//   case 'stop_alarm':
//     await AwesomeNotifications().cancelAll();
//     debugPrint('🚨 Alarm stopped by user.');
//     break;
// }
//     } catch (e, st) {
//       debugPrint('❌ Error in _onActionReceived: $e\n$st');
//     }
//   }

//   static Future<void> showAlarmNotification({
//     required String? id,
//     required String? title,
//     required String? message,
//     DateTime? scheduleTime,
//     int? intervalSeconds,
//     int currentSnoozeCount = 0,
//   }) async {
//     await AwesomeNotifications().cancelAll();
//     debugPrint('🗑️ Cancelled all existing notifications before creating new alarm');

//     final payload = {
//       'title': title ?? 'Alarm',
//       'message': message ?? 'Wake up!',
//       'id': id.toString(),
//       'snooze_count': currentSnoozeCount.toString(),
//     };
//     print("payload background ${payload}");

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: int.tryParse(id ?? '') ?? 0,
//         channelKey: alarmChannel,
//         title: title ?? 'Alarm',
//         body: message ?? 'Wake up!',
//         payload: payload,
//         category: NotificationCategory.Alarm,
//         wakeUpScreen: true,
//         criticalAlert: true,
//         displayOnBackground: true,
//         displayOnForeground: true,
//         fullScreenIntent: true,
//         locked: false,
//         autoDismissible: false, // ✅ Changed to false for alarms
//         backgroundColor: Colors.black,
//       ),
//       actionButtons: [
//          if (currentSnoozeCount < maxSnoozeCount)
//         NotificationActionButton(
//           key: 'snooze_alarm',
//           label: 'SNOOZE ($snoozeMinutes min)',
//           actionType: ActionType.Default,
//           autoDismissible: false,
//           color: const Color.fromARGB(255, 128, 223, 177),
//         ), 
//         NotificationActionButton(
//           key: 'stop_alarm',
//           label: 'STOP',
//           actionType: ActionType.Default, // ✅ Changed from DismissAction
//           autoDismissible: true,
//           color: const Color.fromARGB(255, 181, 44, 34),
//         ),
//       ],
//       schedule: scheduleTime != null
//           ? NotificationCalendar.fromDate(
//               date: scheduleTime,
//               repeats: false,
//               allowWhileIdle: true,
//               preciseAlarm: true, // ✅ Added for better scheduling
//             )
//           : (intervalSeconds != null
//               ? NotificationInterval(
//                   interval: Duration(seconds: intervalSeconds),
//                   timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//                   repeats: false,
//                   allowWhileIdle: true,
//                 )
//               : null),
//     );
    
//     debugPrint('✅ Alarm notification created successfully');
//   }

//   static Future<void> handleSnooze({
//     required String title,
//     required String message,
//     required int currentSnoozeCount,
//     required int currentId,
//   }) async {
//     await AwesomeNotifications().cancelAll();
//     debugPrint('🗑️ Cancelled all existing alarms before snoozing');

//     final newSnoozeCount = currentSnoozeCount + 1;
//     final snoozedId = DateTime.now().millisecondsSinceEpoch % 2147483647;

//     // ✅ Create payload with updated snooze count
//     final payload = {
//       'title': title,
//       'message': message,
//       'id': snoozedId.toString(),
//       'snooze_count': newSnoozeCount.toString(),
//     };

//     debugPrint(' Creating snooze alarm (${newSnoozeCount}/$maxSnoozeCount)');

//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//         id: snoozedId,
//         channelKey: alarmChannel,
//         title: title,
//         body: message,
//         payload: payload,
//         category: NotificationCategory.Alarm,
//         wakeUpScreen: true,
//         criticalAlert: true,
//         fullScreenIntent: true,
//         locked: true,
//         autoDismissible: false,
//         displayOnForeground: true,
//         displayOnBackground: true,
//         notificationLayout: NotificationLayout.Default,
//         backgroundColor: Colors.black,
//       ),
//       // ✅ الشرط الصحيح: إذا كان العدد الجديد أقل من الحد الأقصى، اعرض زر SNOOZE
//       actionButtons: [
//         if (newSnoozeCount < maxSnoozeCount)
//         NotificationActionButton(
//           key: 'snooze_alarm',
//           label: 'SNOOZE ($snoozeMinutes min)',
//           actionType: ActionType.Default,
//           autoDismissible: false,
//           color: const Color.fromARGB(255, 128, 223, 177),
//         ),
//         NotificationActionButton(
//           key: 'stop_alarm',
//           label: 'STOP',
//           actionType: ActionType.Default, // ✅ Changed from DismissAction
//           autoDismissible: true,
//           color: const Color.fromARGB(255, 181, 44, 34),
//         ),
//       ],
//       schedule: NotificationCalendar.fromDate(
//         date: DateTime.now().add(Duration(minutes: snoozeMinutes)),
//         preciseAlarm: true,
//         allowWhileIdle: true,
//       ),
//     );
//     debugPrint('✅ Snooze alarm scheduled for ${DateTime.now().add(Duration(minutes: snoozeMinutes))}');
//   }

//   static Future<void> cancelAlarm(int id) async {
//     await AwesomeNotifications().cancel(id);
//     debugPrint('❌ Alarm with ID $id cancelled.');
//   }
// }




// import 'dart:io';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:device_info_plus/device_info_plus.dart';

// const String alarmChannel = 'mint_alarm_channel';
// const String alarmSound = "alarm";

// class CustomAlarmAwesome {
//   static const int snoozeMinutes = 1;
//   static const int maxSnoozeCount = 3;

//   static Future<void> init() async {
//     await _initializeNotificationChannel();

//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: _onActionReceived,
//     );
//   }

//   static Future<void> _initializeNotificationChannel() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: alarmChannel,
//           channelName: 'Mint Alarm Channel',
//           channelDescription: 'High priority channel for alarm notifications',
//           importance: NotificationImportance.Max,
//           playSound: true,
//           soundSource: 'resource://raw/$alarmSound',
//           defaultRingtoneType: DefaultRingtoneType.Alarm,
//           criticalAlerts: true,
//           locked: true,
//           enableVibration: true,
//           enableLights: true,
//           ledColor: Colors.red,
//         )
//       ],
//       debug: true,
//     );
//   }

//   static Future<void> requestPermissions() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) {
//       await AwesomeNotifications().requestPermissionToSendNotifications();
//     }

//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;

//       // if (androidInfo.version.sdkInt == 31) {
//       //   if (await Permission.scheduleExactAlarm.isDenied) {
//       //     await Permission.scheduleExactAlarm.request();
//       //   }
//       //   if (await Permission.ignoreBatteryOptimizations.isDenied) {
//       //     await Permission.ignoreBatteryOptimizations.request();
//       //   }
//       // }
//     }
//   }

//   @pragma("vm:entry-point")
//   static Future<void> _onActionReceived(ReceivedAction receivedAction) async {
//     try {
//       final payload = receivedAction.payload ?? {};
//       final notificationId = int.tryParse(payload['id'] ?? '') ??
//           receivedAction.id ??
//           0;
//       final currentSnoozeCount =
//           int.tryParse(payload['snooze_count'] ?? '0') ?? 0;

//       switch (receivedAction.buttonKeyPressed) {
//         case 'snooze_alarm':
//           await handleSnooze(
//             title: payload['title'] ?? 'Alarm',
//             message: payload['message'] ?? 'Wake up!',
//             currentSnoozeCount: currentSnoozeCount,
//             currentId: notificationId,
//           );
//           break;

//         case 'stop_alarm':
//         //  await AwesomeNotifications().cancelAll();
//           debugPrint('🚨 Alarm stopped by user.');
//           break;
//       }
//     } catch (e, st) {
//       debugPrint('❌ Error in _onActionReceived: $e\n$st');
//     }
//   }

//   /// ✅ نسخة موحدة - تتحقق من Android 12
//   static Future<void> showAlarmNotification({
//     required String? id,
//     required String? title,
//     required String? message,
//     DateTime? scheduleTime,
//     int? intervalSeconds,
//     int currentSnoozeCount = 0,
//   }) async {
//     await AwesomeNotifications().cancelAll();
//     debugPrint('🗑️ Cancelled all existing notifications before creating new alarm');

//     final payload = {
//       'title': title ?? 'Alarm',
//       'message': message ?? 'Wake up!',
//       'id': id.toString(),
//       'snooze_count': currentSnoozeCount.toString(),
//     };

//     final androidInfo = await DeviceInfoPlugin().androidInfo;
//     final isAndroid12 = Platform.isAndroid && androidInfo.version.sdkInt == 31;

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: int.tryParse(id ?? '') ?? 0,
//         channelKey: alarmChannel,
//         title: title ?? 'Alarm',
//         body: message ?? 'Wake up!',
//         payload: payload,
//         category: NotificationCategory.Alarm,
//         wakeUpScreen: true,
//         criticalAlert: true,
//         displayOnBackground: true,
//         displayOnForeground: true,
//         fullScreenIntent: true,
//         locked: false,
//         autoDismissible: false,
//         backgroundColor: Colors.black,
//       ),
//       actionButtons: [
//         if (currentSnoozeCount < maxSnoozeCount)
//           NotificationActionButton(
//             key: 'snooze_alarm',
//             label: 'SNOOZE ($snoozeMinutes min)',
//             actionType: ActionType.Default,
//             autoDismissible: false,
//             color: const Color.fromARGB(255, 128, 223, 177),
//           ),
//         NotificationActionButton(
//           key: 'stop_alarm',
//           label: 'STOP',
//           actionType: ActionType.Default,
//           autoDismissible: true,
//           color: const Color.fromARGB(255, 181, 44, 34),
//         ),
//       ],
//       schedule: scheduleTime != null
//           ? NotificationCalendar.fromDate(
//               date: scheduleTime,
//               repeats: false,
//               allowWhileIdle: true,
//               preciseAlarm: isAndroid12 ? true : false, // ✅ خاص لأندرويد 12
//             )
//           : (intervalSeconds != null
//               ? NotificationInterval(
//                   interval: Duration(seconds: intervalSeconds),
//                   timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//                   repeats: false,
//                   allowWhileIdle: true,
//                 )
//               : null),
//     );

//     debugPrint('✅ Alarm notification created successfully');
//   }

//   static Future<void> handleSnooze({
//     required String title,
//     required String message,
//     required int currentSnoozeCount,
//     required int currentId,
//   }) async {
//     await AwesomeNotifications().cancelAll();
//     final newSnoozeCount = currentSnoozeCount + 1;
//     final snoozedId = DateTime.now().millisecondsSinceEpoch % 2147483647;

//     final payload = {
//       'title': title,
//       'message': message,
//       'id': snoozedId.toString(),
//       'snooze_count': newSnoozeCount.toString(),
//     };

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: snoozedId,
//         channelKey: alarmChannel,
//         title: title,
//         body: message,
//         payload: payload,
//         category: NotificationCategory.Alarm,
//         wakeUpScreen: true,
//         criticalAlert: true,
//         fullScreenIntent: true,
//         locked: true,
//         autoDismissible: false,
//         displayOnForeground: true,
//         displayOnBackground: true,
//         notificationLayout: NotificationLayout.Default,
//         backgroundColor: Colors.black,
//       ),
//       actionButtons: [
//         if (newSnoozeCount < maxSnoozeCount)
//           NotificationActionButton(
//             key: 'snooze_alarm',
//             label: 'SNOOZE ($snoozeMinutes min)',
//             actionType: ActionType.Default,
//             autoDismissible: false,
//             color: const Color.fromARGB(255, 128, 223, 177),
//           ),
//         NotificationActionButton(
//           key: 'stop_alarm',
//           label: 'STOP',
//           actionType: ActionType.Default,
//           autoDismissible: true,
//           color: const Color.fromARGB(255, 181, 44, 34),
//         ),
//       ],
//       schedule: NotificationCalendar.fromDate(
//         date: DateTime.now().add(Duration(minutes: snoozeMinutes)),
//         preciseAlarm: true,
//         allowWhileIdle: true,
//       ),
//     );
//   }

//   static Future<void> cancelAlarm(int id) async {
//     await AwesomeNotifications().cancel(id);
//   }
// }

