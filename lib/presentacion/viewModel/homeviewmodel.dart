import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/core/services/permission_service.dart';
import 'package:prueba/domain/repository/home.repository.dart';

class HomeViewModel extends BaseViewModel with ChangeNotifier {
  final HomeRepository repository;
  
  HomeViewModel({required this.repository});
  
  late var totPending = 0;
  late var totRegister = 0;
  
  double latitude = 0.0;
  double longitude = 0.0;

  late LatLng markerPosition;

  Future<void> init(BuildContext ctx) async {
    print('HomeViewModel');
    try {
    totPending = await repository.getTotPending();
    totRegister = await repository.getTotRegister();

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

    // Notificar a la vista para que se actualice
    notifyListeners();
  }

}