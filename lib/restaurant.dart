// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

List<Restaurant> restaurantFromJson(String str) => List<Restaurant>.from(json.decode(str).map((x) => Restaurant.fromJson(x)));

String restaurantToJson(List<Restaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurant {
  Restaurant({
    required this.name,
    required this.address,
    required this.rating,
    required this.description,
    required this.imageAsset,
    required this.imageMenu,
    required this.priceMenu,
    required this.menu,
  });

  String name;
  String address;
  String rating;
  String description;
  String imageAsset;
  List<String> imageMenu;
  List<String> priceMenu;
  List<String> menu;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    name: json["name"],
    address: json["address"],
    rating: json["rating"],
    description: json["description"],
    imageAsset: json["imageAsset"],
    imageMenu: List<String>.from(json["imageMenu"].map((x) => x)),
    priceMenu: List<String>.from(json["priceMenu"].map((x) => x)),
    menu: List<String>.from(json["Menu"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "rating": rating,
    "description": description,
    "imageAsset": imageAsset,
    "imageMenu": List<dynamic>.from(imageMenu.map((x) => x)),
    "priceMenu": List<dynamic>.from(priceMenu.map((x) => x)),
    "Menu": List<dynamic>.from(menu.map((x) => x)),
  };
}


List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
