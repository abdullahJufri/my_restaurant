import 'package:flutter/material.dart';
import 'package:my_restaurant/data/provider/restaurant_provider.dart';
import 'package:my_restaurant/ui/home_page.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _tecSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoProvider>(
      create: (_) => RestoProvider(context),
      child:
          SafeArea(
            child: Scaffold(body: Consumer<RestoProvider>(builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    return RestoItem(
                      restaurant: state.result.restaurants[index],
                    );
                  },
                  padding: EdgeInsets.only(top: kToolbarHeight + 24),
                  shrinkWrap: true,
                ),
                _searchAppbar(context, state)
              ],
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
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                    onPressed: () => state.refresh(),
                    color: Colors.amber,
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
      })),
          ),
    );
  }

  Container _searchAppbar(BuildContext context, RestoProvider state) {
    return Container(
        height: kToolbarHeight + 20,
        padding: EdgeInsets.only(top: 25),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: TextField(
            controller: _tecSearch,
            textInputAction: TextInputAction.search,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF545D68),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onSubmitted: (value) => state.setQuery(value)));
  }
}
