import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_restaurant/detail_page.dart';
import 'package:my_restaurant/restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => NewsListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
      },
    );
  }
}


class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Restaurant'),
      ),
      body: FutureBuilder<String>(
        future:
        DefaultAssetBundle.of(context).loadString('assets/restaurants.json'),
        builder: (context, snapshot) {
          // final restaurants = restaurantFromJson('assets/restaurants.json');
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }
}


Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
 return InkWell(
   onTap: () {
     Navigator.pushNamed(context, RestaurantDetailPage.routeName,
         arguments: restaurant);
   },
   child: Card(
     child: Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         Expanded(flex: 1, child: Image.network(restaurant.imageAsset)),
         Expanded(
           flex: 2,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                Text(restaurant.name),
                 SizedBox(
                   height: 10,
                 ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Icon(Icons.location_on,),
                     Text(
                       restaurant.address,
                     )
                   ],
                 ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Icon(Icons.star_rate,
                       color: Colors.yellow,),
                     Text(
                       restaurant.rating,
                     )
                   ],
                 ),
               ],
             ),
           ),
         )
       ],
     ),
   ),
 );

  // return ListTile(
  //   contentPadding:
  //   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //   leading: Image.network(
  //     restaurant.imageAsset,
  //     width: 100,
  //     height: 100,
  //   ),
  //   title: Text(restaurant.name),
  //   subtitle: Text(restaurant.address),
  //
  // );
}

