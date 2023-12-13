import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_favourite_app/src/helpers/preferences_helper.dart';
import 'package:restaurant_favourite_app/src/helpers/time_helper.dart';
import 'package:restaurant_favourite_app/src/utils/background_services.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyReminderPreferences();
  }
  bool _isDailyReminderActive = false;
  bool get isDailyReminderActive => _isDailyReminderActive;

  void _getDailyReminderPreferences() async {
    _isDailyReminderActive = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  Future<bool> enableDailyReminder(bool value) async {
    _isDailyReminderActive = value;
    preferencesHelper.setDailyReminder(value);
    notifyListeners();
    if (_isDailyReminderActive) {
      if (kDebugMode) {
        print('Daily Reminder Active');
      }
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24), 1, BackgroundService.callback,
          startAt: TimeHelper.format(), exact: true, wakeup: true);
    } else {
      if (kDebugMode) {
        print('Scheduling Restaurant Canceled');
      }
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
