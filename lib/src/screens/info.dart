import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_favourite_app/main.dart';
import 'package:restaurant_favourite_app/src/helpers/notification_helper.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        context, 'detailpage');
    _notificationHelper.configureDidReceiveLocalNotificationSubject(
        context, 'detailpage');
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Lottie.asset(
                  'assets/developer.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                const Text(
                  'Aplikasi dibuat oleh Muhammad Dadang Setiawan untuk memenuhi tugas proyek 3 pada kelas Belajar Fundamental Aplikasi Flutter - Dicoding.com',
                  textAlign: TextAlign.center,
                ),
                MaterialButton(
                  onPressed: () async {
                    await _notificationHelper
                        .showNotification(flutterLocalNotificationsPlugin);
                  },
                  child: const Text('Button'),
                )
              ],
            ),
          )),
    );
  }
}
