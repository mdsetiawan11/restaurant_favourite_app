import 'dart:ui';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:restaurant_favourite_app/main.dart';
import 'package:restaurant_favourite_app/src/helpers/notification_helper.dart';
import 'package:restaurant_favourite_app/src/services/restaurant_services.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm launched!');
    }
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await RestaurantServices().getRestaurantList();
    await notificationHelper.showNotificationPic(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
