import 'package:flutter/material.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/domain/repository/restaurant.repository.dart';

class RestaurantViewModel extends BaseViewModel with ChangeNotifier {

  final RestaurantRepository repository;

  RestaurantViewModel({required this.repository});

  late int selectedIndex = 0;

  Future<void> init  () async {
    print('HomeViewModel');
  }

  Future<void> onSelectionToggle (int index) async{
    selectedIndex = index;
    notifyListeners();
  }
}