import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/core/services/permission_service.dart';
import 'package:prueba/data/model/position.model.dart';
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/entities/position.dart';
import 'package:prueba/domain/repository/home.repository.dart';

class HomeViewModel extends BaseViewModel with ChangeNotifier {
  final HomeRepository repository;
  
  HomeViewModel({required this.repository});
  
  late var totPending = 0;
  late var totRegister = 0;
  

  double latitude = 0.0;
  double longitude = 0.0;

  late Timer _timer;

  final List<LatLng> locations = [];
  /*
  final List<LatLng> locations = [
    LatLng(37.7749, -122.4194), // San Francisco
    LatLng(34.0522, -118.2437), // Los Angeles
    LatLng(40.7128, -74.0060),  // New York
    LatLng(51.5074, -0.1278),   // London
  ]; */

  List<Cia> lista = [];

  late LatLng markerPosition;

  Future<void> init(BuildContext ctx) async {
    print('HomeViewModel');
    try {
    totPending = await repository.getTotPending();
    lista = await repository.getTotRegister();
    totRegister = lista.length;

    await getCurrentLocation();
    notifyListeners();
    } catch(xe){
      showMessage(ctx, 'Ocurrio un error intentar mas rato');
    }

  }

  void onGoToNew(BuildContext ctx) async {
     Navigator.pushNamed(ctx, Routermanager.restaurant);
  }

  Future<void> onDownloadType (BuildContext ctx) async {
    try {
      bool isConnect = await PermissionService.isInternetAvailable();
      
      var items = await repository.getTypeLocal();

      if (!items.isEmpty) showMessage(ctx, 'Ya existen elementos');
      else {
        if (isConnect) {
          var result = await repository.getListType();
          if(result == true) {
            showMessage(ctx, 'Se completo descarga');
          }
        } else {
          showMessage(ctx, 'No hay conección a internet');
        }
      }
    } catch(xe) {
      throw Exception(xe);
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;

    serviceEnabled = await PermissionService.checkAndRequestPermissions();
    if (!serviceEnabled) {
      print('No se tienen los permisos necesarios para acceder a la ubicación');
      return;
    }

    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Actualizar los valores de latitud y longitud
    latitude = position.latitude;
    longitude = position.longitude;
    markerPosition = LatLng(latitude, longitude);

    locations.add(markerPosition);
    // Notificar a la vista para que se actualice
    notifyListeners();
  }

   // Método que realiza la consulta en primer plano cada 10 segundos
  void startForegroundTask(BuildContext ctx) {
    _timer = Timer.periodic(Duration(seconds: 20), (timer) async {
      print('Realizando consulta en primer plano...');
      bool isconnect = await PermissionService.isInternetAvailable();
      if (isconnect) {

        totPending = await repository.getTotPending();
        lista = await repository.getTotRegister();
        totRegister = lista.length;

        await repository.getRegisterPending(); 

      } 
      notifyListeners(); // Notifica a la UI que los datos han cambiado
    });
  }

  void goToNewRestaurant(BuildContext ctx, LatLng model ) async {
    
    var  _position = PositionsModel(latitude: model.latitude.toString(), longitude: model.longitude.toString() );
    var data = _position.toJson();
    print('new dato');
    print(data);
    await Navigator.pushNamed(ctx, Routermanager.restaurant, arguments: data);
  }

}