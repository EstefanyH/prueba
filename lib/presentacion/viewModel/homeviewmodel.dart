import 'package:flutter/material.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/baseViewModel.dart';

class HomeViewModel extends BaseViewModel with ChangeNotifier {
  
  void onGoToNew(BuildContext ctx) async {
     Navigator.pushNamed(ctx, Routermanager.restaurant);
  }
}