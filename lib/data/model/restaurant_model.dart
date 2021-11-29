import 'dart:convert';

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      city: json["city"],
      rating: double.parse(json["rating"].toString())
      // rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

List<Restaurant> parseRestaurant(String json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)["restaurants"];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

RestaurantResult restaurantResultFromJson(String str) =>
    RestaurantResult.fromJson(json.decode(str));

String restaurantResultToJson(RestaurantResult data) =>
    json.encode(data.toJson());

class RestaurantResult {
  RestaurantResult({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from((json["restaurants"] as List)
            .map((x) => Restaurant.fromJson(x))
            .where((restaurants) =>
                restaurants.id != null &&
                restaurants.name != null &&
                restaurants.description != null &&
                restaurants.pictureId != null &&
                restaurants.city != null &&
                restaurants.rating != null)),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
