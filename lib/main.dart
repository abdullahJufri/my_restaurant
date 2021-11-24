import 'package:flutter/material.dart';
import 'package:my_restaurant/data/db/db_helper.dart';
import 'package:my_restaurant/data/provider/db_provider.dart';
import 'package:my_restaurant/ui/detail_page.dart';
import 'package:my_restaurant/ui/favorite_page.dart';
import 'package:my_restaurant/ui/home_page.dart';
import 'package:my_restaurant/ui/search.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
        ],
        child: MaterialApp(
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
            SearchPage.routeName: (context) => SearchPage(),
            BookmarksPage.routeName: (context) => BookmarksPage(),
            RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant: ModalRoute.of(context).settings.arguments,
// ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
          },
        ));
  }
}
