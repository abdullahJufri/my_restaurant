import 'package:flutter/foundation.dart';
import 'package:my_restaurant/data/db/db_helper.dart';
import 'package:my_restaurant/data/model/restaurant_model.dart';
import 'package:my_restaurant/utils/result_state.dart';


class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorits();
    if (_favorites.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }

    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
