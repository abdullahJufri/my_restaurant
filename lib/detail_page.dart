import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Restaurant restaurant;
  const RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
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
          'My Restaurant',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(restaurant.pictureId),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      Text(restaurant.city),
                    ]
                  ),
                  Divider(color: Colors.grey),
                  Text(restaurant.description),
                  Divider(color: Colors.grey),
                  Text('FOOD MENU'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: restaurant.menus.foods.map((MenusFood) => Container(
                      child: Text(
                        MenusFood.name
                      ),
                    )).toList()
                  ),
                  Divider(color: Colors.grey),
                  Text("DRINK MENU:"),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: restaurant.menus.drinks.map((MenusFood) => Container(
                        child: Text(
                            MenusFood.name
                        ),
                      )).toList()
                  ),

                  // Container(
                  //   height: 250,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: restaurant.menus.foods.map((url) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               height: 130,
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 child: Image.network(url),
                  //               ),
                  //             ),

                            // Text(restaurant.menu.map((Restaurant) => null))
                  //           ],
                  //
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  // ListView(
                  //   scrollDirection: Axis.horizontal,
                  //   children: restaurant.menu.map((String) {
                  //     return Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             height: 130,
                  //             child: Text(String),
                  //           ),
                  //
                  //           // Text(restaurant.menu.map((Restaurant) => null))
                  //         ],
                  //
                  //       ),
                  //     );
                  //   }).toList(),
                  // )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
