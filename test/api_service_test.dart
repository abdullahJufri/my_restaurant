import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_restaurant/data/api/api_service.dart';

import 'api_service_test_mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getRestaurantList', () {
    test('return an all restaurant if the http call completes successfully',
            () async {
          final apiService = ApiService();
          final client = MockClient();
          var response =
              '{"error": false, "message": "success", "count": 20, "restaurants": []}';

          when(
            client.get(Uri.parse(ApiService.list)),
          ).thenAnswer((_) async => http.Response(response, 200));

          var restaurantActual = await apiService.getRestaurant(client);
          expect(restaurantActual.message, 'success');
        });

    test('throws an exception if the http call completes with an error',
            () async {
          final client = MockClient();
          final apiService = ApiService();

          when(client.get(Uri.parse(ApiService.list)))
              .thenAnswer((_) async => http.Response('Not Found', 404));

          var actual = apiService.getRestaurant(client);
          expect(actual, throwsException);
        });

    test('throws an exception if the http call completes with an error',
            () async {
          final client = MockClient();
          final apiService = ApiService();

          when(client.get(Uri.parse(ApiService.list)))
              .thenAnswer((_) async =>
          throw const SocketException('No Internet Connection'));

          var actual = apiService.getRestaurant(client);
          expect(actual, throwsException);
        });
  });
}
