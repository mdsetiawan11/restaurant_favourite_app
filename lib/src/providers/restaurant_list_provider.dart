import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_favourite_app/src/common/constant.dart';
import 'package:restaurant_favourite_app/src/models/restaurant_list_model.dart';
import 'package:restaurant_favourite_app/src/services/restaurant_services.dart';

class RestaurantListProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;

  RestaurantListProvider({required this.restaurantServices}) {
    _fetchAllRestaurant();
  }

  late RestaurantListModel _restaurantResult;
  late ResultState _state;

  String _message = '';
  String get message => _message;
  RestaurantListModel get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await restaurantServices.getRestaurantList();
      if (restaurantList!.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantList;
      }
    } catch (e) {
      if (e is SocketException) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'No Internet Connection';
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Failed to Load Data';
      }
    }
  }
}
