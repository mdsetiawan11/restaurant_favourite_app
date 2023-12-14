import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_favourite_app/src/models/restaurant_searched_model.dart';
import 'package:restaurant_favourite_app/src/services/restaurant_services.dart';

class SearchRestaurantProv extends ChangeNotifier {
  RestaurantServices restaurantServices = RestaurantServices();
  late RestaurantSearchedModel _restaurantResult =
      RestaurantSearchedModel(error: false, founded: 0, restaurants: []);
  late bool _isLoading = false;
  late String _message = '';
  String get message => _message;
  bool get isLoading => _isLoading;
  RestaurantSearchedModel get result => _restaurantResult;

  Future<dynamic> searchRestaurant(String value) async {
    try {
      _restaurantResult =
          RestaurantSearchedModel(error: true, founded: 0, restaurants: []);
      _isLoading = true;
      notifyListeners();
      final restaurantLists = await restaurantServices.searchRestaurant(value);
      if (restaurantLists.restaurants.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return _message = 'Restaurant or Menu not found';
      } else {
        notifyListeners();
        _isLoading = false;
        return _restaurantResult = restaurantLists;
      }
    } catch (e) {
      if (e is SocketException) {
        _isLoading = false;
        notifyListeners();
        return _message = 'No Internet Connection';
      } else {
        _isLoading = false;
        notifyListeners();
        return _message = 'Failed to Load Data';
      }
    }
  }
}
