import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/data/provider/db_provider.dart';
import 'package:my_restaurant/ui/home_page.dart';
import 'package:my_restaurant/utils/result_state.dart';
import 'package:my_restaurant/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = '/favorite_page';
  static const String FavoritesTitle = 'Favorite';
  final String restaurant;

  const FavoritesPage({Key key, this.restaurant}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF545D68),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '$FavoritesTitle',
          style: TextStyle(
              fontFamily: 'Varela', fontSize: 20.0, color: Color(0xFF545D68)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Color(0xFF545D68),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(FavoritesTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return RestoItem(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}