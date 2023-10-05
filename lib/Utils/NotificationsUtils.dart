// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// const _channelName = "CounterAttackChannel";
// const _channelID = "CounterAttackChannelID";
// const _channelDescription = "CounterAttackChannelDesc";
//
// class NotificationsUtils {
//
//   static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
//   static AndroidNotificationDetails? androidNotificationDetails;
//
//   NotificationsUtils(){
//     _setupNotifications();
//   }
//
//   static Future _setupNotifications() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
//     final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin?.initialize(initializationSettings);
//
//     androidNotificationDetails = AndroidNotificationDetails(_channelID, _channelName, _channelDescription,
//     importance: Importance.max,
//     priority: Priority.high,
//     sound: UriAndroidNotificationSound("assets/images/refree_whistle.mp3"),
//     playSound: true,
//     ticker: 'ticker');
//   }
//
//   static void showNotification(String title,String body , {String? dataJson}) async {
//
//     if(androidNotificationDetails == null){
//      await _setupNotifications();
//     }
//
//     NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin?.show(0, title , body, notificationDetails, payload: dataJson);
//   }
// }