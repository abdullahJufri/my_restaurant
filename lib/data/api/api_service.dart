import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_restaurant/data/model/restaurant_model.dart';

class ApiService {
  static final baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final list = baseUrl + 'list';
  static final detail = baseUrl + 'detail/';
  static final search = baseUrl + 'search?q=';
  static final smallImage = baseUrl + 'images/small/';
  static final mediumImage = baseUrl + 'images/medium/';
  static final largeImage = baseUrl + 'images/large/';

  Client client;

  ApiService({this.client}) {
    client ??= Client();
  }

  Future<Restaurant> getRestaurant() async {
    final response = await client.get(Uri.parse(baseUrl + list));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
