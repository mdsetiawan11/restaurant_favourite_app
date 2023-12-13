import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_favourite_app/src/common/constant.dart';
import 'package:restaurant_favourite_app/src/models/restaurant_detail_model.dart';
import 'package:restaurant_favourite_app/src/services/restaurant_services.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;
  String id;

  RestaurantDetailProvider(
      {required this.restaurantServices, required this.id}) {
    _fetchRestaurantDetail();
  }

  late RestaurantDetailModel _restaurantDetailResult;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  RestaurantDetailModel get result => _restaurantDetailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await restaurantServices.getRestaurantDetail(id);
      if (restaurantDetail.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
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
