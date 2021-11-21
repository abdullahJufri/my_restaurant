import 'package:flutter/material.dart';
import 'package:my_restaurant/data/api/api_service.dart';
import 'package:my_restaurant/data/model/restaurant_model.dart';
import 'package:my_restaurant/data/provider/restaurant_provider.dart';
import 'package:my_restaurant/ui/detail_page.dart';
import 'package:my_restaurant/ui/search.dart';
import 'package:provider/provider.dart';
// import 'package:my_restaurant/restaurant.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/article_list';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoProvider>(
      create: (_) => RestoProvider(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'My Restaurant',
            style: TextStyle(
                fontFamily: 'Varela', fontSize: 20.0, color: Color(0xFF545D68)),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xFF545D68),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, SearchPage.routeName))
          ],
        ),
        body: Consumer<RestoProvider>(builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.HasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                return RestoItem(
                  restaurant: state.result.restaurants[index],
                );
              },
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.NoConnection) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.message,
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey)),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                    onPressed: () => state.refresh(),
                    color: Colors.grey[200],
                    child: Text('Refresh'),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        }),
      ),
    );
  }
}

class RestoItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestoItem({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant.id);
        },
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                        ApiService.smallImage + restaurant.pictureId),
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                          ),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rate,
                            color: Colors.yellow,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.subtitle2,
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
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Image.network(
                    ApiService.smallImage + restaurant.pictureId)),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                        ),
                        Text(
                          restaurant.city,
                          style: Theme.of(context).textTheme.subtitle2,
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellow,
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.subtitle2,
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
    ),
  );
}
