import 'package:flutter/material.dart';
import 'package:my_restaurant/ui/detail_page.dart';
import 'package:my_restaurant/restaurant.dart';
import 'package:my_restaurant/ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Restaurant',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                ModalRoute.of(context).settings.arguments,
                  // ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}

