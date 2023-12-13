import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_favourite_app/src/helpers/database_helper.dart';
import 'package:restaurant_favourite_app/src/helpers/notification_helper.dart';
import 'package:restaurant_favourite_app/src/helpers/preferences_helper.dart';
import 'package:restaurant_favourite_app/src/providers/database_provider.dart';
import 'package:restaurant_favourite_app/src/providers/preferences_provider.dart';
import 'package:restaurant_favourite_app/src/providers/restaurant_detail_provider.dart';
import 'package:restaurant_favourite_app/src/providers/restaurant_list_provider.dart';
import 'package:restaurant_favourite_app/src/screens/bottom_nav_bar.dart';
import 'package:restaurant_favourite_app/src/screens/detail.dart';
import 'package:restaurant_favourite_app/src/screens/restaurant_detail.dart';
import 'package:restaurant_favourite_app/src/screens/splash.dart';
import 'package:restaurant_favourite_app/src/services/restaurant_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'home',
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const BottomNavBar();
          },
        ),
        GoRoute(
          name: 'detailpage',
          path: 'detailpage',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailPage();
          },
        ),
        GoRoute(
          name: "detail",
          path: 'detail/:id',
          builder: (context, state) {
            String id = state.pathParameters['id']!;
            return ChangeNotifierProvider<RestaurantDetailProvider>(
              create: (_) => RestaurantDetailProvider(
                  restaurantServices: RestaurantServices(), id: id),
              child: RestaurantDetailScreen(id: id),
            );
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) =>
              RestaurantListProvider(restaurantServices: RestaurantServices()),
        ),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                    preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance(),
                ))),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
