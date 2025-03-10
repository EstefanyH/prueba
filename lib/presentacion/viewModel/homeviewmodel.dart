import 'package:flutter/material.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/domain/repository/home.repository.dart';

class HomeViewModel extends BaseViewModel with ChangeNotifier {
  final HomeRepository repository;

  HomeViewModel({required this.repository});
  late var totPending = 0;
  late var totRegister = 0;

  Future<void> init() async {
    print('HomeViewModel');
    totPending = await repository.getTotPending();
    totRegister = await repository.getTotRegister();
    notifyListeners();
  }

  void onGoToNew(BuildContext ctx) async {
     Navigator.pushNamed(ctx, Routermanager.restaurant);
  }
}