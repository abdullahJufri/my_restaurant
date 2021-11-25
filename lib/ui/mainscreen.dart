import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/data/provider/scheduling_provider.dart';
import 'package:my_restaurant/cummon/styles.dart';
import 'package:my_restaurant/ui/detail_page.dart';
import 'package:my_restaurant/ui/favorite_page.dart';
import 'package:my_restaurant/ui/home_page.dart';

import 'package:my_restaurant/ui/setting_page.dart';
import 'package:my_restaurant/utils/notification_helper.dart';
import 'package:my_restaurant/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    HomePage(),
    const FavoritesPage() ,
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: SettingsPage(),
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final _items = <Widget>[
    const Icon(
      Icons.home_rounded,
      size: 30,
    ),
    const Icon(
      Icons.favorite_rounded,
      size: 30,
    ),
    const Icon(
      Icons.settings_rounded,
      size: 30,
    ),
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: kWhiteColor),
        ),
        child: CurvedNavigationBar(
          color: Orange200,
          buttonBackgroundColor: Orange200,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          height: 60,
          items: _items,
          index: _bottomNavIndex,
          onTap: _onBottomNavTapped,
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return Container(
      color: Orange200,
      child: SafeArea(
        top: false,
        child: ClipRRect(
          child: Scaffold(
            extendBody: true,
            body: _listWidget[_bottomNavIndex],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: kWhiteColor),
              ),
              child: CurvedNavigationBar(
                color: Orange200,
                buttonBackgroundColor: kGrad,
                backgroundColor: Colors.transparent,
                animationCurve: Curves.easeInOutCirc,
                animationDuration: const Duration(milliseconds: 200),
                height: 60,
                items: _items,
                index: _bottomNavIndex,
                onTap: _onBottomNavTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailPage.routeName);
  }
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
