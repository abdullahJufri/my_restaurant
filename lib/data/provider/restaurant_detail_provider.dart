import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_restaurant/data/api/api_connection_service.dart';
import 'package:my_restaurant/data/api/api_service.dart';
import 'package:my_restaurant/data/model/restaurant_detail_model.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class RestoDetailProvider extends ChangeNotifier {
  RestoDetailProvider(this.context, {@required this.id}) {
    _fetchRestoDetailData();
  }

  final String id;
  final BuildContext context;
  final apiService = ApiService();
  final connectionService = ConnectionService();

  String _message = '';
  ResultState _state;
  DetailRestaurantResult _detailRestaurantResult;

  String get message => _message;

  ResultState get state => _state;

  DetailRestaurantResult get result => _detailRestaurantResult;

  Future<dynamic> _fetchRestoDetailData() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final connection = await connectionService.connectionService(context);
      if (!connection.connected) {
        _state = ResultState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await getRestoDetail();
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<DetailRestaurantResult> getRestoDetail() async {
    final response = await http.get(ApiService.detail + id);
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Ugh, seems like we\'re failed to load the resto details');
    }
  }

  void refresh() {
    _fetchRestoDetailData();
    notifyListeners();
  }
}
