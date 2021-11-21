import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/data/api/api_service.dart';
import 'package:my_restaurant/data/provider/restaurant_detail_provider.dart';
import 'package:my_restaurant/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/detail_restaurant';

  final String restaurant;
  const RestaurantDetailPage({Key key, this.restaurant}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {

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

      body: ChangeNotifierProvider<RestoDetailProvider>(
        create: (_) => RestoDetailProvider(context, id: widget.restaurant),
        child: Consumer<RestoDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        ApiService.largeImage + state.result.restaurant.pictureId,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.result.restaurant.name,
                              style: Theme.of(context).textTheme.headline5,

                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on),
                                  Text(state.result.restaurant.city,
                                    style: Theme.of(context).textTheme.subtitle1,),
                                ]
                            ),
                            Divider(color: Colors.grey),
                            Text(state.result.restaurant.description,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Divider(color: Colors.grey),
                            Text('FOOD MENU',
                              style: Theme.of(context).textTheme.subtitle2,),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: state.result.restaurant.menus.foods.map((menusFood) => Container(
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
                                children: state.result.restaurant.menus.drinks.map((MenusFood) => Container(
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
            // (
                // headerSliverBuilder: (context, isScrolled) {
                //   final state = Provider.of<RestoDetailProvider>(context);
                //   return SliverAppBar(
                //     expandedHeight: 200,
                //     flexibleSpace: FlexibleSpaceBar(
                //       background: Hero(
                //           tag: state.result.restaurant.id, child: Image.network(
                //         ApiService.largeImage + state.result.restaurant.pictureId,
                //         fit: BoxFit.cover,
                //       )),
                //     ),
                //   );
                // },

              // );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.NoConnection) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    SizedBox(height: 30),
                    RaisedButton(
                      onPressed: () => state.refresh(),
                      color: Colors.blue[200],
                      child: Text('Refresh'),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}

