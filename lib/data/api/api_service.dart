import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:my_restaurant/data/model/restaurant_model.dart';

class ApiService {
  static const baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const list = baseUrl + 'list';
  static const detail = baseUrl + 'detail/';
  static const search = baseUrl + 'search?q=';
  static const smallImage = baseUrl + 'images/small/';
  static const mediumImage = baseUrl + 'images/medium/';
  static const largeImage = baseUrl + 'images/large/';

  Client client;

  ApiService({this.client}) {
    client ??= Client();
  }

  Future<ResponseList> getRestaurant(http.Client client) async {
    final response = await client.get(
      Uri.parse(
        '${ApiService.baseUrl}${ApiService.list}',
      ),
    );

    if (response.statusCode == 200) {
      return ResponseList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Restaurant List!");
    }
  }
}
