import 'package:flutter/material.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/domain/entities/type_photo.dart';
import 'package:prueba/domain/repository/home.repository.dart';

class HomeViewModel extends BaseViewModel with ChangeNotifier {
  final HomeRepository repository;
  
  HomeViewModel({required this.repository});
  
  late var totPending = 0;
  late var totRegister = 0;
  List<TypePhoto> lista = [];

  Future<void> init() async {
    print('HomeViewModel');
    totPending = await repository.getTotPending();
    totRegister = await repository.getTotRegister();
    notifyListeners();
  }

  void onGoToNew(BuildContext ctx) async {
     Navigator.pushNamed(ctx, Routermanager.restaurant);
  }

  Future<void> onDownloadType (BuildContext ctx) async {
    try {
      var result = await repository.getListType();
      if(result == true) {
        showMessage(ctx, 'Se completo descarga');
      }
      print(lista);
    } catch( xe) {
      print(xe);
    }
  }
}