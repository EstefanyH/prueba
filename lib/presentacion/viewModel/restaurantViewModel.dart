import 'package:flutter/material.dart';

class RestaurantViewModel with ChangeNotifier{
  int selectedIndex = 0;

  Future<void> init  () async {
  
  }

  Future<void> onSelectionToggle (int index) async{
    selectedIndex = index;
    notifyListeners();
  }
}