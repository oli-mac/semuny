import 'dart:ffi';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      // null,
      'resource://drawable/logo',
      [
        NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint(
        '----------Notification created------------: ${receivedNotification.id}');
    print('Notification created: ${receivedNotification.id}');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint(
        '----------------Notification displayed-----------: ${receivedNotification.id}');
    print('Notification displayed: ${receivedNotification.id}');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('----------Action dismissed-------: ${receivedAction.id}');
    print('Action dismissed: ${receivedAction.id}');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint(
        '---------------------Action received------------: ${receivedAction.id}');
    print(
        '---------------------Action received------------: ${receivedAction.id}');
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? notificationCat,
    final String? icon, // Added parameter for icon
    final Color? color, // Added parameter for color
    final List<NotificationActionButton>? actionButtons,
    final String? bigPicture,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        category: notificationCat,
        payload: payload,
        summary: summary,
        icon: icon, // Use the icon parameter
        color: color, // Use the color parameter
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true)
          : null,
    );
  }
}


























// import 'dart:ffi';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class NotificationService {
//   static Future<void> initializeNotification() async {
//     await AwesomeNotifications().initialize(
//       null, //drawable/res_app_icon
//       [
//         NotificationChannel(
//           channelKey: 'high_importance_channel',
//           channelName: 'Basic notifications',
//           channelDescription: 'Notification channel for basic tests',
//           defaultColor: Color(0xFF9D50DD),
//           ledColor: Colors.white,
//           importance: NotificationImportance.Max,
//           channelShowBadge: true,
//           onlyAlertOnce: true,
//           playSound: true,
//           criticalAlerts: true,
//         )
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupKey: 'high_importance_channel_group',
//           channelGroupName: 'Group 1',
//         )
//       ],
//       debug: true,
//     );

//     await AwesomeNotifications()
//         .isNotificationAllowed()
//         .then((isAllowed) async {
//       if (!isAllowed) {
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });

//     await AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationCreatedMethod: onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod: onDismissActionReceivedMethod,
//     );
//   }

//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint(
//         '----------Notification created------------: ${receivedNotification.id}');
//     print('Notification created: ${receivedNotification.id}');
//   }

//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint(
//         '----------------Notification displayed-----------: ${receivedNotification.id}');
//     print('Notification displayed: ${receivedNotification.id}');
//   }

//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     debugPrint('----------Action dismissed-------: ${receivedAction.id}');
//     print('Action dismissed: ${receivedAction.id}');
//   }

//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     debugPrint(
//         '---------------------Action received------------: ${receivedAction.id}');
//     // final payload = receivedAction.payload ?? {};
//     // if (payload['navigate'] == "true") {
//     //   Notification.navigatorKey.currentState?.push(MaterialPageRoute(
//     //     builder: (_) => Notifiaction(),
//     //   ));
//     // }
//     print(
//         '---------------------Action received------------: ${receivedAction.id}');
//   }

//   static Future<void> showNotification({
//     required final String title,
//     required final String body,
//     final String? summary,
//     final Map<String, String>? payload,
//     final ActionType actionType = ActionType.Default,
//     final NotificationLayout notificationLayout = NotificationLayout.Default,
//     final NotificationCategory? notificationCat,
//     final String? icon,
//     final List<NotificationActionButton>? actionButtons,
//     final String? bigPicture,
//     final bool scheduled = false,
//     final int? interval,
//   }) async {
//     assert(!scheduled || (scheduled && interval != null));

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: -1,
//         channelKey: 'high_importance_channel',
//         title: title,
//         body: body,
//         actionType: actionType,
//         notificationLayout: notificationLayout,
//         category: notificationCat,
//         payload: payload,
//         summary: summary,
//         icon: icon,
//         bigPicture: bigPicture,
//       ),
//       actionButtons: actionButtons,
//       schedule: scheduled
//           ? NotificationInterval(
//               interval: interval,
//               timeZone:
//                   await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//               preciseAlarm: true)
//           : null,
//     );
//   }
// }
