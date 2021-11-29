import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_restaurant/cummon/navigation.dart';
import 'package:my_restaurant/data/db/db_helper.dart';
import 'package:my_restaurant/data/preferences/preferences_helper.dart';
import 'package:my_restaurant/data/provider/db_provider.dart';
import 'package:my_restaurant/data/provider/prefreces_provider.dart';
import 'package:my_restaurant/data/provider/restaurant_provider.dart';
import 'package:my_restaurant/data/provider/scheduling_provider.dart';
import 'package:my_restaurant/ui/detail_page.dart';
import 'package:my_restaurant/ui/favorite_page.dart';
import 'package:my_restaurant/ui/home_page.dart';
import 'package:my_restaurant/ui/mainscreen.dart';
import 'package:my_restaurant/ui/search.dart';
import 'package:my_restaurant/ui/setting_page.dart';
import 'package:my_restaurant/utils/background_service.dart';
import 'package:my_restaurant/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RestoProvider>(
              create: (_) => RestoProvider(context)),
          ChangeNotifierProvider<SchedulingProvider>(
              create: (_) => SchedulingProvider()),
          ChangeNotifierProvider<PreferencesProvider>(
              create: (_) => PreferencesProvider(
                  preferencesHelper: PreferencesHelper(
                      sharedPreferences: SharedPreferences.getInstance()))),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
        ],
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              title: 'My Restaurant',
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  elevation: 0,
                ),
                scaffoldBackgroundColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              navigatorKey: navigatorKey,
              initialRoute: MainScreen.routeName,
              routes: {
                MainScreen.routeName: (context) => MainScreen(),
                HomePage.routeName: (context) => HomePage(),
                SearchPage.routeName: (context) => SearchPage(),
                SettingPage.routeName: (context) => SettingPage(),
                FavoritesPage.routeName: (context) => FavoritesPage(),
                RestaurantDetailPage.routeName: (context) =>
                    RestaurantDetailPage(
                      restaurant: ModalRoute.of(context).settings.arguments,
// ModalRoute.of(context)?.settings.arguments as Restaurant,
                    ),
              },
            );
          },
        ));
  }
}
