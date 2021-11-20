import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Restaurant restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

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
                    style: Theme.of(context).textTheme.headline5,

                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      Text(restaurant.city,
                        style: Theme.of(context).textTheme.subtitle1,),
                    ]
                  ),
                  Divider(color: Colors.grey),
                  Text(restaurant.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Divider(color: Colors.grey),
                  Text('FOOD MENU',
                    style: Theme.of(context).textTheme.subtitle2,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: restaurant.menus.foods.map((menusFood) => Container(
                      child: Text(
                        menusFood.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )).toList()
                  ),
                  Divider(color: Colors.grey),
                  Text("DRINK MENU:",
                    style: Theme.of(context).textTheme.subtitle2,),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: restaurant.menus.drinks.map((MenusFood) => Container(
                        child: Text(
                            MenusFood.name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      )).toList()
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
