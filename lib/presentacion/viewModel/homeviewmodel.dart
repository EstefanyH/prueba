import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/domain/entities/type_photo.dart';
import 'package:prueba/domain/repository/home.repository.dart';

class HomeViewModel extends BaseViewModel with ChangeNotifier {
  final HomeRepository repository;
  
  HomeViewModel({required this.repository});
  
  late var totPending = 0;
  late var totRegister = 0;
  
  double latitude = 0.0;
  double longitude = 0.0;

  late LatLng markerPosition;

  Future<void> init() async {
    print('HomeViewModel');
    totPending = await repository.getTotPending();
    totRegister = await repository.getTotRegister();

    await getCurrentLocation();
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
    } catch( xe) {
      print(xe);
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('El servicio de ubicación no está habilitado');
      return;
    }

    // Verificar permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Los permisos de ubicación no fueron concedidos');
        return;
      }
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