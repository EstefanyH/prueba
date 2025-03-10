import 'package:flutter/material.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/domain/repository/restaurant.repository.dart';

class RestaurantViewModel extends BaseViewModel with ChangeNotifier {

  final RestaurantRepository repository;

  RestaurantViewModel({required this.repository});

  late var selectedIndex = 0;

  Future<void> init  () async {
    print('RestaurantViewModel');
    selectedIndex = 0;
  }

  void onSelectionToggle (int index) async{
    selectedIndex = index;
    notifyListeners();
  }
}